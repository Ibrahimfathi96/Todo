import 'package:flutter/material.dart';

import '../../my_theme.dart';

class SettingsTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 102,
            color: MyTheme.lightPrimary,
          ),
          Container(
            padding: EdgeInsets.all(40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
              ],
            ),
          ),
        ],
      )
    );
  }
}
