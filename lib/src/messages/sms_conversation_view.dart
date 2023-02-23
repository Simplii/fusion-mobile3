import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fusion_mobile_revamped/src/backend/softphone.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/components/fusion_dropdown.dart';
import 'package:fusion_mobile_revamped/src/contacts/contact_profile_view.dart';
import 'package:fusion_mobile_revamped/src/models/contact.dart';
import 'package:fusion_mobile_revamped/src/models/conversations.dart';
import 'package:fusion_mobile_revamped/src/models/crm_contact.dart';
import 'package:fusion_mobile_revamped/src/models/messages.dart';
import 'package:fusion_mobile_revamped/src/models/sms_departments.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

import '../backend/fusion_connection.dart';
import '../contacts/edit_contact_view.dart';
import '../styles.dart';
import '../utils.dart';

class SMSConversationView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final SMSConversation _smsConversation;
  final Softphone _softphone;
  final Function(SMSConversation, SMSMessage) _deleteConvo;
  SMSConversationView(
      this._fusionConnection, this._softphone, this._smsConversation, this._deleteConvo,
      {Key key})
      : super(key: key);

  static openConversation(
      BuildContext context,
      FusionConnection fusionConnection,
      List<Contact> contacts,
      List<CrmContact> crmContacts,
      Softphone softphone,
      String phoneNumber,
      Function _deleteConvo) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (context) => SMSConversationView(
            fusionConnection,
            softphone,
            SMSConversation.build(
                contacts: contacts,
                crmContacts: crmContacts,
                myNumber: fusionConnection.smsDepartments
                    .getDepartment("-2")
                    .numbers[0],
                number: phoneNumber),
            _deleteConvo));
  }

  @override
  State<StatefulWidget> createState() => _SMSConversationViewState();
}

