import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_tools/data/location_data.dart';
import 'package:flutter_widget_tools/model/location_data_model.dart';

// const double _kMenuScreenPadding = 8.0;
typedef PopupWindowMenuItemSelected<T> = void Function(T value);

///下拉弹出菜单按钮
class PopupWindowButton extends StatefulWidget {
  const PopupWindowButton(
      {Key? key,
      this.offset = Offset.zero,
      required this.title,
      required this.menuData,
      this.titleFontSize = 16.0,
      this.expandIcon = Icons.expand_more,
      this.expandIconSize = 16.0,
      this.normalColor = Colors.black,
      this.selectColor = const Color(0xff5974f4),
      this.duration = const Duration(milliseconds: 200),
      this.expandHeight = 352.0,
      this.padding = const EdgeInsets.only(left: 15, top: 15, bottom: 15),
      this.onSelected,
      this.onFinished})
      : super(key: key);
  final Offset offset;
  //标题
  final String title;
  //标题字体尺寸
  final double titleFontSize;
  //下拉图标
  final IconData expandIcon;
  //下拉图标大小
  final double expandIconSize;
  //正常颜色
  final Color normalColor;
  //展开选中颜色
  final Color selectColor;
  //动画时间
  final Duration duration;
  //下拉菜单展开高度
  final double expandHeight;
  //按钮内边距
  final EdgeInsetsGeometry padding;
  //菜单所有数据
  final LocationDataModel menuData;
  //选择数据后回调
  final PopupWindowMenuItemSelected<String>? onSelected;
  //清空数据时回调
  final VoidCallback? onFinished;
  @override
  State<StatefulWidget> createState() => _PopupWindowButtonState();
}

