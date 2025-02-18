import 'package:canvas_and_pixels_mobile_app_template/core/router/route_animation_type.dart';
import 'package:canvas_and_pixels_mobile_app_template/features/onboarding/onboarding.dart';
import 'package:canvas_and_pixels_mobile_app_template/features/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments as Map<String, dynamic>? ?? {};
  final animationType =
      args['animationType'] as RouteAnimationType? ?? RouteAnimationType.slide;

  switch (settings.name) {
    // *************************************[Onboarding]*******************************************
    case SplashScreen.route:
      return _buildPageRoute(const SplashScreen(), settings, animationType);
    case OnboardingScreen.route:
      return _buildPageRoute(const OnboardingScreen(), settings, animationType);

    // *************************************[Authentication]*******************************************

    default:
      return MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      );
  }
}

PageRouteBuilder _buildPageRoute(
    Widget page, RouteSettings settings, RouteAnimationType animationType) {
  return PageRouteBuilder(
    settings: settings,
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      switch (animationType) {
        case RouteAnimationType.fade:
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        case RouteAnimationType.scale:
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        case RouteAnimationType.rotation:
          return RotationTransition(
            turns: animation,
            child: child,
          );
        case RouteAnimationType.slide:
        default:
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.ease;

          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          var offsetAnimation = animation.drive(tween);

          return SlideTransition(
            position: offsetAnimation,
            child: child,
          );
      }
    },
  );
}
