import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Providers/settings_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class ThemeBottomSheet extends StatefulWidget {
  @override
  State<ThemeBottomSheet> createState() => _ThemeBottomSheetState();
}

class _ThemeBottomSheetState extends State<ThemeBottomSheet> {
  late SettingsProvider settingsProvider;
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Container(
      padding: const EdgeInsets.all(14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
              onTap: () {
                settingsProvider.changeTheme(ThemeMode.dark);
              },
              child: settingsProvider.isDarkMode()
                  ? getSelectedIcon(AppLocalizations.of(context)!.dark)
                  : getUnSelectedIcon(AppLocalizations.of(context)!.dark)),
          const SizedBox(
            height: 12,
          ),
          InkWell(
              onTap: () {
                settingsProvider.changeTheme(ThemeMode.light);
              },
              child: settingsProvider.isDarkMode()
                  ? getUnSelectedIcon(AppLocalizations.of(context)!.light)
                  : getSelectedIcon(AppLocalizations.of(context)!.light)),
        ],
      ),
    );
  }

  Widget getSelectedIcon(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(fontSize:26,color: Theme.of(context).accentColor),
        ),
        Icon(
          Icons.check,
          color: Theme.of(context).accentColor,
          size: 30,
        )
      ],
    );
  }

  Widget getUnSelectedIcon(String title) {
    return Text(
      title,
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize:26,color:settingsProvider.currentTheme == ThemeMode.dark ? Colors.white : Colors.black ),
    );
  }
}
