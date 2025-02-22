import 'package:canvas_and_pixels_mobile_app_template/app.dart';
import 'package:canvas_and_pixels_mobile_app_template/features/splashscreen/splashscreen.dart';
import 'package:canvas_and_pixels_mobile_app_template/shared/shared.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheManager.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeMode _themeMode = ThemeMode.system;
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
          themeMode: _themeMode, // Auto-switch based on system settings
          initialRoute: SplashScreen.route,
          onGenerateRoute: generateRoute,
          navigatorKey: NavigationService().navigatorKey,
          home: const App(),
        );
      },
    );
  }
}
