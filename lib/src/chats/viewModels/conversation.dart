import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/backend/fusion_connection.dart';
import 'package:fusion_mobile_revamped/src/chats/viewModels/chatsVM.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/coworkers.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import 'package:fusion_mobile_revamped/src/models/quick_response.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class ConversationVM with ChangeNotifier {
  late String conversationDepartmentId;
  late StreamSubscription wsStream;
  late StreamSubscription<RemoteMessage> notificationStream;
  final FusionConnection fusionConnection = FusionConnection.instance;
  ChatsVM? _chatsVM;
  SMSConversation conversation;

  List<SMSMessage> conversationMessages = [];
  bool loadingMessages = false;
  bool showSnackBar = false;
  DateTime? scheduledAt;
  List<XFile> mediaToSend = [];
  List<QuickResponse> quickResponses = [];
  bool sendingMessage = false;

  ConversationVM({required this.conversation, ChatsVM? chatsVM}) {
    _chatsVM = chatsVM;
    conversationDepartmentId = conversation.getDepartmentId(
      fusionConnection: fusionConnection,
    );
    wsStream = fusionConnection.websocketStream.stream.listen(_updateFromWS);
    notificationStream =
        FirebaseMessaging.onMessage.listen(_onNotificationReceived);
    lookupMessages();
  }

  void _updateFromWS(event) {
    Map<String, dynamic> wsMessage = jsonDecode(event);
    if (wsMessage.containsKey("sms_received") && wsMessage["sms_received"]) {
      wsMessageObject message = wsMessageObject.fromJson(
        wsMessage['message_object'],
      );
      SMSMessage? messageToUpdate = conversationMessages
          .where((m) => int.parse(m.id) == message.id)
          .firstOrNull;
      if (messageToUpdate != null) {
        messageToUpdate.messageStatus = message.messageStatus;
        messageToUpdate.errorMessage = message.errorMessage;
        notifyListeners();
      }
    }
  }

  void _onNotificationReceived(RemoteMessage message) {
    lookupMessages(limit: 20);
  }

  void cancelListeners() {
    wsStream.cancel();
    notificationStream.cancel();
  }

  void lookupMessages({int? limit}) {
    loadingMessages = true;
    notifyListeners();
    fusionConnection.messages.getMessages(
      conversation,
      limit ?? 100,
      0,
      (List<SMSMessage> messages, fromServer) {
        conversationMessages = messages;
        conversationMessages.sort((SMSMessage m1, SMSMessage m2) {
          return m1.unixtime > m2.unixtime ? -1 : 1;
        });
        loadingMessages = false;
        notifyListeners();
      },
      conversationDepartmentId,
    );
  }

  void updateView() {
    //TODO:update conversationListView too
    notifyListeners();
  }

  void assignCoworker(Coworker selectedCoworker) {
    conversation.assigneeUid = selectedCoworker.uid;
    fusionConnection.conversations.storeRecord(conversation);
    fusionConnection.conversations.editConvoAssignment(
      coworkerUid: selectedCoworker.uid,
      convo: conversation,
    );
    notifyListeners();
  }

  Future<bool> renameConversation(String newName) async {
    bool nameUpdated = await fusionConnection.conversations.renameConvo(
      conversation.conversationId ?? 0,
      newName,
    );
    conversation.groupName = newName;
    notifyListeners();
    return nameUpdated;
  }

  Future<void> _updateQuickMessages() async {
    List<QuickResponse> quickRes =
        await fusionConnection.quickResponses.getQuickResponses(
      conversationDepartmentId == DepartmentIds.AllMessages
          ? DepartmentIds.Personal
          : conversationDepartmentId,
    );
    quickResponses = quickRes;
  }

  void onDepartmentChange(String departmentId) async {
    SMSDepartment department =
        fusionConnection.smsDepartments.getDepartment(departmentId);
    if (department.numbers.isNotEmpty) {
      loadingMessages = true;
      conversationDepartmentId = departmentId;
      conversationMessages = [];
      String myNumber = department.numbers.first;
      conversation = await fusionConnection.messages.checkExistingConversation(
        departmentId,
        myNumber,
        [conversation.number],
        conversation.contacts,
      );
      lookupMessages();
      await _updateQuickMessages();
      loadingMessages = false;
      notifyListeners();
    }
  }

  void onPhoneNumberChange(String phoneNumber) async {
    SMSDepartment? department =
        fusionConnection.smsDepartments.getDepartmentByPhoneNumber(phoneNumber);
    if (department != null && department.id != null) {
      loadingMessages = true;
      conversationDepartmentId = department.id!;
      conversationMessages = [];
      String myNumber = phoneNumber;
      conversation = await fusionConnection.messages.checkExistingConversation(
        department.id!,
        myNumber,
        [conversation.number],
        conversation.contacts,
      );
      lookupMessages();
      await _updateQuickMessages();
      loadingMessages = false;
      notifyListeners();
    }
  }

  void sendMessage({
    required SMSConversation conversation,
    required String messageText,
  }) {
    if (messageText.isNotEmpty) {
      if (FusionConnection.isInternetActive) {
        fusionConnection.messages.sendMessage(
          messageText,
          conversation,
          conversationDepartmentId,
          null,
          (SMSMessage message) {
            //success callback
            print("MDBM send message callback");
            conversationMessages.insert(
              0,
              message,
            );
            notifyListeners();
            _chatsVM?.refreshView();
          },
          () {
            // failed callback: LargeMMS
          },
          scheduledAt,
        );
      } else {
        //TODO:Send offline message
        print("MDBM send offline message ");
        print("MDBM internet active= ${FusionConnection.isInternetActive}");
      }
    }
    if (mediaToSend.isNotEmpty) {
      for (XFile file in mediaToSend) {
        fusionConnection.messages.sendMessage(
          '',
          conversation,
          conversationDepartmentId,
          file,
          (message) {
            //success callback
          },
          () {
            // failed callback: LargeMMS
          },
          scheduledAt,
        );
      }
      mediaToSend = [];
    }
    print("MDBM send message");
    notifyListeners();
  }
}
