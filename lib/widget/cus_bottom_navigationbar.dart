import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
///自定义底部导航菜单Bar
class CusBottomNavigationBar extends StatefulWidget {
  const CusBottomNavigationBar(
      {Key? key,
      required this.items,
      this.onTap,
      this.selectedColor,
      this.unselectedColor,
      this.currentIndex = 0})
      : super(key: key);

  //菜单列表
  final List<CusBottomNavigationBarItem> items;
  //点击item回调
  final ValueChanged<int>? onTap;
  //点击选中颜色
  final Color? selectedColor;
  //没选中颜色
  final Color? unselectedColor;
  //初始化当前所属菜单下标
  final int? currentIndex;
  @override
  State<StatefulWidget> createState() => _CusBottomNavigationBarState();
}

class _CusBottomNavigationBarState extends State<CusBottomNavigationBar> {
  int? _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: Colors.white,
      child: Row(
        children: _items(),
      ),
    );
  }

  ///添加子item
  List<Widget> _items() {
    List<Widget> items = [];
    for (int i = 0; i < widget.items.length; i++) {
      var item = widget.items.elementAt(i);
      items.add(_CusBottomNavigationBarTile(
        iconData: item.iconData,
        title: item.title,
        unreadMsgCount: item.unreadMsgCount,
        select: _currentIndex == i ? true : false,
        onTap: () {
          setState(() {
            _currentIndex = i;
          });
          widget.onTap?.call(i);
        },
      ));
    }
    return items;
  }
}

class CusBottomNavigationBarItem {
  CusBottomNavigationBarItem(
      {this.unreadMsgCount, required this.iconData, required this.title});
  final int? unreadMsgCount;
  final IconData iconData;
  final String title;
}

///导航菜单子item布局
class _CusBottomNavigationBarTile extends StatefulWidget {
  const _CusBottomNavigationBarTile(
      {Key? key,
      this.unreadMsgCount,
      required this.iconData,
      required this.title,
      this.unselectedColor = const Color(0xff969799),
      this.selectedColor = const Color(0xff5974f4),
      this.onTap,
      required this.select})
      : super(key: key);

  //显示的未读消息数量
  final int? unreadMsgCount;
  //菜单icon
  final IconData iconData;
  //菜单标题
  final String title;
  final GestureTapCallback? onTap;
  final Color? selectedColor;
  final Color? unselectedColor;
  final bool select;
  @override
  State<StatefulWidget> createState() => _CusBottomNavigationBarTileState();
}

class _CusBottomNavigationBarTileState
    extends State<_CusBottomNavigationBarTile> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: () {
        widget.onTap?.call();
      },
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 60,
                      height: 30,
                      child: Icon(
                        widget.iconData,
                        size: 30,
                        color: widget.select
                            ? widget.selectedColor
                            : widget.unselectedColor,
                      ),
                    ),
                    Text(widget.title,
                        style: TextStyle(
                            fontSize: 14,
                            color: widget.select
                                ? widget.selectedColor
                                : widget.unselectedColor))
                  ],
                ),
                if (widget.unreadMsgCount != null && widget.unreadMsgCount != 0)
                  Positioned(
                    top: 2,
                    left: 30,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        _subscript(widget.unreadMsgCount!),
                        Text(
                          '${widget.unreadMsgCount}',
                          style: const TextStyle(
                              fontSize: 10, color: Colors.white),
                        )
                      ],
                    ),
                  ),
              ],
            ),
          )
        ],
      ),
    ));
  }

  ///根据角标显示的数字大小选取合适大小的角标
  Widget _subscript(int count) {
    Widget subscript;
    if (count > 0 && count < 10) {//个位数显示
      subscript = ClipOval(
        child: Container(
          width: 16,
          height: 16,
          color: const Color(0xffff3b3b),
        ),
      );
    } else if (count >= 10 && count < 100) {//两位数显示
      subscript = Container(
        width: 22,
        height: 16,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xffff3b3b)),
      );
    } else {//三位数及以上显示
      subscript = Container(
        width: 29,
        height: 16,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8)),
            color: Color(0xffff3b3b)),
      );
    }
    return subscript;
  }
}
