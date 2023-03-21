import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_app/ui/my_theme.dart';
import 'package:todo_app/ui/screens/edit_screen/edit_screen.dart';
import 'package:todo_app/ui/screens/home_screen.dart';
import 'package:todo_app/ui/screens/splash_screen.dart';
import 'Providers/settings_provider.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';


void main() async{
  await WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseFirestore.instance.disableNetwork();// to deal with storage only
  runApp(ChangeNotifierProvider(
      create: (buildContext) => SettingsProvider(), child: MyTodoApp()));
}

class MyTodoApp extends StatelessWidget {
  late SettingsProvider settingsProvider;
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    getValueFromSharedPreferences();
    return MaterialApp(
        locale: Locale(settingsProvider.currentLang),
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
          Locale('ar'), // Arabic
        ],
      routes: {
          HomeScreen.routeName :(_)=>HomeScreen(),
        EditScreen.routeName: (_)=> EditScreen(),
        SplashScreen.routeName: (_)=> SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
      theme: MyTheme.lightTheme,
      darkTheme: MyTheme.darkTheme,
        themeMode:settingsProvider.currentTheme ,
      initialRoute: SplashScreen.routeName,
      // AnimatedSplashScreen(
      //       duration: 3000,
      //       splash: 'assets/splash.png',
      //       splashIconSize: 600,
      //       nextScreen: HomeScreen(),
      //       splashTransition: SplashTransition.fadeTransition,
      //       backgroundColor: MyTheme.lightScaffoldBackGroundColor)
    );
  }
  getValueFromSharedPreferences() async {
    final pref = await SharedPreferences.getInstance();
    // set lang from sharedPreferences
    settingsProvider.getLang(pref.getString('lang') ?? 'ar');
    // set theme from sharedPreferences
    if (pref.getString('theme') == 'light') {
      settingsProvider.changeTheme(ThemeMode.light);
    } else if (pref.getString('theme') == 'dark') {
      settingsProvider.changeTheme(ThemeMode.dark);
    }
  }
}
