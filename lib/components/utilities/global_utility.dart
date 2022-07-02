import 'package:flutter/material.dart';

class GlobalUtility {
// to calculate number of grid items
  static int gridCount(BuildContext context, double? customItemWidth) {
    return MediaQuery.of(context).size.width ~/ (customItemWidth ?? 150);
  }
}