class _SMSConversationViewState extends State<SMSConversationView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  Softphone get _softphone => widget._softphone;

  SMSConversation get _conversation => widget._smsConversation;
  TextEditingController _messageInputController = TextEditingController();
  bool _loaded = false;
  List<XFile> _mediaToSend = [];
  List<SMSMessage> _messages = [];
  List<String> _savedImgPaths = [];
  String _selectedGroupId = "";
  Timer _debounceMessageInput;
  int textLength = 0;
  Function(SMSConversation, SMSMessage) get _deleteConvo => widget._deleteConvo;
  initState() {
    super.initState();
    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      String savedMessage =
          prefs.getString(_conversation.hash + "_savedMessage");
      _messageInputController.text = savedMessage;

      final String path = getApplicationDocumentsDirectory().toString();
      List<String> savedImgs =
          prefs.getStringList(_conversation.hash + "_savedImages");
      if (savedImgs != null) {
        savedImgs.map((e) => {_mediaToSend.add(XFile("$path/$e"))});
      }
    });

    if (_fusionConnection.smsDepartments.lookupRecord("-2") != null) {
      _loaded = true;
    }
    _fusionConnection.smsDepartments.getDepartments((List<SMSDepartment> list) {
      if (!mounted) return;
      this.setState(() {
        _loaded = true;
      });
    });

    SMSDepartment department = _fusionConnection.smsDepartments
        .getDepartmentByPhoneNumber(_conversation.myNumber);
    this.setState(() {
      _selectedGroupId = department.id;
    });
  }

  @override
  void dispose() {
    _debounceMessageInput?.cancel();
    super.dispose();
  }

  _openMedia(SMSMessage message) {
    showModalBottomSheet(
        context: context,
        backgroundColor: translucentBlack(0.3),
        isScrollControlled: true,
        builder: (context) {
          return _mediaGallery(message);
        });
  }

  _mediaGallery(SMSMessage activeMessage) {
    List<SMSMessage> galleryItems = _messages
        .where((SMSMessage message) {
          return message.mime != null && message.mime.contains("image") || message.mime != null &&
              message.mime.contains("video");
        })
        .toList()
        .cast<SMSMessage>();
    int currentPage = 0;

    int index = 0;
    for (SMSMessage m in galleryItems) {
      if (m == activeMessage) currentPage = index;
      index += 1;
    }

    PageController pageController = PageController(initialPage: currentPage);

    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            child: PhotoViewGallery.builder(
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                SMSMessage message = galleryItems[index];
                if (message.mime.contains("image"))
                  return PhotoViewGalleryPageOptions(
                    imageProvider: NetworkImage(message.message),
                    initialScale: PhotoViewComputedScale.contained * 0.8,
                    heroAttributes:
                        PhotoViewHeroAttributes(tag: galleryItems[index].id),
                  );
                else
                  return PhotoViewGalleryPageOptions.customChild(
                      initialScale: PhotoViewComputedScale.contained * 0.8,
                      heroAttributes:
                          PhotoViewHeroAttributes(tag: galleryItems[index].id),
                      child: VideoPlayer(
                          VideoPlayerController.network(message.message)));
              },
              itemCount: galleryItems.length,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes,
                  ),
                ),
              ),
              backgroundDecoration: BoxDecoration(color: Colors.transparent),
              pageController: pageController,
              onPageChanged: (int page) {},
            )));
  }
 
  _header() {
    String myImageUrl = _fusionConnection.myAvatarUrl();
  
    List<Widget> singleMessageHeader = [
      ContactCircle(_conversation.contacts, _conversation.crmContacts),
      Expanded(child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(_conversation.contactName(), style: headerTextStyle)),
          Align(
          alignment: Alignment.centerLeft,
          child: Text(_conversation.number.formatPhone(),
              style: subHeaderTextStyle))]
        )
      ),
    ];
    
    Widget groupMessageHeader = 
      Expanded(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8,7,8,3),
          child: LimitedBox(
          maxHeight: 50,
          maxWidth: 50,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: _conversation.contacts.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              String imageUrl = _conversation.contacts[index].pictures.length > 0 
              ? _conversation.contacts[index].pictures.last['url'] 
              : avatarUrl(_conversation.contacts[index].firstName, 
                _conversation.contacts[index].lastName);
              return Align(
                widthFactor: 0.6,
                child: ClipRRect(
                  borderRadius:BorderRadius.circular(60),
                  child: Container(
                      height:50,
                      width: 50,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius:BorderRadius.circular(60),
                          border: Border.all(color: particle, width: 2),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(imageUrl)
                          )
                        ),
                      )
                  ),
                ),
              );
            },
          ),
      ),
        )
    );
    List<Contact> unknowContacts = 
      _conversation.contacts.where((contact) => contact.id == '').toList();
    List<List<String>> contactsToAdd = List.generate(unknowContacts.length, 
      (index) => ["Add ${unknowContacts[index].name} as new contact", 
      "addContact-${index} "], 
         growable: false);

    return Column(children: [
      Center(
          child: Container(
              decoration: BoxDecoration(
                  color: halfSmoke,
                  borderRadius: BorderRadius.all(Radius.circular(3))),
              width: 36,
              height: 5)),
      Row(children: [
        if(_conversation.isGroup)
          groupMessageHeader,
        if(!_conversation.isGroup)
          ...singleMessageHeader,
        if(!_conversation.isGroup)
        IconButton(
            icon: Opacity(
                opacity: 0.66,
                child: Image.asset(
                  "assets/icons/phone_dark.png",
                  width: 20,
                  height: 20,
                )),
            onPressed: () {
              Navigator.pop(context);
              widget._softphone.makeCall(_conversation.number);
            }),
        FusionDropdown(
            onChange: (String chosen) {
              if (chosen == "contactprofile") {
                Future.delayed(Duration(milliseconds: 10), () {
                  showModalBottomSheet(
                      context: context,
                      backgroundColor: Colors.transparent,
                      isScrollControlled: true,
                      builder: (context) => ContactProfileView(
                          _fusionConnection,
                          _softphone,
                          _conversation.contacts[0]));
                });
              } else if (chosen == "deleteconversation") {
                if(_deleteConvo != null){
                  _deleteConvo(_conversation,null);
                  _fusionConnection.conversations.deleteConversation(
                      _conversation,
                      _selectedGroupId);
                }
                Navigator.pop(context, true);
              } else if (chosen.contains("addContact")) {
                int chosenUnknownContactIndex = int.parse(chosen.split('-').last);
                Future.delayed(Duration(milliseconds: 10), () {
                  showModalBottomSheet(
                    constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height - 50),
                    context: context,
                    backgroundColor: particle,
                    isScrollControlled: true,
                    builder: (context) => EditContactView(
                      _fusionConnection, 
                      unknowContacts[chosenUnknownContactIndex], 
                      (){
                        Navigator.pop(context, true);
                      },
                      (){
                       setState(() {
                         print("MyDebugMessage created");
                       });
                      }
                    ));
                });
              } else {
                Future.delayed(Duration(milliseconds: 10), () {
                  _openMedia(null);
                });
              }
            },
            value: "",
            options: _conversation.contacts.length > 0
                ? [
                    ["Open Contact Profile", "contactprofile"],
                    ["Shared Media", "sharedmedia"],
                    ["Delete Conversation", "deleteconversation"],
                    ...contactsToAdd
                  ]
                : [
                    ["Shared Media", "sharedmedia"],
                    ["Delete Conversation", "deleteconversation"]
                  ],
            label: _conversation.contactName(),
            button: IconButton(
                iconSize: 32,
                icon: Image.asset(
                  "assets/icons/three_dots.png",
                  width: 4,
                  height: 16,
                )))
      ]),
      Row(children: [horizontalLine(16)]),
      Row(children: [
        Expanded(child: Container()),
        Align(alignment: Alignment.centerRight, child: _departmentName()),
      ])
    ]);
  }

  // _departmentNumbers() {
  //   SMSDepartment dept =
  //       _fusionConnection.smsDepartments.lookupRecord(_selectedGroupId);
  //   List<List<String>> opts = [];

  //   for (String number in dept.numbers) {
  //     opts.add([number.formatPhone(), number.onlyNumbers()]);
  //   }

  //   return opts;
  // }

  _departmentName() {
    List departments = _fusionConnection.smsDepartments.allDepartments();

    List<List<String>> options = [];

    for (SMSDepartment department in departments) {
      if (department.id == "-2") {
        continue;
      }
      options.add([department.groupName, department.id]);
    }

    return Container(
        decoration: dropdownDecoration,
        padding: EdgeInsets.only(top: 0, bottom: 0, right: 0, left: 8),
        height: 36,
        child: FusionDropdown(
            departments: departments,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            value: _selectedGroupId,
            selectedNumber: _conversation.myNumber,
            options: options,
            onChange: _onDepartmentChange,
            onNumberTap: _onNumberSelect,
            label: "All Departments"));
  }

  _onDepartmentChange(String newDeptId) {
    SMSDepartment dept =
        _fusionConnection.smsDepartments.getDepartment(newDeptId);
    setState(() {
      _conversation.myNumber = dept.numbers[0];
      _selectedGroupId = newDeptId;
    });
  }
  
  _onNumberSelect(String newNumber) {
    SMSDepartment dept =
        _fusionConnection.smsDepartments.getDepartmentByPhoneNumber(newNumber);
    setState(() {
      _conversation.myNumber = newNumber;
      _selectedGroupId = dept.id;
    });
  }

  _saveImageLocally(XFile image) async {
    final String path = await getApplicationDocumentsDirectory().toString();

    String imgExt = p.extension(path);
    String imagePath =
        _conversation.hash + "_savedImage_" + randomString(10) + "." + imgExt;

    _savedImgPaths.add(imagePath);

    SharedPreferences.getInstance().then((SharedPreferences prefs) {
      prefs.setStringList(_conversation.hash + "_savedImages", _savedImgPaths);
    });

    image.saveTo('$path/$imagePath');
  }

  _attachImage(String source) {
    final ImagePicker _picker = ImagePicker();
    if (source == "camera") {
      _picker.pickImage(source: ImageSource.camera).then((XFile file) {
        if (file != null) {
          this.setState(() {
            _mediaToSend.add(file);
            _saveImageLocally(file);
          });
        }
      });
    } else if (source == 'videos') {
      _picker.pickVideo(source: ImageSource.gallery).then((XFile file) {
        if (file != null) {
          this.setState(() {
            _mediaToSend.add(file);
            _saveImageLocally(file);
          });
        }
      });
    } else if (source == 'recordvideo') {
      _picker.pickVideo(source: ImageSource.camera).then((XFile file) {
        if (file != null) {
          this.setState(() {
            _mediaToSend.add(file);
            _saveImageLocally(file);
          });
        }
      });
    } else {
      _picker.pickMultiImage().then((List<XFile> images) {
        this.setState(() {
          if (images != null) {
            images.forEach((file) {
              this.setState(() {
                _mediaToSend.add(file);
                _saveImageLocally(file);
              });
            });
          }
        });
      });
    }
  }

  _mediaToSendViews() {
    return _mediaToSend
        .map((XFile media) {
          return Container(
              margin: EdgeInsets.only(right: 8),
              child: Stack(alignment: Alignment.topRight, children: [
                ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(4),
                        topRight: Radius.circular(4),
                        bottomLeft: Radius.circular(4),
                        bottomRight: Radius.circular(4)),
                    child: (media.name.toLowerCase().contains("png") ||
                            media.name.toLowerCase().contains("gif") ||
                            media.name.toLowerCase().contains("jpg") ||
                            media.name.toLowerCase().contains("jpeg") ||
                            media.name.toLowerCase().contains("jiff"))
                        ? Image.file(File(media.path), height: 100)
                        : Container(
                            height: 100,
                            width: 100,
                            color: particle,
                            alignment: Alignment.center,
                            child: Text("attachment",
                                style: TextStyle(color: coal)))),
                GestureDetector(
                    onTap: () {
                      this.setState(() {
                        _mediaToSend.remove(media);
                      });
                    },
                    child: Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(top: 8, right: 8),
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                            color: char,
                            borderRadius: BorderRadius.all(Radius.circular(11)),
                            border: Border.all(color: Colors.white, width: 2)),
                        child: Icon(CupertinoIcons.xmark,
                            color: Colors.white, size: 12)))
              ]));
        })
        .toList()
        .cast<Widget>();
  }

  _saveLocalState(lastMessage) {
    if (_debounceMessageInput?.isActive ?? false)
      _debounceMessageInput.cancel();
    _debounceMessageInput = Timer(const Duration(milliseconds: 1000), () {
      SharedPreferences.getInstance().then((SharedPreferences prefs) {
        prefs.setString(_conversation.hash + "_savedMessage", lastMessage);
      });
    });
  }

  _sendMessageInput() {
    return Container(
        decoration: BoxDecoration(color: particle),
        padding: EdgeInsets.only(
            top: 12,
            left: 8,
            bottom: (iphoneIsLarge() &&
                    MediaQuery.of(context).viewInsets.bottom == 0)
                ? 32
                : 12,
            right: 8),
        child: Row(children: [
          FusionDropdown(
              onChange: (String value) {
                _attachImage(value);
              },
              value: "",
              options: [
                ["Camera", "camera"],
                ["Record Videos", "recordvideo"],
                ["Videos", "videos"],
                ["Photos", "photos"]
              ],
              label: "From which source?",
              button: Container(
                  height: 18,
                  width: 22,
                  margin: EdgeInsets.only(right: 12, left: 4, top: 0),
                  child: IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Image.asset("assets/icons/camera.png",
                          height: 18, width: 22)))),
          Expanded(
              child: Stack(children: [
            if (_mediaToSend != null && _mediaToSend.length > 0)
              Container(
                  height: 120,
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: Color.fromARGB(255, 229, 227, 227), width: 1),
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(8))),
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _mediaToSendViews())),
            Container(
                padding: EdgeInsets.only(left: 14, right: 14, top: 0),
                margin: EdgeInsets.only(top: _mediaToSend.length > 0 ? 119 : 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: Color.fromARGB(255, 229, 227, 227), width: 1),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(_mediaToSend.length > 0 ? 0 : 8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )),
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  controller: _messageInputController,
                  maxLines: 10,
                  minLines: 1,
                  onChanged: (String changedTo) {
                    if (_messageInputController.text.length - textLength > 1){
                      SharedPreferences.getInstance().then((SharedPreferences prefs) {
                        String imageUri = prefs.getString("copiedImagePath");
                        if(imageUri.length == 0){
                          this.setState(() {
                            _saveLocalState(changedTo);
                          });
                        }else {
                          setState(() {
                            _mediaToSend.add(XFile('$imageUri'));
                            _messageInputController.text = '';
                            Clipboard.setData(ClipboardData(text: ''));
                          });
                        }
                      },);
                    }else {
                      setState(() {
                        _saveLocalState(changedTo);
                      });
                    }
                    textLength = _messageInputController.text.length;
                  },
                  decoration: const InputDecoration(
                      contentPadding:
                          EdgeInsets.only(left: 0, right: 0, top: 2, bottom: 2),
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                          fontSize: 14,
                          color: Color.fromARGB(255, 153, 148, 149)),
                      hintText: "Message"),
                ))
          ])),
          Container(
              height: 40,
              width: 40,
              margin: EdgeInsets.only(left: 8),
              child: IconButton(
                padding: EdgeInsets.all(0),
                icon: Image.asset(
                    _hasEnteredMessage()
                        ? "assets/icons/send_active.png"
                        : "assets/icons/send.png",
                    height: 40,
                    width: 40),
                onPressed: _sendMessage,
              ))
        ]));
  }

  _hasEnteredMessage() {
    return _mediaToSend.length > 0 ||
        _messageInputController.value.text.trim().length > 0;
  }

  _sendMessage() {
    setState(() {
      if (_messageInputController.value.text.trim().length > 0) {
        _fusionConnection.messages
            .sendMessage(
              _messageInputController.value.text, 
              _conversation, 
              _selectedGroupId, 
              null
            );
        _messageInputController.text = "";
      }
      if (_mediaToSend.length > 0) {
        for (XFile file in _mediaToSend) {
          _fusionConnection.messages.sendMessage('', _conversation,_selectedGroupId,file);
        }
        _mediaToSend = [];
      }
      _saveLocalState("");
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    return Container(
        child: Column(children: [
          Expanded(
              child: Container(
                  decoration: BoxDecoration(color: Colors.transparent),
                  padding: EdgeInsets.only(top: 80, bottom: 0),
                  child: Column(children: [
                    Container(
                        decoration: BoxDecoration(
                            color: particle,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16))),
                        padding: EdgeInsets.only(
                            top: 10, left: 14, right: 14, bottom: 12),
                        child: _header()),
                    Row(children: [
                      Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 222, 221, 221)),
                              height: 1))
                    ]),
                    Expanded(
                        child: Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Row(children: [
                              Expanded(
                                  child: _loaded
                                      ? ConvoMessagesList(
                                          _fusionConnection, _conversation,
                                          (List<SMSMessage> messages) {
                                          _messages = messages;
                                        }, _openMedia,_deleteConvo, _selectedGroupId)
                                      : Container())
                            ]))),
                  ]))),
          _sendMessageInput()
        ]),
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom));
  }
}

