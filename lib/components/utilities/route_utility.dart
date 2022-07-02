import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RouteUtility {
  /// Removes all routes from the navigation stack and pushes the [currentRoute]
  static void changeMainRouteNamed(BuildContext context, String currentRoute) {
    if (ModalRoute.of(context)!.settings.name != currentRoute) {
      Navigator.of(context).pushNamedAndRemoveUntil(
        currentRoute,
        (route) => false,
      );
    } else {
      Navigator.of(context).pop();
    }
  } 
}
