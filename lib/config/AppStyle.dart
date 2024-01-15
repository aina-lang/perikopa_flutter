import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    background: Color.fromARGB(255, 6, 10, 27),
  ));
}

class Preference {
  double? zoom;
  bool? isDark;

  Preference({ this.zoom, this.isDark});

  void setZoom(double value) async {
    SharedPreferences instancePref = await SharedPreferences.getInstance();
    instancePref.setDouble("textZoom", value);
  }

  void setTheme(bool value) async {
    SharedPreferences instancePref = await SharedPreferences.getInstance();
    instancePref.setBool("isDark", value);
  }

  Future<double?> getZoom() async {
    SharedPreferences instancePref = await SharedPreferences.getInstance();
    double? zoom = instancePref.getDouble("textZoom");
    return zoom;
  }

  Future<bool?> getTheme() async {
    SharedPreferences instancePref = await SharedPreferences.getInstance();
    bool? isDark = instancePref.getBool("isDark");
    return isDark;
  }
}
