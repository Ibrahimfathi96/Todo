import 'package:flutter/material.dart';

class MyTheme {
  // static const Color lightPrimary2 = Color(0xff5D9CEC);
  static const Color lightPrimary = Color(0xffff8A80);
  static const Color grey = Color(0xffC8C9CB);
  static const Color lightScaffoldBackGroundColor = Color(0xffDFECDB);
  static final ThemeData lightTheme = ThemeData(
      floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: lightPrimary),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
        headlineLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w600, color: Colors.black),
        titleSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.black),
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.black),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ))),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: Colors.white,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIconTheme: IconThemeData(color: lightPrimary, size: 46),
          unselectedIconTheme: IconThemeData(color: grey, size: 46)),
      scaffoldBackgroundColor: lightScaffoldBackGroundColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: lightPrimary,
          elevation: 0,
          toolbarHeight: 70,
          titleTextStyle:
          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
  static final ThemeData darkTheme = ThemeData();
}
