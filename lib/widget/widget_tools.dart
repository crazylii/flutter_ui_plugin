import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

///上拉刷新下拉加载
Widget refresh() {
  return StatefulBuilder(
    builder: (BuildContext context, void Function(void Function()) setState) {
      RefreshController refreshController = RefreshController();
      return SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: const WaterDropHeader(),
        footer: const ClassicFooter(),
        controller: refreshController,
        onRefresh: () => Future.delayed(const Duration(seconds: 2),
            () => refreshController.refreshToIdle()),
        onLoading: () => Future.delayed(
            const Duration(seconds: 2), () => refreshController.loadComplete()),
        child: const SingleChildScrollView(),
      );
    },
  );
}

///网格布局
Widget gridView() {
  return Padding(
    padding: const EdgeInsets.all(16),
    child: GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 12.0, //竖轴item间隔
          mainAxisSpacing: 11.0, //横轴item间隔
          childAspectRatio: 0.9, //item宽高比例
          crossAxisCount: 3 //列数
          ),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.green),
        );
      },
      itemCount: 20,
    ),
  );
}

///多样式富文本展示
Widget htmlRichText() {
  return RichText(
    text: const TextSpan(
      text: '有人在呼救',
      style: TextStyle(fontSize: 14, color: Color(0xff999999)),
      children: <TextSpan>[
        TextSpan(
            text: '【快来人呐】',
            style: TextStyle(
                fontSize: 14,
                color: Color(0xff333333),
                fontWeight: FontWeight.bold)),
        TextSpan(
            text: '，请及时处理',
            style: TextStyle(fontSize: 14, color: Color(0xff999999))),
      ],
    ),
  );
}

Widget elevatedButton({String? title, VoidCallback? onClick}) {
  return ElevatedButton(
    child: Text(
      '$title',
      style: const TextStyle(fontSize: 16, color: Colors.white),
    ),
    style: OutlinedButton.styleFrom(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      backgroundColor: const Color(0xff5974f4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
    ),
    onPressed: () {
      onClick?.call();
    },
  );
}

///自适应输入框
///支持高度自适应，自动换行，
///支持限定最大字数
///支持展示预输入文本
Widget autoAdjustInputBox() {
  String text = '这是预输入文本';
  return StatefulBuilder(builder: (context, setState) {
    return Padding(
      padding: const EdgeInsets.only(right: 80, left: 80, top: 60),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: const Color(0xfff7f8fa),
            border: Border.all(
                color: const Color(0xffebebeb),
                width: 1,
                style: BorderStyle.solid)),
        child: TextField(
          controller: text.isEmpty ? null : TextEditingController(text: text),
          style: const TextStyle(
              fontSize: 14, color: Color(0xff323233), height: 1.5),
          maxLines: null,
          maxLength: 15,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration.collapsed(
            hintText: '请输入内容...',
            hintStyle: text.isEmpty
                ? const TextStyle(fontSize: 14, color: Color(0xffcccccc))
                : const TextStyle(
                    fontSize: 14, color: Color(0xff323233), height: 1.5),
          ),
          onChanged: (value) {
            if (value.isEmpty) {
              setState.call(() {
                text = value;
              });
            } else {
              text = value;
            }
          },
        ),
      ),
    );
  });
}

///仿ios底部pop弹窗
Widget bottomPop(BuildContext context) {
  return Padding(
    padding: const EdgeInsets.only(top: 100),
    child: Row(
      children: [
        Expanded(
            child: Container(
          color: Colors.white,
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 6, bottom: 6),
          child: ElevatedButton(
            onPressed: () {
              showCupertinoModalPopup(
                  barrierColor: const Color(0x66000000),
                  context: context,
                  builder: (context) {
                    return Material(
                      color: const Color(0x00FFFFFF),
                      child: Container(
                        padding: const EdgeInsets.only(right: 7, left: 7),
                        height: 175,
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Colors.white),
                                child: Column(
                                  children: [
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        //点击菜单处理
                                        Navigator.pop(context);
                                      },
                                      child: const SizedBox(
                                        child: Center(
                                          child: Text(
                                            '误报警',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff5974f4)),
                                          ),
                                        ),
                                      ),
                                    )),
                                    Container(
                                      height: 1,
                                      color: const Color(0xffebebeb),
                                    ),
                                    Expanded(
                                        child: InkWell(
                                      onTap: () {
                                        //点击菜单处理
                                        Navigator.pop(context);
                                      },
                                      child: const SizedBox(
                                        child: Center(
                                          child: Text(
                                            '已处理',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xff5974f4)),
                                          ),
                                        ),
                                      ),
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Container(
                                decoration: const BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(8)),
                                    color: Colors.white),
                                height: 44,
                                child: const Center(
                                  child: Text(
                                    '取消',
                                    style: TextStyle(
                                        fontSize: 16, color: Color(0xff323233)),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 34,
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            },
            child: const Text(
              '处理报警',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.only(top: 10, bottom: 10),
              backgroundColor: const Color(0xff5974f4),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
            ),
          ),
        ))
      ],
    ),
  );
}
