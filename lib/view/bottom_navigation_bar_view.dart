import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_tools/widget/cus_bottom_navigationbar.dart';

class BottomNavigationBarView extends StatefulWidget {
  const BottomNavigationBarView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _BottomNavigationBarViewState();
}

class _BottomNavigationBarViewState<BottomNavigationBarView> extends State {
  //初始化当前页
  int _selectedIndex = 0;
  //菜单页
  final List<Widget> _widgetOptions = [
    const Center(
      child: Text('page1'),
    ),
    const Center(
      child: Text('page2'),
    ),
    const Center(
      child: Text('page3'),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _widgetOptions.length,
      child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _widgetOptions,
          ),
          bottomNavigationBar: Builder(builder: (context) {
            return CusBottomNavigationBar(
              items: [
                CusBottomNavigationBarItem(
                  iconData: Icons.desktop_windows,
                  title: '设备',
                ),
                CusBottomNavigationBarItem(
                  iconData: Icons.notifications_outlined,
                  title: '消息',
                  unreadMsgCount: 666,
                ),
                CusBottomNavigationBarItem(
                    iconData: Icons.person_outline, title: '我的'),
              ],
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
            );
          })),
    );
  }

  ///点击底部菜单切换页面
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
