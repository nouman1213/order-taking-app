import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:saif/theme/theme_manager.dart';
import 'package:saif/theme/themes.dart';

import 'screens/login_screen.dart';

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
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saif',
      theme: Themes.light,
      darkTheme: Themes.dark,
      themeMode: ThemeManager().theme,
      home: LoginScreen(),
    );
  }
}
