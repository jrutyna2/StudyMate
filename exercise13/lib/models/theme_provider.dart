import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData;

  ThemeProvider(this._themeData);

  ThemeData get themeData => _themeData;

  setTheme(ThemeData theme) {
    _themeData = theme;
    notifyListeners();
  }

  void toggleTheme(bool isDark) {
    _themeData = isDark ? ThemeData.dark() : ThemeData.light();
    notifyListeners();
    SharedPreferences.getInstance().then(
          (prefs) => prefs.setBool('dark_theme', isDark),
    );
  }
}
