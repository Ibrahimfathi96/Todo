import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/ui/my_theme.dart';
import 'package:todo_app/ui/screens/home_screen.dart';

import '../../Providers/settings_provider.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = 'splash-screen';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SettingsProvider settingsProvider;

  @override
  void initState() {
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomeScreen.routeName);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Scaffold(
      body: Container(
        color:
        settingsProvider.isDarkMode()?MyTheme.darkScaffoldBackGroundColor:
        MyTheme.lightScaffoldBackGroundColor,
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Container(),
            Center(child: Image.asset('assets/logo.png'),),
            Text('Designed by Eng.Ibrahim Fathi',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: Color(0xff3598DB)
            ),
            )
          ],
        ),
      )
    );
  }
}
