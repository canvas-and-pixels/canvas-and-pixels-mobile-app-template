import 'package:canvas_and_pixels_mobile_app_template/core/router/route_animation_type.dart';
import 'package:flutter/material.dart';


class NavigationService {
  // Singleton pattern
  NavigationService._internal();
  static final NavigationService _instance = NavigationService._internal();
  factory NavigationService() => _instance;

  // Global key for the navigator
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  // Method to navigate to a route with an optional animation type
  Future<dynamic> navigateTo(String routeName,
      {Object? arguments,
      RouteAnimationType animationType = RouteAnimationType.slide}) {
    return navigatorKey.currentState!.pushNamed(
      routeName,
      arguments: {'arguments': arguments, 'animationType': animationType},
    );
  }

  // Method to navigate back
  void goBack() {
    return navigatorKey.currentState!.pop();
  }

  // Method to navigate and remove all previous routes
  Future<dynamic> navigateAndRemoveUntil(String routeName,
      {Object? arguments,
      RouteAnimationType animationType = RouteAnimationType.slide}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: {'arguments': arguments, 'animationType': animationType},
    );
  }
}
