import 'package:flutter/material.dart';

import 'color_scheme.dart';

class Themes {
  //LightTheme
  static final light = ThemeData.light().copyWith(
    colorScheme: lightColorScheme,
  );

  //DarkTheme
  static final dark = ThemeData.dark().copyWith(
    colorScheme: darkColorScheme,
  );
}
