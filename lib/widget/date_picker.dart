import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
///数据回传
typedef OnSelectValue<T> = Function(T value);
///选择年龄底部弹窗
void showYearPicker(
        {required BuildContext context, OnSelectValue? onSelectValue}) =>
    showCupertinoModalPopup(
        context: context,
        builder: (_) => DatePicker(
              start: 1920,
              onSelectValue: onSelectValue,
            ));
///年份选择
class DatePicker extends StatefulWidget {
  DatePicker({Key? key, required this.start, this.onSelectValue})
      : super(key: key);
  //开始年份
  final int start;
  //结束年份
  final int end = DateTime.now().year;
  //选择的数据回传
  final OnSelectValue? onSelectValue;

  @override
  State<StatefulWidget> createState() => _DataPickerState();
}

class _DataPickerState extends State<DatePicker> {
  FixedExtentScrollController? _scrollController;
  late int value;
  late int length;
  @override
  void initState() {
    super.initState();
    length = widget.end - widget.start + 1;
    var initialItem = length ~/ 2;
    value = widget.start + initialItem;
    _scrollController = FixedExtentScrollController(initialItem: initialItem);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: 325,
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 56,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("取消",
                          style: TextStyle(
                              fontSize: 16, color: Color(0xff969799))),
                    ),
                  ),
                  const Align(
                    alignment: Alignment.center,
                    child: Text(
                      "出生年份",
                      style: TextStyle(fontSize: 16, color: Color(0xff323233)),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        //返回年龄
                        widget.onSelectValue?.call(widget.end - value);
                        Navigator.pop(context);
                      },
                      child: const Text("确定",
                          style: TextStyle(
                              fontSize: 16, color: Color(0xff5974f4))),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: CupertinoPicker(
                scrollController: _scrollController,
                diameterRatio: 2,
                magnification: 1.3,
                squeeze: 0.9,
                useMagnifier: true,
                itemExtent: 49,
                onSelectedItemChanged: (int value) {
                  this.value = widget.start + value;
                },
                children: List.generate(length, (index) {
                  return Center(
                    child: Text(
                      (widget.start + index).toString(),
                      style: const TextStyle(
                          fontSize: 18, color: Color(0xff323233)),
                    ),
                  );
                }),
                selectionOverlay: Container(
                  decoration: const BoxDecoration(
                      border: Border(
                    top: BorderSide(width: 1, color: Color(0xffebebeb)),
                    bottom: BorderSide(width: 1, color: Color(0xffebebeb)),
                  )),
                ),
              ),
            )
          ],
        ));
  }
}
