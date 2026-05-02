import 'package:flutter/material.dart';

class CustomPageRoute<T> extends PageRouteBuilder<T> {
  final Widget page;

  CustomPageRoute({required this.page})
      : super(
          pageBuilder: (context, animation, secondaryAnimation) => page,
          transitionDuration: const Duration(milliseconds: 400),
          reverseTransitionDuration: const Duration(milliseconds: 300),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            // Define a smooth curve for the transition
            var curve = Curves.easeOutCubic;
            var reverseCurve = Curves.easeInCubic;
            
            var curvedAnimation = CurvedAnimation(
              parent: animation,
              curve: curve,
              reverseCurve: reverseCurve,
            );

            // Smooth fade in
            var fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(curvedAnimation);

            // Subtle slide up from 5% below
            var slideAnimation = Tween<Offset>(
              begin: const Offset(0.0, 0.05),
              end: Offset.zero,
            ).animate(curvedAnimation);

            // Subtle scale up for depth
            var scaleAnimation = Tween<double>(
              begin: 0.98,
              end: 1.0,
            ).animate(curvedAnimation);

            return FadeTransition(
              opacity: fadeAnimation,
              child: SlideTransition(
                position: slideAnimation,
                child: ScaleTransition(
                  scale: scaleAnimation,
                  child: child,
                ),
              ),
            );
          },
        );
}
