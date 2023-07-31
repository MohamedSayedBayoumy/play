import 'package:flutter/material.dart';

class AnimationRoute extends PageRouteBuilder {
  AnimationRoute({required super.pageBuilder});

  static slideRoute(
    BuildContext context, {
    required dynamic pageRoute,
    bool? rigthToLeft,
    bool? leftToRight,
    bool? topToBottom,
    bool? bottomToTop,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 700),
          pageBuilder: (context, animation, secondaryAnimation) => pageRoute,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return SlideTransition(
                position: animation.drive(Tween(
                    begin: (rigthToLeft ?? false) == true
                        ? const Offset(1.0, 0.0)
                        : (leftToRight ?? false) == true
                            ? const Offset(-1.0, 0.0)
                            : (bottomToTop ?? false) == true
                                ? const Offset(0.0, 1.0)
                                : (topToBottom ?? false) == true
                                    ? const Offset(0.0, -1.0)
                                    : const Offset(0.0, -1.0),
                    end: Offset.zero)),
                child: child);
          },
        ));
  }

  static fadeRoute(
    BuildContext context, {
    required dynamic pageRoute,
  }) {
    Navigator.push(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) => pageRoute,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ));
  }

  static fadeRoutePushAndRemoveUntil(
    BuildContext context, {
    required dynamic pageRoute,
  }) {
    Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 600),
          pageBuilder: (context, animation, secondaryAnimation) => pageRoute,
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        ),
        (route) => false);
  }
}
