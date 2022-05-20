import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_tools/widget/widget_tools.dart';
import 'package:flutter_widget_tools/widget/date_picker.dart';

class CusDatePicker extends StatelessWidget {
  const CusDatePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Row(
          children: [
            Expanded(
              child: elevatedButton(
                  title: '选择日期',
                  onClick: () => showYearPicker(context: context)),
            )
          ],
        ),
      ),
    );
  }
}
