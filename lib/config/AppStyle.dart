import 'package:flutter/material.dart';

class AppStyle {
  static ThemeData lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(
      primary: Color.fromRGBO(13, 71, 161, 1),
      secondary: Color.fromRGBO(63, 81, 181, 1),
      background: Color.fromRGBO(245, 250, 253, 1),
    ),
  );

  static ThemeData darkTheme = ThemeData(
      colorScheme: const ColorScheme.dark(
    primary: Color.fromRGBO(63, 81, 181, 1),
    secondary: Color.fromRGBO(63, 81, 181, 1),
    background: Color.fromARGB(255, 78, 78, 78),
  ));
}
