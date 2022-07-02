import 'package:flutter/material.dart';
import 'package:healy_survey/components/utilities/global_utility.dart'; 

class GridItemListWidget extends StatelessWidget {
  final List<Widget> widgetList;
  final double? customItemWidth;
  final double? childAspectRatio;
  final ScrollPhysics? scrollPhysics;
  final Axis? scrollDirection;
  const GridItemListWidget(
      {Key? key,
      required this.widgetList,
      this.scrollDirection,
      this.scrollPhysics,
      this.customItemWidth,
      this.childAspectRatio})
      : super(key: key);

  Widget _buildInfo(BuildContext context) {
    return GridView.count(
        shrinkWrap: true,
        primary: true,
        physics: scrollPhysics,
        scrollDirection: scrollDirection ?? Axis.vertical,
        crossAxisSpacing: 5,
        mainAxisSpacing: 5,
        childAspectRatio: childAspectRatio ?? 1,
        crossAxisCount: GlobalUtility.gridCount(context, customItemWidth),
        padding: EdgeInsets.zero,
        children: widgetList);
  }

  @override
  Widget build(BuildContext context) {
    return _buildInfo(context);
  }
}
