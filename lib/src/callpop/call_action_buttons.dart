import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/callpop/call_action_button.dart';
import 'package:fusion_mobile_revamped/src/styles.dart';

enum Views { Main, DialPad, Hold }

class CallActionButtons extends StatefulWidget {
  CallActionButtons(
      {Key key,
        this.dialPadOpen,
        this.callIsMuted,
        this.setDialpad,
        this.actions,
        this.callIsRecording,
        this.callOnHold})
      : super(key: key);

  final Map<String, Function()> actions;
  final bool callOnHold;
  final bool callIsRecording;
  final bool dialPadOpen;
  final bool callIsMuted;
  Function(bool) setDialpad;

  @override
  State<StatefulWidget> createState() => _CallActionButtonsState();
}

class _CallActionButtonsState extends State<CallActionButtons> {
  bool get dialPadOpen => widget.dialPadOpen;

  Widget _getMainView(bool onHold) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            if (onHold)
              CallActionButton(
                  onPressed: widget.actions['onResumeBtnPress'],
                  title: 'Resume',
                  icon: Image.asset("assets/icons/call_view/play.png",
                      width: 24, height: 24))
            else
              CallActionButton(
                  onPressed: widget.actions['onHoldBtnPress'],
                  title: 'Hold',
                  icon: Image.asset("assets/icons/call_view/hold.png",
                      width: 24, height: 24)),
            CallActionButton(
                onPressed: widget.actions['onXferBtnPress'],
                title: 'Xfer',
                icon: Image.asset("assets/icons/call_view/transfer.png",
                    width: 24, height: 24)),
            CallActionButton(
                onPressed: () {
                  widget.actions['onDialBtnPress']();
                },
                title: 'Dial',
                icon: Image.asset("assets/icons/call_view/dialpad.png",
                    width: 24, height: 24)),
            CallActionButton(
                onPressed: widget.actions['onParkBtnPress'],
                title: 'Park',
                icon: Image.asset("assets/icons/call_view/park.png",
                    width: 24, height: 24)),
            CallActionButton(
                onPressed: widget.actions['onConfBtnPress'],
                title: 'Conf',
                icon: Image.asset("assets/icons/call_view/conference.png",
                    width: 24, height: 24),
                disabled: onHold),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            CallActionButton(
                onPressed: widget.actions['onRecBtnPress'],
                title: 'Rec',
                icon: Image.asset(
                    widget.callIsRecording
                    ? "assets/icons/call_view/rec_stop.png"
                    : "assets/icons/call_view/rec.png",
                    width: 24, height: 24),
                disabled: onHold),
            CallActionButton(
                onPressed: widget.actions['onVidBtnPress'],
                title: 'Video',
                icon: Image.asset("assets/icons/call_view/video chat.png",
                    width: 24, height: 24),
                disabled: true),
            Expanded(child: _hangupButton()),
            CallActionButton(
                onPressed: widget.actions['onTextBtnPress'],
                title: 'Text',
                icon: Image.asset("assets/icons/call_view/chat text.png",
                    width: 24, height: 24)),
            CallActionButton(
                onPressed: widget.actions['onAudioBtnPress'],
                title: 'Audio',
                icon: Image.asset(
                    widget.callIsMuted
                    ? "assets/icons/call_view/audio_muted.png"
                    : "assets/icons/call_view/audio.png",
                    width: 24, height: 24)),
          ],
        )
      ],
    );
  }

  _hangupButton() {
    return GestureDetector(
      onTap: widget.actions['onHangup'],
      child: Center(
          child: Container(
              decoration: raisedButtonBorder(crimsonLight,
                  darkenAmount: 40, lightenAmount: 60),
              padding: EdgeInsets.all(1),
              child: Container(
                  width: 48,
                  height: 48,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                      color: crimsonLight),
                  child: Image.asset("assets/icons/phone.png",
                      width: 28, height: 28)))),
    );
  }

  Widget _getDialPadView() {
    return ConstrainedBox(
      constraints: BoxConstraints.expand(height: 80),
      child: Row(
        children: [
          Spacer(),
          _hangupButton(),
          Expanded(
              child: GestureDetector(
                  onTap: () {
                    widget.setDialpad(false);
                  },
                  child: Container(
                      alignment: Alignment.center,
                      decoration: clearBg(),
                      child: Text('Hide',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16)))))
        ],
      ),
    );
  }

  Widget _getView() {
    if (widget.callOnHold) {
      return _getMainView(true);
    } else {
      if (widget.dialPadOpen) {
        return _getDialPadView();
      } else {
        return _getMainView(false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget contents = Container(
      padding: EdgeInsets.only(top: 12, bottom: 10),
      decoration: BoxDecoration(
          color: widget.callOnHold || widget.dialPadOpen
              ? Colors.transparent
              : coal.withAlpha((255 * 0.7).round()),
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(8), topRight: Radius.circular(8))),
      child: _getView(),
    );

    if (widget.callOnHold || widget.dialPadOpen)
      return ClipRect(child: contents);
    else
      return ClipRect(
          child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
              child: contents));
  }
}
