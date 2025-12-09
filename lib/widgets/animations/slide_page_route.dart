import 'package:flutter/widgets.dart';

class SlidePageRoute extends PageRouteBuilder {
  final Widget page;
  final Duration duration;

  SlidePageRoute({
    required this.page,
    this.duration = const Duration(milliseconds: 200),
  }) : super(
         transitionDuration: duration,
         reverseTransitionDuration: const Duration(milliseconds: 180),
         pageBuilder: (context, animation, secondaryAnimation) => page,
         transitionsBuilder: (context, animation, secondaryAnimation, child) {
           const begin = Offset(1.0, 0.0); // slide from right
           const end = Offset.zero;

           final tween = Tween(
             begin: begin,
             end: end,
           ).chain(CurveTween(curve: Curves.easeOut));

           return SlideTransition(
             position: animation.drive(tween),
             child: child,
           );
         },
       );
}
