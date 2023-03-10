import 'package:flutter/material.dart';
import 'package:todo_app/ui/screens/settings_tab/settings_tab.dart';
import 'package:todo_app/ui/screens/task_tab/tasks_tab.dart';

import '../../custom_widgets/add_task.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'HomeScreen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int newlySelectedIndex = 0;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text((newlySelectedIndex == 0)? 'To-do List' : 'Settings'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        shape: StadiumBorder(
            side: BorderSide(color: Colors.white, width: 5)),
        onPressed: () {
          showAddTaskBottomSheet();
        },
        child: Icon(
          Icons.add,
          size: 40,
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        notchMargin: 6,
        shape: CircularNotchedRectangle(),
        child: BottomNavigationBar(
          currentIndex: newlySelectedIndex,
          onTap: (index) {
            setState(() {
              newlySelectedIndex = index;
            });
          },
          items: [
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
