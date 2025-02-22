import 'package:canvas_and_pixels_mobile_app_template/app.dart';
import 'package:canvas_and_pixels_mobile_app_template/features/splashscreen/splashscreen.dart';
import 'package:canvas_and_pixels_mobile_app_template/shared/shared.dart';
import 'package:canvas_and_pixels_mobile_app_template/shared/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.init();
  AppLogger.init(); // Default: logs everything
  //  await FirebaseNotificationService().init();
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({super.key});
  ThemeMode themeMode = ThemeMode.system;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          title: 'Canavs&Pixels Mobile Template',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeMode, // Auto-switch based on system settings
          initialRoute: SplashScreen.route,
          onGenerateRoute: generateRoute,
          navigatorKey: NavigationService().navigatorKey,
          home: const App(),
        );
      },
    );
  }
}