class ConvoMessagesList extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final SMSConversation _conversation;
  final Function(List<SMSMessage>) _onPulledMessages;
  final Function(SMSMessage) _openMedia;
  final Function(SMSConversation, SMSMessage) _deleteConvo;
  String _selectedGroupId;
  ConvoMessagesList(this._fusionConnection, this._conversation,
      this._onPulledMessages, this._openMedia, this._deleteConvo, this._selectedGroupId,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ConvoMessagesListState();
}

class _ConvoMessagesListState extends State<ConvoMessagesList> {
  SMSConversation get _conversation => widget._conversation;

  FusionConnection get _fusionConnection => widget._fusionConnection;

  Function(SMSMessage) get _openMedia => widget._openMedia;
  Function(SMSConversation, SMSMessage) get _deleteMessage => widget._deleteConvo;
  int lookupState = 0; // 0 - not looking up; 1 - looking up; 2 - got results
  List<SMSMessage> _messages = [];
  String _subscriptionKey;
  String get _selectedGroupId => widget._selectedGroupId;
  String _lookedupNumber = "";
  String _lookedupMyNumber = "";

  @override
  dispose() {
    _clearSubscription();
    super.dispose();
  }

  _clearSubscription() {
    if (_subscriptionKey != null) {
      _fusionConnection.messages.clearSubscription(_subscriptionKey);
      _subscriptionKey = null;
    }
  }

