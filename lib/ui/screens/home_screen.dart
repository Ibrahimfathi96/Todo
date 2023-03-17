import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/settings_provider.dart';
import 'package:todo_app/ui/screens/settings_tab/settings_tab.dart';
import 'package:todo_app/ui/screens/task_tab/tasks_tab.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import '../../custom_widgets/add_task.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newlySelectedIndex = 0;
  late SettingsProvider settingsProvider ;


  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text((newlySelectedIndex == 0)? AppLocalizations.of(context)!.app_title : AppLocalizations.of(context)!.settings),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: const StadiumBorder( side: BorderSide(color: Colors.white,width: 4)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: const Icon(
          Icons.add,
          color:Colors.white ,
          size: 40,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: const CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: newlySelectedIndex,
          onTap: (index) {
            setState(() {
              newlySelectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined), label: '')
          ],
        ),
      ),
      body: tabsList[newlySelectedIndex],
    );
  }

  var tabsList = [
    TasksListTAb(),
    SettingsTab(),
  ];

  void showAddTaskBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (buildContext) => AddTaskSheet(),
    );
  }
}
