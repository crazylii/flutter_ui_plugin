import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_tools/data/location_data.dart';
import 'package:flutter_widget_tools/model/location_data_model.dart';
import 'package:flutter_widget_tools/widget/cus_app_bar.dart';
import 'package:flutter_widget_tools/widget/popup_window_button.dart';

class DropdownButtonView extends StatefulWidget {
  const DropdownButtonView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DropdownButtonViewState();
}

class _DropdownButtonViewState extends State<DropdownButtonView> {
  LocationData? _jsonData;
  @override
  void initState() {
    super.initState();
    // DefaultAssetBundle.of(context).load("key")
    rootBundle.loadString('config/location_data.json').then((value) {
      setState(() {
        _jsonData = LocationData.fromJson(jsonDecode(value));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: universalAppBar('三级下拉菜单按钮', false),
      body: PopupWindowButton(
        title: "区域",
        menuData: LocationDataModel(_jsonData),
        onSelected: (value) {
          // 选择菜单数据回调
        },
        onFinished: () {
          // 点击重置按钮回调
        },
      ),
    );
  }
}
