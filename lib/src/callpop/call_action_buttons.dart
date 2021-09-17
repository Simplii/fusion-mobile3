import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_action_button.dart';

enum Views { Main, DialPad, Hold }

class CallActionButtons extends StatefulWidget {
  CallActionButtons({Key key, this.actions}) : super(key: key);

  final Map<String, Function()> actions;

  @override
  State<StatefulWidget> createState() => _CallActionButtonsState();
}

class _CallActionButtonsState extends State<CallActionButtons> {
  Views currentView = Views.Main;

  Widget _getMainView() {
    return GridView.count(crossAxisCount: 5, shrinkWrap: true, children: [
      CallActionButton(
          onPressed: widget.actions['onHoldBtnPress'],
          title: 'Hold',
          icon: CupertinoIcons.pause_solid),
      CallActionButton(
          onPressed: widget.actions['onXferBtnPress'],
          title: 'Xfer',
          icon: CupertinoIcons.phone_fill_arrow_up_right),
      CallActionButton(
          onPressed: widget.actions['onDialBtnPress'],
          title: 'Dial',
          icon: Icons.dialpad),
      CallActionButton(
          onPressed: widget.actions['onParkBtnPress'],
          title: 'Park',
          icon: CupertinoIcons.car_detailed),
      CallActionButton(
          onPressed: widget.actions['onConfBtnPress'],
          title: 'Conf',
          icon: CupertinoIcons.plus),
      CallActionButton(
          onPressed: widget.actions['onRecBtnPress'],
          title: 'Rec',
          icon: CupertinoIcons.smallcircle_fill_circle),
      CallActionButton(
          onPressed: widget.actions['onVidBtnPress'],
          title: 'Video',
          icon: CupertinoIcons.video_camera_solid),
      RawMaterialButton(
        onPressed: widget.actions['onHangup'],
        elevation: 2.0,
        fillColor: Colors.redAccent,
        child: Icon(
          CupertinoIcons.phone_down_fill,
          color: Colors.white,
          size: 35.0,
        ),
        shape: CircleBorder(),
      ),
      CallActionButton(
          onPressed: widget.actions['onTextBtnPress'],
          title: 'Text',
          icon: CupertinoIcons.chat_bubble_fill),
      CallActionButton(
          onPressed: widget.actions['onAudioBtnPress'],
          title: 'Audio',
          icon: CupertinoIcons.speaker_2_fill)
    ]);
  }

  Widget _getHoldView() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 80),
      child: Row(
        children: [
          Spacer(),
          RawMaterialButton(
            onPressed: widget.actions['onHangup'],
            elevation: 2.0,
            fillColor: Colors.redAccent,
            child: Icon(
              CupertinoIcons.phone_down_fill,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
          ),
          Spacer()
        ],
      ),
    );
  }

  Widget _getDialPadView() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 80),
      child: Row(
        children: [
          Spacer(),
          RawMaterialButton(
            onPressed: widget.actions['onHangup'],
            elevation: 2.0,
            fillColor: Colors.redAccent,
            child: Icon(
              CupertinoIcons.phone_down_fill,
              color: Colors.white,
              size: 35.0,
            ),
            shape: CircleBorder(),
          ),
          Expanded(
              child: TextButton(
                  onPressed: () {
                    _changeView(Views.Main);
                  },
                  child: Text('Hide',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16))))
        ],
      ),
    );
  }

  void _changeView(Views view) {
    setState(() {
      currentView = view;
    });
  }

  Widget _getView() {
    if (currentView == Views.Hold) {
      return _getHoldView();
    } else if (currentView == Views.DialPad) {
      return _getDialPadView();
    } else {
      return _getMainView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
      decoration: BoxDecoration(
          color: Colors.white10, borderRadius: BorderRadius.circular(10)),
      child: ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: _getView())),
    );
  }
}
