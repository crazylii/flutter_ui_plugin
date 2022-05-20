import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_tools/widget/audio_play_view.dart';
import 'package:flutter_widget_tools/widget/cus_app_bar.dart';

class AudioPlayerViewExample extends StatelessWidget {
  const AudioPlayerViewExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: universalAppBar('音频播放器控件', false),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15, top: 20),
        child: Column(
          children: [
            Row(
              children: const [
                SizedBox(
                  child: Text(
                    '音频播放小控件：',
                    style: TextStyle(
                        fontSize: 15, color: Color(0xff323233)),
                  ),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child:  AudioPlayerView(
                      width: 160,
                      height: 30,
                      alarmAudioUrl: 'http://121.40.242.110:8401/aispeech/ota/6285e81ce4b05c7c8ef04b291652942876549.wav',
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      )
    );
  }

}