class _PopupWindowButtonState extends State<PopupWindowButton>
    with SingleTickerProviderStateMixin {
  //遮盖层展示动画控制器
  late final AnimationController _animationController;
  //遮盖层展示动画
  late final Animation _animation;
  //下拉按钮翻转动画
  late final Animation _rotationAnimation;
  //背景层颜色透明度变换动画
  late final Animation _backgroundColorAnimation;
  //主体部分按钮、字体颜色变换动画
  late final Animation _colorAnimation;
  AnimationStatus _currentAnimationStatus = AnimationStatus.dismissed;
  //遮盖层，即弹出层
  OverlayEntry? overlayEntry;
  bool show = false;

  ///展示伸展菜单
  void showPopupMenuLayout() {
    _animationController.forward();
    final RenderBox button = context.findRenderObject() as RenderBox;
    final RenderBox overlay =
        Navigator.of(context).overlay!.context.findRenderObject()! as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(widget.offset, ancestor: overlay),
        button.localToGlobal(
            button.size.bottomRight(Offset.zero) + widget.offset,
            ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );
    overlayEntry = OverlayEntry(builder: (context) {
      return CustomSingleChildLayout(
        delegate: _PopupMenuRouteLayoutDelegate(
            textDirection: TextDirection.ltr,
            position: position,
            padding: EdgeInsets.zero),
        child: Stack(
          children: [
            //背景阴影层
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return Opacity(
                  opacity: _backgroundColorAnimation.value,
                  child: child,
                );
              },
              child: Material(
                child: InkWell(
                  onTap: () {
                    //点击外部背景层时，反向动画
                    if (_currentAnimationStatus == AnimationStatus.completed) {
                      _animationController.reverse();
                    }
                  },
                  child: Container(
                    color: Colors.black,
                  ),
                ),
              ),
            ),
            //菜单部件
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return ClipRect(
                  clipper: _ClipperPath(_animation.value),
                  clipBehavior: Clip.antiAlias,
                  child: child,
                );
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                        top: BorderSide(color: Color(0xffebebeb), width: 1))),
                child: _Cascade(
                    currentTitle: widget.title,
                    deviceSearchConfig: widget.menuData,
                    onSelected: (floor) {
                      //结束动画
                      if (_animationController.status ==
                          AnimationStatus.completed) {
                        _animationController.reverse();
                      }
                      widget.onSelected?.call(floor);
                    },
                    onFinished: () {
                      //结束动画
                      if (_animationController.status ==
                          AnimationStatus.completed) {
                        _animationController.reverse();
                      }
                      widget.onFinished?.call();
                    }),
              ),
            )
          ],
        ),
      );
    });
    Overlay.of(context)!.insert(overlayEntry!);
  }

  void dismissPopupMenuLayout() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: widget.duration);
    _animationController.addStatusListener((status) {
      _currentAnimationStatus = status;
      if (status == AnimationStatus.dismissed) {
        Future.delayed(const Duration(milliseconds: 200), () {
          if (mounted) {
            dismissPopupMenuLayout();
          }
        });
      }
    });
    CurvedAnimation curvedAnimation =
        CurvedAnimation(parent: _animationController, curve: Curves.linear);
    _animation =
        Tween(begin: 0.0, end: widget.expandHeight).animate(curvedAnimation);
    _rotationAnimation = Tween(begin: 0.0, end: 1.0).animate(curvedAnimation);
    _backgroundColorAnimation =
        Tween(begin: 0.0, end: 0.5).animate(curvedAnimation);
    _colorAnimation =
        ColorTween(begin: widget.normalColor, end: widget.selectColor)
            .animate(curvedAnimation);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (_currentAnimationStatus == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (_currentAnimationStatus == AnimationStatus.dismissed) {
          showPopupMenuLayout();
        }
      },
      child: Padding(
        padding: widget.padding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (BuildContext context, Widget? child) {
                return Text(
                  widget.title,
                  style: TextStyle(
                      color: _colorAnimation.value,
                      fontSize: widget.titleFontSize),
                );
              },
            ),
            const SizedBox(
              width: 5,
            ),
            AnimatedBuilder(
                animation: _animationController,
                builder: (BuildContext context, Widget? child) {
                  return Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()
                      ..rotateX(pi * _rotationAnimation.value),
                    child: Icon(
                      widget.expandIcon,
                      size: widget.expandIconSize,
                      color: _colorAnimation.value,
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    dismissPopupMenuLayout();
    super.dispose();
  }
}

///弹出菜单位置计算
class _PopupMenuRouteLayoutDelegate extends SingleChildLayoutDelegate {
  _PopupMenuRouteLayoutDelegate({
    required this.position,
    required this.padding,
    required this.textDirection,
  });
  final RelativeRect position;
  final EdgeInsets padding;
  // 菜单内容展示方向
  final TextDirection textDirection;
  @override
  bool shouldRelayout(_PopupMenuRouteLayoutDelegate oldDelegate) {
    return position != oldDelegate.position || padding != oldDelegate.padding;
  }

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints.loose(constraints.biggest).deflate(
      padding,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    // size: 遮盖层尺寸
    // childSize: 菜单完全打开时的大小，由 getConstraintsForChild 确定。

    final double buttonHeight = size.height - position.top - position.bottom;
    // 菜单层y轴位置
    double y = position.top + buttonHeight;
    // 菜单层X轴位置
    double x;
    if (position.left > position.right) {
      // 菜单按钮更靠近右边缘，因此向左增长，与右边缘对齐。
      x = size.width - position.right - childSize.width;
    } else if (position.left < position.right) {
      // 菜单按钮更靠近左边缘，因此向右增长，与左边缘对齐。
      x = position.left;
    } else {
      // 菜单按钮与两个边缘等距，因此在文字阅读方向上延申。
      switch (textDirection) {
        case TextDirection.rtl:
          x = size.width - position.right - childSize.width;
          break;
        case TextDirection.ltr:
          x = position.left;
          break;
      }
    }

    // 避免在每个方向上超出屏幕边缘像素的矩形区域。
    // if (x < _kMenuScreenPadding + padding.left) {
    //   x = _kMenuScreenPadding + padding.left;
    // } else if (x + childSize.width >
    //     size.width - _kMenuScreenPadding - padding.right) {
    //   x = size.width - childSize.width - _kMenuScreenPadding - padding.right;
    // }
    // if (y < _kMenuScreenPadding + padding.top) {
    //   y = _kMenuScreenPadding + padding.top;
    // } else if (y + childSize.height >
    //     size.height - _kMenuScreenPadding - padding.bottom) {
    //   y = size.height - padding.bottom - _kMenuScreenPadding - childSize.height;
    // }

    return Offset(x, y);
  }
}

//下拉伸展菜单展开时，裁剪尺寸计算
class _ClipperPath extends CustomClipper<Rect> {
  _ClipperPath(this.value);
  double value;
  @override
  Rect getClip(Size size) {
    return Rect.fromLTRB(0, 0, size.width, value);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}

///三级级联菜单
class _Cascade extends StatefulWidget {
  const _Cascade(
      {required this.deviceSearchConfig,
      required this.onSelected,
      required this.onFinished,
      required this.currentTitle});
  final LocationDataModel deviceSearchConfig;
  final PopupWindowMenuItemSelected<String> onSelected;
  final VoidCallback onFinished;
  //当前按钮标题
  final String currentTitle;
  @override
  State<StatefulWidget> createState() => _CascadeState();
}

class _CascadeState extends State<_Cascade> {
  //是否显示第三级菜单
  bool show = false;
  //已选择楼栋
  int selectBuildingIndex = 0;
  //已选择单元
  int selectUnitIndex = 0;
  //已选择楼层
  int selectFloorIndex = 0;
  //所有楼栋
  late List<String> buildings;
  //已选楼的所有单元
  late List<String> units;
  //已选单元的所有楼层
  List<String>? floors;
  @override
  void initState() {
    super.initState();
    selectBuildingIndex =
        widget.deviceSearchConfig.initBuildingIndex(widget.currentTitle);
    buildings = widget.deviceSearchConfig.getBuilding();
    units = widget.deviceSearchConfig
        .getUnit(buildings.elementAt(selectBuildingIndex));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 307,
          child: Row(
            children: [
              Container(
                decoration: const BoxDecoration(
                    border: Border(
                        right: BorderSide(color: Color(0xffebebeb), width: 1))),
                width: 100,
                child: ListView.builder(
                  //第一级菜单
                  padding: EdgeInsets.zero,
                  itemBuilder: (BuildContext context, int index) {
                    var name = buildings.elementAt(index);
                    return Material(
                      child: InkWell(
                        onTap: () {
                          if (selectBuildingIndex != index) {
                            setState(() {
                              selectBuildingIndex = index;
                              //清除第二第三级菜单数据
                              selectUnitIndex = 0;
                              selectFloorIndex = 0;
                              units.clear();
                              show = false;
                              floors?.clear();
                              //重置二级菜单数据
                              units = widget.deviceSearchConfig.getUnit(name);
                            });
                          }
                        },
                        child: Container(
                          color: selectBuildingIndex == index
                              ? const Color(0xfff2f6ff)
                              : null,
                          alignment: Alignment.center,
                          padding: const EdgeInsets.only(top: 12, bottom: 12),
                          child: Text(
                            '$name栋',
                            style: TextStyle(
                                color: selectBuildingIndex == index
                                    ? const Color(0xff5974f4)
                                    : const Color(0xff969696),
                                fontSize: 14),
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: widget.deviceSearchConfig.getBuilding().length,
                ),
              ),
              Expanded(
                child: Container(
                  decoration: show
                      ? const BoxDecoration(
                          border: Border(
                              right: BorderSide(
                                  color: Color(0xffebebeb), width: 1)))
                      : null,
                  child: ListView.builder(
                    //第二级菜单
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      String unit;
                      if (index == 0) {
                        unit = units.elementAt(index);
                      } else {
                        unit = units.elementAt(index) + '单元';
                      }
                      return Material(
                        child: InkWell(
                          onTap: () {
                            if (selectUnitIndex != index) {
                              setState(() {
                                selectUnitIndex = index;
                                if (selectUnitIndex == 0) {
                                  show = false;
                                  //清除第三级菜单数据
                                  selectFloorIndex = 0;
                                  floors?.clear();
                                } else {
                                  show = true;
                                  floors = widget.deviceSearchConfig.getFloor(
                                      buildings.elementAt(selectBuildingIndex),
                                      units.elementAt(selectUnitIndex));
                                }
                              });
                            }
                          },
                          child: Container(
                            color: selectUnitIndex == index
                                ? const Color(0xfff2f6ff)
                                : null,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Text(
                              unit,
                              style: TextStyle(
                                  color: selectUnitIndex == index
                                      ? const Color(0xff5974f4)
                                      : const Color(0xff969696),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: units.length,
                  ),
                ),
              ),
              if (show)
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      String floor;
                      if (index == 0) {
                        floor = floors!.elementAt(index);
                      } else {
                        floor = floors!.elementAt(index) + '层';
                      }
                      return Material(
                        child: InkWell(
                          onTap: () {
                            if (selectFloorIndex != index) {
                              setState(() {
                                selectFloorIndex = index;
                              });
                            }
                          },
                          child: Container(
                            color: selectFloorIndex == index
                                ? const Color(0xfff2f6ff)
                                : null,
                            alignment: Alignment.center,
                            padding: const EdgeInsets.only(top: 12, bottom: 12),
                            child: Text(
                              floor,
                              style: TextStyle(
                                  color: selectFloorIndex == index
                                      ? const Color(0xff5974f4)
                                      : const Color(0xff969696),
                                  fontSize: 14),
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: floors!.length,
                  ),
                )
            ],
          ),
        ),
        Container(
          height: 1,
          color: const Color(0xffebebeb),
        ),
        Row(
          children: [
            Expanded(
              child: Material(
                child: InkWell(
                  onTap: widget.onFinished,
                  child: const SizedBox(
                    height: 43,
                    child: Center(
                      child: Text("清空",
                          style:
                              TextStyle(fontSize: 16, color: Color(0xff69696c))),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Material(
                child: InkWell(
                  onTap: () {
                    //选择的菜单数据回调
                    widget.onSelected.call('');
                  },
                  child: Container(
                    color: const Color(0xff5974f4),
                    height: 43,
                    child: const Center(
                        child: Text(
                      "确认",
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    )),
                  ),
                ),
              ),
            ),
          ],
        )
      ],
    );
  }
}
