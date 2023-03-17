import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class SettingsProvider extends ChangeNotifier{
  ThemeMode currentTheme = ThemeMode.dark;
  String currentLang = 'en';
  bool isDarkMode() {
    return currentTheme == ThemeMode.dark;
  }
  void changeTheme(ThemeMode newMode) async {
    final pref = await SharedPreferences.getInstance();
    if (newMode == currentTheme) return;
    currentTheme = newMode;
    pref.setString('theme', currentTheme == ThemeMode.light ? 'light' : 'dark');
    notifyListeners();
  }
}