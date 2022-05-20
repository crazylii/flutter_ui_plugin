import 'package:flutter/material.dart';

///未开启蓝牙、配网成功提示
class EnableBluetoothDialog extends Dialog {
  const EnableBluetoothDialog(
      {Key? key, required this.title, required this.content, this.buttonTxt})
      : super(key: key);

  final String title;
  final String content;
  final String? buttonTxt;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 315,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 17, color: Color(0xff323233)),
            ),
            const SizedBox(
              height: 40,
            ),
            Text(
              content,
              style: const TextStyle(fontSize: 16, color: Color(0xff323233)),
            ),
            const SizedBox(
              height: 60,
            ),
            SizedBox(
              height: 1,
              child: Container(
                color: const Color(0xffe1e1e1),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                buttonTxt ?? "确定",
                style: const TextStyle(fontSize: 16, color: Color(0xff5974f4)),
              ),
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(
                      const EdgeInsets.only(top: 10, bottom: 10))),
            )
          ],
        ),
      ),
    );
  }
}

///配网等待提示
class ConnectWaitDialog extends Dialog {
  const ConnectWaitDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.positive,
      required this.negative,
      this.onPositive,
      this.onNegative})
      : super(key: key);

  final String title;
  final String content;
  final String positive;
  final String negative;
  //确认回调
  final VoidCallback? onPositive;
  final VoidCallback? onNegative;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 315,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 17, color: Color(0xff323233)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 34, right: 34),
                child: Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xff69696c),
                  ),
                )),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
              height: 1,
              child: Container(
                color: const Color(0xffe1e1e1),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onNegative?.call();
                  },
                  child: Text(
                    negative,
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xff69696c)),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(top: 10, bottom: 10))),
                )),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left:
                              BorderSide(width: 1, color: Color(0xffe1e1e1)))),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onPositive?.call();
                    },
                    child: Text(
                      positive,
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xff5974f4)),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(top: 10, bottom: 10))),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

///配网等待提示，html超文本样式展示
class TextSpanConnectWaitDialog extends Dialog {
  const TextSpanConnectWaitDialog(
      {Key? key,
      required this.title,
      required this.content,
      required this.positive,
      required this.negative,
      this.onPositive,
      this.onNegative})
      : super(key: key);

  final String title;
  final String content;
  final String positive;
  final String negative;
  //确认回调
  final VoidCallback? onPositive;
  final VoidCallback? onNegative;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 315,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 17, color: Color(0xff323233)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
                padding: const EdgeInsets.only(left: 34, right: 34),
                child: /*Text(
                  content,
                  style: const TextStyle(
                    fontSize: 15,
                    color: Color(0xff69696c),
                  ),
                )*/
                    RichText(
                  text: TextSpan(
                    text: '您选择的监控区域为',
                    style: const TextStyle(
                      fontSize: 15,
                      color: Color(0xff69696c),
                    ),
                    children: <TextSpan>[
                      TextSpan(
                          text: '【$content】',
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color(0xff5974f4),
                              fontWeight: FontWeight.bold)),
                      const TextSpan(
                          text: '，非监控区域的报警信息，将不再推送给您。确定保存此区域？',
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xff69696c),
                          )),
                    ],
                  ),
                )),
            const SizedBox(
              height: 26,
            ),
            SizedBox(
              height: 1,
              child: Container(
                color: const Color(0xffe1e1e1),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onNegative?.call();
                  },
                  child: Text(
                    negative,
                    style:
                        const TextStyle(fontSize: 16, color: Color(0xff69696c)),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(top: 10, bottom: 10))),
                )),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left:
                              BorderSide(width: 1, color: Color(0xffe1e1e1)))),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onPositive?.call();
                    },
                    child: Text(
                      positive,
                      style: const TextStyle(
                          fontSize: 16, color: Color(0xff5974f4)),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(top: 10, bottom: 10))),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

///退出当前账户
class ExitAppDialog extends Dialog {
  const ExitAppDialog({Key? key, required this.content, this.onPressed})
      : super(key: key);

  final String content;

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 315,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 60,
            ),
            Text(
              content,
              style: const TextStyle(
                fontSize: 17,
                color: Color(0xff323233),
              ),
            ),
            const SizedBox(
              height: 52,
            ),
            SizedBox(
              height: 1,
              child: Container(
                color: const Color(0xffe1e1e1),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "取消",
                    style: TextStyle(fontSize: 16, color: Color(0xff69696c)),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(top: 10, bottom: 10))),
                )),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left:
                              BorderSide(width: 1, color: Color(0xffe1e1e1)))),
                  child: TextButton(
                    onPressed: onPressed,
                    child: const Text(
                      "确定",
                      style: TextStyle(fontSize: 16, color: Color(0xff5974f4)),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(top: 10, bottom: 10))),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

///单输入框dialog
class SingleEditDialog extends Dialog {
  const SingleEditDialog(this.deviceName, {Key? key, this.onPositive})
      : super(key: key);
  final String deviceName;
  final OnPositive? onPositive;
  @override
  Widget build(BuildContext context) {
    String? currentName;
    return Center(
      child: Container(
        width: 315,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            const Text(
              "修改设备名称",
              style: TextStyle(fontSize: 17, color: Color(0xff323233)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: TextField(
                style: const TextStyle(fontSize: 16, color: Color(0xff323233)),
                decoration: InputDecoration(
                    contentPadding: const EdgeInsets.only(
                        top: 12, bottom: 12, left: 16, right: 16),
                    isCollapsed: true,
                    hintText: deviceName,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color(0xffe1e1e1),
                    ))),
                onChanged: (v) {
                  currentName = v;
                },
              ),
            ),
            const SizedBox(
              height: 28,
            ),
            SizedBox(
              height: 1,
              child: Container(
                color: const Color(0xffe1e1e1),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "取消",
                    style: TextStyle(fontSize: 16, color: Color(0xff69696c)),
                  ),
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(
                          const EdgeInsets.only(top: 10, bottom: 10))),
                )),
                Expanded(
                    child: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                          left:
                              BorderSide(width: 1, color: Color(0xffe1e1e1)))),
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      if (currentName != null) {
                        onPositive?.call(currentName);
                      }
                    },
                    child: const Text(
                      "确定",
                      style: TextStyle(fontSize: 16, color: Color(0xff5974f4)),
                    ),
                    style: ButtonStyle(
                        padding: MaterialStateProperty.all(
                            const EdgeInsets.only(top: 10, bottom: 10))),
                  ),
                ))
              ],
            )
          ],
        ),
      ),
    );
  }
}

typedef OnPositive<T> = void Function(T value);
