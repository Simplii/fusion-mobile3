import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_action_button.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';

enum Views { Main, DialPad, Hold }

class CallActionButtons extends StatefulWidget {
  CallActionButtons({Key key, this.actions, this.callOnHold}) : super(key: key);

  final Map<String, Function()> actions;
  final bool callOnHold;

  @override
  State<StatefulWidget> createState() => _CallActionButtonsState();
}

class _CallActionButtonsState extends State<CallActionButtons> {
  bool dialPadOpen = false;

  Widget _getMainView() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CallActionButton(
                onPressed: widget.actions['onHoldBtnPress'],
                title: 'Hold',
                icon: CupertinoIcons.pause_solid),
            CallActionButton(
                onPressed: widget.actions['onXferBtnPress'],
                title: 'Xfer',
                icon: CupertinoIcons.phone_fill_arrow_up_right),
            CallActionButton(
                onPressed: () {
                  setState(() {
                    dialPadOpen = !dialPadOpen;
                  });
                  widget.actions['onDialBtnPress']();
                },
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
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CallActionButton(
                onPressed: widget.actions['onRecBtnPress'],
                title: 'Rec',
                icon: CupertinoIcons.smallcircle_fill_circle),
            CallActionButton(
                onPressed: widget.actions['onVidBtnPress'],
                title: 'Video',
                icon: CupertinoIcons.video_camera_solid),
            Expanded(
                child: GestureDetector(
              onTap: widget.actions['onHangup'],
              child: Center(
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)),
                        color: crimsonLight),
                    child: Icon(
                      CupertinoIcons.phone_down_fill,
                      color: Colors.white,
                      size: 35.0,
                    ),
                  )),
            )),
            CallActionButton(
                onPressed: widget.actions['onTextBtnPress'],
                title: 'Text',
                icon: CupertinoIcons.chat_bubble_fill),
            CallActionButton(
                onPressed: widget.actions['onAudioBtnPress'],
                title: 'Audio',
                icon: CupertinoIcons.speaker_2_fill),
          ],
        )
      ],
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
                    setState(() {
                      dialPadOpen = false;
                    });
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

  Widget _getView() {
    if (widget.callOnHold) {
      return _getMainView();
    } else {
      if (dialPadOpen) {
        return _getDialPadView();
      } else {
        return _getMainView();
      }
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