  _addMessage(SMSMessage message) {
    bool matched = false;

    for (SMSMessage savedMessage in _messages) {
      if (savedMessage.id == message.id) {
        matched = true;
      }
    }

    if (!matched) {
      _messages.add(message);
    }
  }


  _lookupMessages() {
    lookupState = 1;
    _clearSubscription();
    _subscriptionKey = _fusionConnection.messages.subscribe(_conversation,
        (List<SMSMessage> messages) {
          
      if (!mounted) return;
      this.setState(() {
        for (SMSMessage m in messages) {
          _addMessage(m);
        }
      });
    });
    _fusionConnection.messages.getMessages(_conversation, 200, 0,
        (List<SMSMessage> messages, fromServer) {
      if (!mounted) return;
      this.setState(() {
        if (fromServer) lookupState = 2;
        _messages = messages;
        widget._onPulledMessages(_messages);
      });
    },_selectedGroupId);
  }

  _newConvoMessage() {
    return [
      Container(
          alignment: Alignment.center,
          padding: EdgeInsets.only(bottom: 24, top: 24, left: 48, right: 48),
          //constraints: BoxConstraints(maxWidth: 170),
          child: this.lookupState < 2
              ? Center(child: SpinKitThreeBounce(color: smoke, size: 50))
              : Text(
                  "This is the beginning of your text history with " +
                      _conversation.contactName(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: smoke,
                      fontSize: 14,
                      height: 1.4,
                      fontWeight: FontWeight.w400,
                      fontStyle: FontStyle.italic)))
    ];
  }

