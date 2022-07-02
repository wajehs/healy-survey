import 'package:flutter/material.dart';

// to  create a sliding page transition
class CustomPageTransitionRoute extends PageRouteBuilder {
  final Widget page;
  final Offset? customOffset;
  final int? customTransitionDuration;
  CustomPageTransitionRoute(
      {required this.page, this.customOffset, this.customTransitionDuration})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionDuration:
              Duration(milliseconds: customTransitionDuration ?? 300),
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              SlideTransition(
            position: Tween<Offset>(
              begin: customOffset ?? const Offset(1.0, 0.0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
}
