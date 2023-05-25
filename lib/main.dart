import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saif/splash_screen.dart';
import 'package:saif/theme/theme_manager.dart';
import 'package:saif/theme/themes.dart';



void main() async {
  await GetStorage.init();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize GetStorage
    GetStorage.init().then((value) {
      // Check if it's the first time app installation
      bool isFirstTime = GetStorage().read('isFirstTime') ?? true;

      // If it's the first time, clear stored values
      if (isFirstTime) {
        GetStorage().remove('email');
        GetStorage().remove('password');

        // Set the flag to indicate app has been installed before
        GetStorage().write('isFirstTime', false);
      }
    });

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saif',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeManager().theme,
      home: SplashScreen(),
    );
  }
}
