import "package:flutter/material.dart";
import "package:perikopa_flutter/config/AppStyle.dart";

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = AppStyle.lightTheme;
  ThemeData get themeData => _themeData;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    // _themeData = isDark ? AppStyle.darkTheme : AppStyle.lightTheme;
    if (_themeData == AppStyle.lightTheme) {
      themeData = AppStyle.darkTheme;
    } else {
      themeData = AppStyle.lightTheme;
    }
  }
}
