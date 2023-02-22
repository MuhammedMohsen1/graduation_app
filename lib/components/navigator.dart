import 'package:flutter/material.dart';

void navigateTo(context, Widget screen) {
  Navigator.of(context).push(createRoute(screen));
}

void navigateBack(context) {
  Navigator.of(context).pop();
}

void navigateToAndReplace(context, Widget screen) {
  Navigator.of(context).pushReplacement(createRoute(screen));
}

Route createRoute(Widget screen) {
  return PageRouteBuilder(
    transitionDuration: const Duration(milliseconds: 750),
    pageBuilder: (context, animation, secondaryAnimation) => screen,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = const Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;
      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
