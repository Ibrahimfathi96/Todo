import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../custom_widgets/language_bottom_sheet.dart';
import '../../../custom_widgets/theme_bottom_sheet.dart';
import '../../my_theme.dart';


class SettingsTab extends StatefulWidget {
  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Scaffold(
        body: Column(
      children: [
        Container(
          height: 102,
          color:Theme.of(context).accentColor,
        ),
        Container(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.lang,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: (){
                    showLangButtonSheet();
                  },
                  child: Container(
                    padding: settingsProvider.isEnglish()? const EdgeInsets.only(right: 6, left: 14):EdgeInsets.only(right: 14, left: 6),
                    height: 50,
                    decoration:  BoxDecoration(
                        color: settingsProvider.currentTheme == ThemeMode.dark? MyTheme.darkPrimary:Colors.white,
                        border: Border.all(color: settingsProvider.currentTheme == ThemeMode.dark? MyTheme.darkBlue:MyTheme.lightPrimary, width: 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          settingsProvider.currentLang == 'en' ? 'English' : 'العربية',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                            onPressed: () {
                              showLangButtonSheet();
                            },
                            icon: Icon(Icons.arrow_drop_down, size: 36,color:settingsProvider.currentTheme == ThemeMode.dark? MyTheme.darkBlue:MyTheme.lightPrimary,))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.only(left: 30,right: 30,bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                AppLocalizations.of(context)!.theme,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GestureDetector(
                  onTap: (){
                    showThemeButtonSheet();
                  },
                  child: Container(
                    padding: settingsProvider.isEnglish()? const EdgeInsets.only(right: 6, left: 14):EdgeInsets.only(right: 14, left: 6),
                    height: 50,
                    decoration:  BoxDecoration(
                        color: settingsProvider.currentTheme == ThemeMode.dark? MyTheme.darkPrimary:Colors.white,
                        border: Border.all(color: settingsProvider.currentTheme == ThemeMode.dark? MyTheme.darkBlue:MyTheme.lightPrimary, width: 1)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          settingsProvider.isDarkMode()
                              ? AppLocalizations.of(context)!.dark
                              : AppLocalizations.of(context)!.light,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        IconButton(
                            onPressed: () {
                              showThemeButtonSheet();
                            },
                            icon:  Icon(Icons.arrow_drop_down, size: 36,color: settingsProvider.currentTheme == ThemeMode.dark? MyTheme.darkBlue:MyTheme.lightPrimary,))
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )
      ],
    ));
  }
  void showThemeButtonSheet() {
    showModalBottomSheet(
      context: context,
      builder: (builderContext) => ThemeBottomSheet(),
    );
  }

  void showLangButtonSheet() {
    showModalBottomSheet(
      context: context,
      builder: (buildContext) => LanguageBottomSheet(),
    );
  }
}