  _messagesList() {
    List<Widget> list = [];
    DateTime lastDate;
    Widget toAdd;

    _messages.sort((SMSMessage m1, SMSMessage m2) {
      return m1.unixtime > m2.unixtime ? -1 : 1;
    });

    for (SMSMessage msg in _messages) {
      DateTime thisTime =
          DateTime.fromMillisecondsSinceEpoch(msg.unixtime * 1000);

      if (lastDate == null ||
          thisTime.difference(lastDate).inHours.abs() > 24) {
        lastDate = thisTime;

        if (toAdd != null) {
          list.add(toAdd);
        }

        toAdd = Row(children: [
          horizontalLine(8),
          Container(
              margin: EdgeInsets.only(left: 4, right: 4, bottom: 12, top: 12),
              child: Text(
                DateFormat("E MMM d, y").format(thisTime),
                style: TextStyle(
                    color: char, fontSize: 12, fontWeight: FontWeight.w700),
              )),
          horizontalLine(8)
        ]);
      }
      list.add(SMSMessageView(_fusionConnection, msg, _conversation,
          (SMSMessage message) {
        _openMedia(message);
      },_deleteMessage,_messages,_selectedGroupId));
    }

    return list;
  }

  @override
  Widget build(BuildContext context) {
    if (lookupState != 0 &&
        (_conversation.number != _lookedupNumber ||
            _conversation.myNumber != _lookedupMyNumber)) {
      lookupState = 0;
      _messages = [];
    }

    if (lookupState == 0) {
      _lookedupNumber = _conversation.number;
      _lookedupMyNumber = _conversation.myNumber;
      _lookupMessages();
    }

    return ListView(
        children: _messages.length == 0 ? _newConvoMessage() : _messagesList(),
        reverse: true);
  }
}

