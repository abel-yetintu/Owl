import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  SharedPreferences prefs;

  late ThemeMode _themeMode;
  ThemeMode get themeMode => _themeMode;

  ThemeProvider({required this.prefs}) {
    if (prefs.getBool('isDarkMode') == null) {
      _themeMode = ThemeMode.dark;
    } else {
      _themeMode = prefs.getBool('isDarkMode')! ? ThemeMode.dark : ThemeMode.light;
    }
  }

  toggleTheme({required bool isDark}) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    prefs.setBool('isDarkMode', isDark);
    notifyListeners();
  }
}
