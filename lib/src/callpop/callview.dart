import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fusion_mobile_revamped/src/callpop/callactionbutton.dart';

class CallView extends StatefulWidget {
  CallView({Key? key}) : super(key: key);

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
    return Column(
      children: [
        Container(
          child: Column(
            children: [
              Text(callerName, style: TextStyle(fontSize: 32)),
              Text(callerOrigin, style: TextStyle(fontSize: 14)),
              Text(callRunTime, style: TextStyle(fontSize: 18))
            ],
          ),
        ),
        Container(
            child: Column(
          children: [
            Row(
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
              ],
            ),
            Row(
              children: [
                CallActionButton(
                    onPressed: onRecBtnPress,
                    title: 'Rec',
                    icon: CupertinoIcons.smallcircle_fill_circle),
                CallActionButton(
                    onPressed: onVidBtnPress,
                    title: 'Video',
                    icon: CupertinoIcons.video_camera_solid),
                CallActionButton(
                    onPressed: onHangupBtnPress,
                    title: '',
                    icon: CupertinoIcons.phone_down_fill),
                CallActionButton(
                    onPressed: onTextBtnPress,
                    title: 'Text',
                    icon: CupertinoIcons.chat_bubble_fill),
                CallActionButton(
                    onPressed: onAudioBtnPress,
                    title: 'Audio',
                    icon: CupertinoIcons.speaker_2_fill),
              ],
            )
          ],
        )),
        Container(
          child: Row(
            children: [Text('crms and disposition button')],
          ),
        )
      ],
    );
  }
}
