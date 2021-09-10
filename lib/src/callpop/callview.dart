import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/callpop/callactionbutton.dart';

class CallView extends StatefulWidget {
  CallView({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CallViewState();
}

class _CallViewState extends State<CallView> {
  var callerName = 'Unknown';
  var callerOrigin = '801-345-9792'; // 'mobile' | 'work' ...etc
  var callRunTime = '00:37'; // get call start time and calculate duration

  onHoldBtnPress() {}

  onXferBtnPress() {}

  onDialBtnPress() {}

  onParkBtnPress() {}

  onConfBtnPress() {}

  onRecBtnPress() {}

  onVidBtnPress() {}

  onTextBtnPress() {}

  onAudioBtnPress() {}

  onHangupBtnPress() {}

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints.expand(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            child: Column(
              children: [
                Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(callerName,
                                style: TextStyle(
                                    fontSize: 32,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600)),
                            Icon(
                              CupertinoIcons.pencil,
                              color: Colors.grey,
                            )
                          ]),
                      Text(callerOrigin,
                          style: TextStyle(fontSize: 14, color: Colors.white))
                    ])),
                Text(callRunTime,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w500))
              ],
            ),
          ),
          Spacer(),
          Container(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
            decoration: BoxDecoration(
                color: Colors.white10, borderRadius: BorderRadius.circular(10)),
            child: ClipRect(
                child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: GridView.count(
                        crossAxisCount: 5,
                        shrinkWrap: true,
                        children: [
                          CallActionButton(
                              onPressed: onHoldBtnPress,
                              title: 'Hold',
                              icon: CupertinoIcons.pause_solid),
                          CallActionButton(
                              onPressed: onXferBtnPress,
                              title: 'Xfer',
                              icon: CupertinoIcons.phone_fill_arrow_up_right),
                          CallActionButton(
                              onPressed: onDialBtnPress,
                              title: 'Dial',
                              icon: Icons.dialpad),
                          CallActionButton(
                              onPressed: onParkBtnPress,
                              title: 'Park',
                              icon: CupertinoIcons.car_detailed),
                          CallActionButton(
                              onPressed: onConfBtnPress,
                              title: 'Conf',
                              icon: CupertinoIcons.plus),
                          CallActionButton(
                              onPressed: onRecBtnPress,
                              title: 'Rec',
                              icon: CupertinoIcons.smallcircle_fill_circle),
                          CallActionButton(
                              onPressed: onVidBtnPress,
                              title: 'Video',
                              icon: CupertinoIcons.video_camera_solid),
                          RawMaterialButton(
                            onPressed: onHangupBtnPress,
                            elevation: 2.0,
                            fillColor: Colors.redAccent,
                            child: Icon(
                              CupertinoIcons.phone_down_fill,
                              color: Colors.white,
                              size: 35.0,
                            ),
                            padding: EdgeInsets.all(15.0),
                            shape: CircleBorder(),
                          ),
                          CallActionButton(
                              onPressed: onTextBtnPress,
                              title: 'Text',
                              icon: CupertinoIcons.chat_bubble_fill),
                          CallActionButton(
                              onPressed: onAudioBtnPress,
                              title: 'Audio',
                              icon: CupertinoIcons.speaker_2_fill)
                        ]))),
          ),
          Container(
            color: Colors.white,
            padding: EdgeInsets.fromLTRB(15, 15, 15, 40),
            child: Row(
              children: [Text('crms and disposition button')],
            ),
          )
        ],
      ),
    );
  }
}
