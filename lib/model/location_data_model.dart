import 'package:flutter_widget_tools/data/location_data.dart';

///三级菜单数据处理
class LocationDataModel {
  LocationDataModel(this.deviceLocation);
  //三级菜单所有数据
  final LocationData? deviceLocation;

  ///获取所有一级菜单数据
  List<String> getBuilding() {
    var map = <String, String>{};
    deviceLocation?.result?.forEach((element) {
      map.putIfAbsent(element.location!, () => element.location!);
    });
    return map.values.toList(growable: false);
  }

  ///初始化当前菜单选中的楼栋
  ///[currentTitle]当前按钮标题
  int initBuildingIndex(String currentTitle) {
    List<String> builds = getBuilding();
    int initIndex = 0;
    for (int i = 0; i < builds.length; i++) {
      var build = builds.elementAt(i) + '栋';
      if (build == currentTitle) {
        initIndex = i;
        break;
      }
    }
    return initIndex;
  }

  ///根据当前选择的一级菜单数据，获取所有二级菜单数据
  List<String> getUnit(String currentBuilding) {
    var map = <String, String>{};
    deviceLocation?.result?.forEach((element) {
      if (element.location == currentBuilding) {
        element.children?.forEach((second) {
          map.putIfAbsent(second.location!, () => second.location!);
        });
      }
    });
    return map.values.toList()..insert(0, "不限");
  }

  ///根据当前选择的一级菜单二级菜单数据，获取所有的三级菜单数据
  List<String> getFloor(String buildingName, String unit) {
    var map = <String, String>{};
    deviceLocation?.result?.forEach((element) {
      if (buildingName == element.location) {
        element.children?.forEach((second) {
          if (second.location == unit) {
            second.children?.forEach((three) {
              map.putIfAbsent(three.location!, () => three.location!);
            });
          }
        });
      }
    });
    return map.values.toList()..insert(0, "不限");
  }
}
