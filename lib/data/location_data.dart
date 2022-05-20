///位置级联菜单模拟数据实体类
class LocationData {
  int? code;
  bool? success;
  String? message;
  List<Result>? result;

  LocationData({this.code, this.success, this.message, this.result});

  LocationData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    success = json['success'];
    message = json['message'];
    if (json['result'] != null) {
      result = <Result>[];
      json['result'].forEach((v) {
        result!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = code;
    data['success'] = success;
    data['message'] = message;
    if (result != null) {
      data['result'] = result!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  int? level;
  String? location;
  List<Result>? children;

  Result({this.level, this.location, this.children});

  Result.fromJson(Map<String, dynamic> json) {
    level = json['level'];
    location = json['location'];
    if (json['children'] != null) {
      children = <Result>[];
      json['children'].forEach((v) {
        children!.add(Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['level'] = level;
    data['location'] = location;
    if (children != null) {
      data['children'] = children!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}