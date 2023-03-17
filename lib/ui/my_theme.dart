import 'package:flutter/material.dart';

class MyTheme {
  // static const Color lightPrimary2 = Color(0xff5D9CEC);
  static const Color lightPrimary = Color(0xffff8A80);
  static const Color darkPrimary = Color(0xff141922);
  static const Color grey = Color(0xffC8C9CB);
  static const Color green = Color(0xff61E757);
  static const Color darkBlue = Color(0xff5D9CEC);
  static const Color lightScaffoldBackGroundColor = Color(0xffDFECDB);
  static const Color darkScaffoldBackGroundColor = Color(0xff060E1E);
  static final ThemeData lightTheme = ThemeData(
      accentColor:lightPrimary ,
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
          iconTheme: IconThemeData(
              color: lightPrimary
          ),
          backgroundColor: lightPrimary,
          elevation: 0,
          toolbarHeight: 70,
          titleTextStyle:
          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)));
  static final ThemeData darkTheme = ThemeData(
    accentColor:darkBlue ,
      floatingActionButtonTheme:
      const FloatingActionButtonThemeData(backgroundColor: darkScaffoldBackGroundColor),
      textTheme: const TextTheme(
        headlineSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white),
        headlineLarge: TextStyle(
            fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
        titleSmall: TextStyle(
            fontSize: 18, fontWeight: FontWeight.w400, color: Colors.white),
        titleLarge: TextStyle(
            fontSize: 20, fontWeight: FontWeight.w400, color: Colors.white),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: darkPrimary,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
              ))),
      bottomAppBarTheme: const BottomAppBarTheme(
        color: darkPrimary,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          elevation: 0,
          selectedIconTheme: IconThemeData(color: darkBlue, size: 46),
          unselectedIconTheme: IconThemeData(color: grey, size: 46)),
      scaffoldBackgroundColor: darkScaffoldBackGroundColor,
      appBarTheme: const AppBarTheme(
        iconTheme: IconThemeData(
          color: darkPrimary
        ),
          backgroundColor: darkBlue,
          elevation: 0,
          toolbarHeight: 70,
          titleTextStyle:
          TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black)));
}
