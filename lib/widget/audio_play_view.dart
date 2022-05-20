import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:video_player/video_player.dart';
///录音播放器
class AudioPlayerView extends StatefulWidget {
  const AudioPlayerView(
      {Key? key, this.width, this.height, required this.alarmAudioUrl})
      : super(key: key);
  //宽
  final double? width;
  //高
  final double? height;
  //音频网络地址
  final String alarmAudioUrl;

  @override
  State<StatefulWidget> createState() => _AudioPlayerViewState();
}

class _AudioPlayerViewState extends State<AudioPlayerView> {
  VideoPlayerController? _controller;
  bool _initializing = true;
  @override
  void initState() {
    super.initState();
    //播放器初始化
    _controller = VideoPlayerController.network(widget.alarmAudioUrl)
      ..initialize().then((value) {
        if (mounted) {
          setState(() {
            _initializing = false;
          });
        }
      });
    _controller?.addListener(() {
      //刷新当前进度条
      if (mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _initializing
        ? const Text('正在下载录音...',
            style: TextStyle(
                fontSize: 15,
                color: Color(0xff323233),
                fontWeight: FontWeight.w600))
        : Container(
            width: widget.width,
            height: widget.height,
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 8, bottom: 8),
            decoration: const BoxDecoration(
                color: Color(0xfff3f3f3),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: _controller == null || !_controller!.value.isInitialized
                ? Container()
                : Row(
                    children: [
                      InkWell(
                          onTap: () {
                            //点击播放、暂停按钮
                            if (_controller!.value.isPlaying) {
                              _controller?.pause().then((value) {
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                            } else {
                              _controller?.play().then((value) {
                                if (mounted) {
                                  setState(() {});
                                }
                              });
                            }
                          },
                          child: _controller!.value.isPlaying
                              ? Image.asset(
                                  'images/icon_stop_record.png',
                                  width: 30,
                                  height: 30,
                                )
                              : Image.asset(
                                  'images/icon_start_record.png',
                                  width: 30,
                                  height: 30,
                                )),
                      const SizedBox(width: 8),
                      Expanded(
                        child: NeumorphicSlider(//进度条
                          height: 4,
                          min: 0,
                          max: _controller!.value.duration.inMilliseconds
                              .toDouble(),
                          value: _controller!.value.position.inMilliseconds
                              .toDouble(),
                          thumb: ClipOval(//进度游标
                            child: Container(
                              width: 6,
                              height: 5,
                              color: const Color(0xff5974f4),
                            ),
                          ),
                          style: const SliderStyle(
                            // variant: Colors.white,
                            // accent: Colors.white,
                            variant: Color(0xffd9d9d9),
                            accent: Color(0xffd9d9d9),
                          ),
                          onChanged: (value) {},
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                          "${_controller!.value.duration.inSeconds.toDouble()}s",
                          style: const TextStyle(
                              color: Color(0xcc333333), fontSize: 10)),
                    ],
                  ),
          );
  }

  @override
  void dispose() {
    //释放控制器
    _controller?.dispose();
    super.dispose();
  }
}
