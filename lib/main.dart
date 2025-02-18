import 'package:canvas_and_pixels_mobile_app_template/app.dart';
import 'package:canvas_and_pixels_mobile_app_template/features/splashscreen/splashscreen.dart';
import 'package:flutter/material.dart';

import 'core/core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: SplashScreen.route,
      onGenerateRoute: generateRoute,
      navigatorKey: NavigationService().navigatorKey,
      home: const App(),
    );
  }
}
