import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/components/contact_circle.dart';
import 'package:fusion_mobile_revamped/src/components/popup_menu.dart';
import 'package:fusion_mobile_revamped/src/models/dids.dart';
import 'package:fusion_mobile_revamped/src/models/user_settings.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../backend/fusion_connection.dart';
import '../backend/softphone.dart';
import '../models/contact.dart';
import '../styles.dart';
import '../utils.dart';

class Menu extends StatefulWidget {
  final FusionConnection _fusionConnection;
  final Softphone _softphone;
  final List<Did> _dids;

  Menu(this._fusionConnection, this._dids, this._softphone, {Key key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  FusionConnection get _fusionConnection => widget._fusionConnection;
  Softphone get _softphone => widget._softphone;
  List<Did> get _dids => widget._dids;
  bool loggingOut = false;

  _changeDefaultInputDevice() {
    List<List<String>> options = _softphone.devicesList
        .where((element) => element[2] == "Microphone")
        .toList()
        .cast<List<String>>();

    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (contact) => PopupMenu(
            label: "Default Input Device",
            bottomChild: Container(
                constraints: BoxConstraints(
                    minHeight: 24,
                    maxHeight: 200,
                    minWidth: 90,
                    maxWidth: MediaQuery.of(context).size.width - 66),
                child: ListView(
                    padding: EdgeInsets.all(8),
                    children: options.map((List<String> option) {
                      return GestureDetector(
                          onTap: () {
                            _softphone.setDefaultInput(option[1]);
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 8, right: 8),
                              decoration: BoxDecoration(
                                  color: option[1] == _softphone.defaultInput
                                      ? lightHighlight
                                      : Colors.transparent,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightDivider, width: 1.0))),
                              child: Row(children: [
                                Text(option[0],
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                Spacer(),
                                if (_softphone.defaultInput == option[1])
                                  Image.asset(
                                      "assets/icons/call_view/check.png",
                                      width: 16,
                                      height: 11)
                              ])));
                    }).toList()))));
  }

  _changeDefaultOutputDevice() {
    print(_softphone.devicesList);
    List<List<String>> options = Platform.isAndroid ? _softphone.devicesList
        .where((element) => element[2] != "Microphone")
        .toList()
        .cast<List<String>>() : _softphone.devicesList;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (contact) => PopupMenu(
            label: "Default Output Device",
            bottomChild: Container(
                constraints: BoxConstraints(
                    minHeight: 24,
                    maxHeight: 200,
                    minWidth: 90,
                    maxWidth: MediaQuery.of(context).size.width - 66),
                child: ListView(
                    padding: EdgeInsets.all(8),
                    children: options.map((List<String> option) {
                      return GestureDetector(
                          onTap: () {
                            // _softphone.setDefaultOutput(option[1]);
                            _softphone.forceupdateOutputDevice(option[1]);
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 8, right: 8),
                              decoration: BoxDecoration(
                                  color: option[1] == _softphone.defaultOutput
                                      ? lightHighlight
                                      : Colors.transparent,
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightDivider, width: 1.0))),
                              child: Row(children: [
                                Text(option[0].replaceAll('Microphone', 'Earpiece'),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700)),
                                Spacer(),
                                if (_softphone.defaultOutput == option[1])
                                  Image.asset(
                                      "assets/icons/call_view/check.png",
                                      width: 16,
                                      height: 11)
                              ])));
                    }).toList()))));
  }

  _onAudioBtnPress() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (contact) => PopupMenu(
            label: "Default Audio Sources",
            topChild: Column(children: [
              Row(children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _changeDefaultOutputDevice();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                bottom: 4, left: 20, right: 20, top: 6),
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            decoration: BoxDecoration(
                                color: coal,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                      color: translucentBlack(0.28),
                                      offset: Offset.zero,
                                      blurRadius: 36)
                                ]),
                            child: Text(_softphone.defaultOutput.replaceAll('Microphone', 'Earpiece'),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  height: 1.4,
                                )))))
              ]),
              Container(height: 4),
              Row(children: [
                Expanded(
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          _changeDefaultInputDevice();
                        },
                        child: Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.only(
                                bottom: 16, left: 20, right: 20, top: 6),
                            padding: EdgeInsets.only(top: 12, bottom: 12),
                            decoration: BoxDecoration(
                                color: coal,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8)),
                                boxShadow: [
                                  BoxShadow(
                                      color: translucentBlack(0.28),
                                      offset: Offset.zero,
                                      blurRadius: 36)
                                ]),
                            child: Text(_softphone.defaultInput,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  height: 1.4,
                                )))))
              ])
            ]),
            bottomChild: Container(
                constraints: BoxConstraints(
                    minHeight: 24,
                    maxHeight: 200,
                    minWidth: 90,
                    maxWidth: MediaQuery.of(context).size.width - 135),
                child: ListView(padding: EdgeInsets.all(8), children: [
                  GestureDetector(
                      onTap: () {
                        _softphone.toggleEchoCancellationEnabled();
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 18, right: 18),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                  bottom: BorderSide(
                                      color: lightDivider, width: 1.0))),
                          child: Row(children: [
                            Text(
                                (_softphone.echoCancellationEnabled
                                    ? "Disable Echo Cancellation"
                                    : "Enable Echo Cancellation"),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ]))),
                  GestureDetector(
                      onTap: () {
                        _softphone.toggleEchoLimiterEnabled();
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 18, right: 18),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                  bottom: BorderSide(
                                      color: lightDivider, width: 1.0))),
                          child: Row(children: [
                            Text(
                                _softphone.echoLimiterEnabled
                                    ? "Disable Echo Limiter"
                                    : "Enable Echo Limiter",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ]))),
                  GestureDetector(
                      onTap: () {
                        _softphone.calibrateEcho();
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 18, right: 0),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                  bottom: BorderSide(
                                      color: lightDivider, width: 1.0))),
                          child: Row(children: [
                            Text("Calibrate Echo Cancellation",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ]))),
                  GestureDetector(
                      onTap: () {
                        if (_softphone.isTestingEcho)
                          _softphone.stopTestingEcho();
                        else
                          _softphone.testEcho();
                        Navigator.pop(context);
                      },
                      child: Container(
                          padding: EdgeInsets.only(
                              top: 12, bottom: 12, left: 18, right: 18),
                          decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border(
                                  bottom: BorderSide(
                                      color: lightDivider, width: 1.0))),
                          child: Row(children: [
                            Text(
                                _softphone.isTestingEcho
                                    ? "Stop Testing Echo"
                                    : "Test Echo",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w700)),
                          ]))),
                ]))));
  }

  _header() {
    UserSettings settings = _fusionConnection.settings;
    var callid = settings.subscriber.containsKey('callid_nmbr')
        ? settings.subscriber['callid_nmbr']
        : '';
    var user = settings.subscriber.containsKey('user')
        ? settings.subscriber['user']
        : '';
    return Container(
        alignment: Alignment.centerLeft,
        decoration: BoxDecoration(color: bgBlend),
        padding: EdgeInsets.only(top: 72, left: 18, bottom: 12, right: 18),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
              child: ContactCircle.withCoworkerAndDiameter(
                  [settings.myContact()],
                  [],
                  _fusionConnection.coworkers
                      .lookupCoworker(_fusionConnection.getUid()),
                  70)),
          Container(
              margin: EdgeInsets.only(top: 18, bottom: 6),
              child: Text(settings.myContact().name,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700))),
          Container(
              margin: EdgeInsets.only(top: 0, bottom: 12),
              child: Text(
                  ("" + callid).formatPhone() + " " + mDash + " x" + user,
                  style: TextStyle(
                      color: translucentWhite(0.6),
                      fontSize: 14,
                      fontWeight: FontWeight.w500)))
        ]));
  }

  _row(String icon, String label, String smallText, Function onTap, Icon ico) {
    return GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(color: Colors.transparent),
            margin: EdgeInsets.only(left: 18, right: 18, top: 12, bottom: 12),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                  margin: EdgeInsets.only(right: 24),
                  width: 22,
                  height: 22,
                  child: 
                  ico != null 
                    ? ico 
                    : label == "Log Out" && loggingOut 
                      ? CircularProgressIndicator()
                      : Opacity(
                          opacity: icon.contains("call_view") ? 0.45 : 1.0,
                          child: Image.asset("assets/icons/" + icon + ".png",
                              width: 22, height: 22))),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(label,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w700)),
                if (smallText.length > 0) Container(height: 4),
                if (smallText.length > 0)
                  Text(smallText,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: smoke,
                          fontSize: 12,
                          fontWeight: FontWeight.w400))
              ])
            ])));
  }

  _line() {
    return Container(
        margin: EdgeInsets.only(left: 18, right: 18, top: 8, bottom: 8),
        child: Row(children: [
          Container(margin: EdgeInsets.only(right: 24), width: 20, height: 20),
          horizontalLine(12)
        ]));
  }

  _openOutboundDIDMenu() {
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        isScrollControlled: true,
        builder: (contact) => PopupMenu(
            label: "Manage Outbound DID",
            bottomChild: Container(
                constraints: BoxConstraints(
                    minHeight: 100,
                    maxHeight: MediaQuery.of(context).size.height - 250,
                    minWidth: 90,
                    maxWidth: MediaQuery.of(context).size.width),
                child: ListView(
                    padding: EdgeInsets.all(8),
                    children: _dids.map((Did option) {
                      return GestureDetector(
                          onTap: () {
                            _fusionConnection.settings
                                .setOutboundDid(option.did);
                            Navigator.pop(context);
                          },
                          child: Container(
                              padding: EdgeInsets.only(
                                  top: 12, bottom: 12, left: 18, right: 18),
                              decoration: BoxDecoration(
                                  color: (option.did ==
                                          _fusionConnection.settings
                                              .subscriber["callid_nmbr"]
                                      ? lightHighlight
                                      : Color.fromARGB(0, 0, 0, 0)),
                                  border: Border(
                                      bottom: BorderSide(
                                          color: lightDivider, width: 1.0))),
                              child: Row(children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      (option.did + "").formatPhone(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Container(height: 6),
                                    Text(
                                        option.notes.replaceFirst(
                                            RegExp(r"^ *-[ 0-9]+- *"), ""),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: Colors.white60,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500))
                                  ],
                                ),
                                Spacer(),
                                if (option.did ==
                                    _fusionConnection
                                        .settings.subscriber["callid_nmbr"])
                                  Image.asset("assets/icons/check_white.png",
                                      width: 16, height: 11)
                              ])));
                    }).toList()))));
  }
  void _editProfilePic (){
    showModalBottomSheet(
      context: context, 
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) => PopupMenu(
        label: "Source",
        bottomChild: Container(
          height: 100,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: ()=>_selectImage("camera"),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom:10,
                    top: 14,
                    left: 12),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: lightDivider, width: 1.0))
                  ),
                  child: Text('Camera', 
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: ()=>_selectImage("photos"),
                child: Container(
                  padding: EdgeInsets.only(
                    bottom:10,
                    top: 14,
                    left: 12),
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: lightDivider, width: 1.0))
                  ),
                  child: Text('Photos', 
                    style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void _uploadPic (XFile image, id){
    _fusionConnection.contacts.uploadProfilePic("profile", image, id, (Contact contact){
      setState(() {
        
      });
    });
  }

  void _selectImage(String source){
    final ImagePicker _picker = ImagePicker();
    final Contact user = _fusionConnection.settings.myContact();
    if (source == "camera") {
      _picker.pickImage(source: ImageSource.camera).then((XFile image) {

        setState(() {
          if(image == null) return;
          _uploadPic(image, user.id);
        });
      });
    } else {
      _picker.pickImage(source: ImageSource.gallery).then((XFile image) {
        if(image == null) return;
        _uploadPic(image, user.id);
      });
    }
  }

  Future<void> _clearCache() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Clear Cache'),
          content: Text('This action will clear all app data in your phone and log you out.'),
          actions: <Widget>[
            TextButton(
              child: Text('Continue', style: TextStyle(color: crimsonDark),),
              onPressed: () async {
                _fusionConnection.clearCache().then((value){
                  if(Platform.isIOS){
                    Navigator.of(context).pop();
                  }
                });
              },
            ),
            TextButton(
              child: const Text('Cancel', style: TextStyle(color: Colors.black),),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  _body() {
    List<Widget> response = [
      _row("phone_outgoing", "Manage Outbound DID", "", () {
        _openOutboundDIDMenu();
      }, null),

      _row("call_view/audio_phone", "Audio Settings", "", () {
        _onAudioBtnPress();
      }, null),
      
      _row("", "Edit Profile Picture", "", _editProfilePic, 
        Icon(Icons.edit, size: 22, color: smoke.withOpacity(0.45),)),

      _row("", "Clear Cache", "", _clearCache, 
        Icon(Icons.cached, size: 22, color: smoke.withOpacity(0.45),)),

      // _row("gear_light", "Settings", "Coming soon", () {}),
      _line(),
      _row("moon_light", "Log Out", "", () {
        setState(() {
          loggingOut = true;
        });
        _fusionConnection.logOut();
      },null)
    ];
    return response;
  }

  @override
  Widget build(BuildContext context) {
    bool isFusionPlus = _fusionConnection.settings.hasFusionPlus();
    return Drawer(
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/fill.jpg"), fit: BoxFit.cover),
                color: bgBlend),
            child: Column(children: [
              _header(),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(top: 12),
                      decoration: BoxDecoration(color: coal),
                      child: ListView(children: _body()))),
              Container(
                  decoration: BoxDecoration(color: coal),
                  padding:
                      EdgeInsets.only(left: 18, right: 18, bottom: 24, top: 12),
                  child: Row(children: [
                    Image.asset("assets/simplii_logo.png",
                        width: 125, height: 18),
                    Expanded(child: Container()),
                    Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.only(
                            left: 8, right: 8, bottom: 4, top: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            border: Border.all(color: halfSmoke, width: 1.0)),
                        child: Column(
                          children: [
                            Text(isFusionPlus ? "Fusion Plus" : "Fusion",
                            style: TextStyle(
                                color: halfSmoke,
                                fontStyle: FontStyle.italic,
                                fontSize: 11,
                                fontWeight: FontWeight.w700)),
                            Text("v."+_softphone.appVersion,
                            style: TextStyle(
                                color: halfSmoke,
                                fontStyle: FontStyle.italic,
                                fontSize: 9,
                                fontWeight: FontWeight.w700),
                            )
                          ],
                        ))
                  ]))
            ])));
  }
}
