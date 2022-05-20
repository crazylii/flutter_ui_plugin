import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_tools/widget/cus_app_bar.dart';

class CusTabBarView extends StatelessWidget {
  CusTabBarView({Key? key}) : super(key: key);

  final List<String> tabTitles = ["page1", "page2"];
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabTitles.length,
      child: Scaffold(
        appBar: universalAppBar("TabView", false,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(45),
              child: Material(
                color: Colors.white,
                child: TabBar(
                  tabs: tabTitles
                      .map((e) => Padding(
                          padding: const EdgeInsets.only(top: 13, bottom: 12),
                          child: Text(e)))
                      .toList(),
                  labelColor: const Color(0xff5974f4),
                  labelStyle: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w500),
                  unselectedLabelColor: const Color(0xff969799),
                  unselectedLabelStyle: const TextStyle(fontSize: 14),
                  indicatorSize: TabBarIndicatorSize.label,
                  indicatorColor: const Color(0xff5974f4),
                  onTap: (index) {
                    //点击切换页面时，在此初始化数据逻辑
                  },
                ),
              ),
            ),
            height: const Size.fromHeight(95)),
        body: const TabBarView(
          //禁止左右滑动页面
          physics: NeverScrollableScrollPhysics(),
          children: [
            Center(
              child: Text('page1'),
            ),
            Center(
              child: Text('page2'),
            )
          ],
        ),
      ),
    );
  }
}