class SMSMessageView extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final SMSMessage _message;
  final SMSConversation _conversation;
  final Function(SMSMessage) _openMedia;
  final Function(SMSConversation, SMSMessage) _deleteMessage;
  List<SMSMessage> _messages;
  String _selectedGroupId;
  SMSMessageView(this._fusionConnection, this._message, this._conversation,
      this._openMedia, this._deleteMessage, this._messages, this._selectedGroupId,
      {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _SMSMessageViewState();
}

class _SMSMessageViewState extends State<SMSMessageView> {
  FusionConnection get _fusionConnection => widget._fusionConnection;

  SMSConversation get _conversation => widget._conversation;

  SMSMessage get _message => widget._message;
  final _searchInputController = TextEditingController();

  final GlobalKey<TooltipState> tooltipkey = GlobalKey<TooltipState>();
  List<SMSMessage> get _messages => widget._messages;
  _openMedia() {
    widget._openMedia(_message);
  }

  _deleteMessage(SMSMessage message){
    if(widget._deleteMessage == null) return;
    if(_messages.length == 1)
      widget._deleteMessage(_conversation,null);
    else if(_messages.reversed.last.id == message.id)
      widget._deleteMessage(_conversation,_messages.reversed.elementAt(_messages.length - 2));
    
    _messages.removeWhere((msg) => msg.id == message.id);
  }

  _messageText(String message, TextStyle style) {
    final urlRegExp = new RegExp(
        r"((https?:www\.)|(https?:\/\/)|(www\.))[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9]{1,6}(\/[-a-zA-Z0-9()@:%_\+.~#?&\/=]*)?");
    final urlMatches = urlRegExp.allMatches(message).toList();

    int start = 0;
    List<TextSpan> texts = [];

    for (RegExpMatch urlMatch in urlMatches) {
      if (urlMatch.start > start) {
        texts.add(TextSpan(
            text: message.substring(start, urlMatch.start), style: style));
      }
      TapGestureRecognizer recognizer = new TapGestureRecognizer();
      recognizer.onTap = () {
        launch(message.substring(urlMatch.start, urlMatch.end));
      };
      texts.add(TextSpan(
          text: message.substring(urlMatch.start, urlMatch.end),
          style: TextStyle(color: crimsonDark),
          recognizer: recognizer));
      start = urlMatch.end;
    }

    texts.add(TextSpan(text: message.substring(start), style: style));

    return new SelectableText.rich(TextSpan(children: texts));
  }

  _renderMessage() {
    bool isFromMe = _message.from == _conversation.myNumber;
    double maxWidth =
        (MediaQuery.of(context).size.width - (isFromMe ? 0 : 40)) * 0.8;
    return Align(
        alignment: isFromMe ? Alignment.centerRight : Alignment.centerLeft,
        child: _message.mime != null &&
                _message.mime.toString().contains('image')
            ? GestureDetector(
                onLongPress: () async {
                  await Clipboard.setData(ClipboardData(text: _message.message));
                  Clipboard.getData(Clipboard.kTextPlain)
                    .then((value){
                      if(value.text != ''){
                        tooltipkey.currentState?.ensureTooltipVisible();
                        urlToXFile(Uri.parse(value.text)).then((value) {
                          SharedPreferences.getInstance().then((SharedPreferences prefs) {
                            prefs.setString("copiedImagePath", value.path);
                          });
                        },);
                      }
                    });
                },
                onTap: _openMedia,
                child: ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(isFromMe ? 8 : 0),
                        topRight: Radius.circular(isFromMe ? 0 : 8),
                        bottomLeft: Radius.circular(8),
                        bottomRight: Radius.circular(8)),
                    child: FittedBox(
                          child: Container(
                            constraints: BoxConstraints(
                              minWidth: 1,
                              minHeight: 1,
                            ),
                            /*decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fitWidth,
                                    image: */
                            child: Tooltip(
                              message:'Copied',
                              key: tooltipkey,
                              triggerMode: TooltipTriggerMode.manual,
                              child: Image.network(_message.message),
                            )
                          )
                        )
                      )) //))
            : Container(
                constraints: BoxConstraints(maxWidth: maxWidth),
                margin: EdgeInsets.only(top: 2),
                padding:
                    EdgeInsets.only(left: 16, right: 16, top: 6, bottom: 8),
                decoration: BoxDecoration(
                    color: isFromMe ? particle : coal,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(isFromMe ? 8 : 0),
                      topRight: Radius.circular(isFromMe ? 0 : 8),
                      bottomLeft: Radius.circular(8),
                      bottomRight: Radius.circular(8),
                    )),
                child: _messageText(
                    _message.message,
                    TextStyle(
                        fontSize: 14,
                        height: 1.4,
                        fontWeight: FontWeight.w400,
                        color: isFromMe ? coal : Colors.white))));
  }

  @override
  Widget build(BuildContext context) {
    DateTime date =
        DateTime.fromMillisecondsSinceEpoch(_message.unixtime * 1000);

    List<Widget> children = [];

    

    if (_message.from != _conversation.myNumber) {
      List<Contact> matchedContact;
      _conversation.contacts.forEach((element){
        Contact c = element;
        bool match = false;
        for (var numberObj in c.phoneNumbers) {
          if(_message.from == numberObj['number']){
            match = true;
            break;
          }
        }
        if(match){
          matchedContact = [element];
        }
      });
      children.add(ContactCircle.withDiameter(
          matchedContact ?? _conversation.contacts, _conversation.crmContacts, 44));
      children.add(Expanded(
          child: Column(children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Text(DateFormat.jm().format(date),
                style: TextStyle(
                    fontSize: 10, fontWeight: FontWeight.w800, color: smoke))),
        _renderMessage()
      ])));
    } else {
      children.add(Expanded(
          child: Column(children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: 
                _message.messageStatus == 'delivered' 
                  ? Icon (Icons.check,size: 10, color:smoke,)
                  : _message.messageStatus == 'failed'
                    ? Icon(Icons.clear,size: 10, color: smoke,)
                    : Container(),
              ),
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Text(DateFormat.jm().format(date),
                    style: TextStyle(
                        fontSize: 10, fontWeight: FontWeight.w800, color: smoke))),
          ],
        ),
        
        _renderMessage()
      ])));
    }

    return Dismissible(
      key: UniqueKey(),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _fusionConnection.messages.deleteMessage(this._message.id,widget._selectedGroupId);
        _deleteMessage(this._message);
        if(this._messages.length == 0){
          Navigator.pop(context);
        }
      },
      background: Container(
        color: crimsonDark,
        child: Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
      ),
      child: Container(
          decoration: BoxDecoration(color: Colors.white),
          margin: EdgeInsets.only(bottom: 18),
          padding: EdgeInsets.only(left: 16, right: 16),
          child: Row(children: children)),
    );
  }
}
