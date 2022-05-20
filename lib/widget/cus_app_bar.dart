import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

///可设置高度和自定义下底部阴影的AppBar，
///去除阴影需[AppBar]的elevation值为0，[shadow]为false
class CusHeightAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  //是否展示阴影效果
  final bool shadow;
  const CusHeightAppBar(
      {Key? key, required this.appBar, this.shadow = true, this.height})
      : super(key: key);
  final Size? height;
  @override
  Widget build(BuildContext context) {
    return shadow
        ? Container(
            decoration: const BoxDecoration(boxShadow: [
              BoxShadow(
                  color: Color(0x0d000000),
                  blurRadius: 15.0,
                  offset: Offset(0, 2))
            ]),
            child: appBar,
          )
        : appBar;
  }

  @override
  Size get preferredSize => height ?? const Size.fromHeight(50);
}

///统一AppBar
PreferredSizeWidget universalAppBar(
    //标题
    String title,
    //是否展示回退图标
    bool leading,
    //回退按钮点击回调
    {VoidCallback? onPressed,
      //背景颜色
    Color? backgroundColor = const Color(0xe6ffffff),
      //右侧导航菜单
    List<Widget>? actions,
      //阴影颜色
    Color? shadowColor = const Color(0x0d000000),
      //立体效果参数
    double? elevation = 0,
      //底部菜单栏
    PreferredSizeWidget? bottom,
      //appbar总高度
    Size? height}) {
  return CusHeightAppBar(
    appBar: AppBar(
      backgroundColor: backgroundColor,
      centerTitle: true,
      title: Text(
        title,
        style: const TextStyle(color: Color(0xff000000), fontSize: 17.0),
      ),
      elevation: elevation,
      shadowColor: shadowColor,
      leading: leading
          ? Builder(
              builder: (BuildContext context) {
                return IconButton(
                  icon: const Icon(
                    Icons.navigate_before,
                    color: Color(0xe6000000),
                  ),
                  onPressed: onPressed,
                  tooltip:
                      MaterialLocalizations.of(context).openAppDrawerTooltip,
                );
              },
            )
          : null,
      actions: actions,
      bottom: bottom,
    ),
    height: height,
  );
}
