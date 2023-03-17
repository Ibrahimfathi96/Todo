import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/settings_provider.dart';
import 'package:todo_app/my_database/task_db.dart';
import 'package:todo_app/ui/my_theme.dart';

import '../../../custom_widgets/task_item.dart';
import '../../../my_database/my_database.dart';

class TasksListTAb extends StatefulWidget {
  @override
  State<TasksListTAb> createState() => _TasksListTAbState();
}

class _TasksListTAbState extends State<TasksListTAb> {
  late SettingsProvider settingsProvider;
  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 102,
                color: Theme.of(context).accentColor,
              ),

              CalendarTimeline(
                initialDate: selectedDate,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                lastDate: DateTime.now().add(Duration(days: 3650)),
                onDateSelected: (date) {
                  if(date == null){
                    return;
                  }
                  setState(() {selectedDate = date;});
                },
                leftMargin: 20,
                monthColor: settingsProvider.currentTheme == ThemeMode.dark? Colors.white: Colors.black,
                dayColor: settingsProvider.currentTheme == ThemeMode.dark? Colors.white: Colors.black,
                activeDayColor: settingsProvider.currentTheme == ThemeMode.dark?Colors.white:Colors.white,
                activeBackgroundDayColor: settingsProvider.currentTheme == ThemeMode.dark?Colors.black:Colors.blueAccent,
                dotsColor:settingsProvider.currentTheme == ThemeMode.dark?Colors.white:Colors.white,
                locale: 'en_ISO',
              ),
            ],
          ),
          SizedBox(height: 18,),
          Expanded(
              child:StreamBuilder<QuerySnapshot<TaskMD>>(builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }
                if(snapshot.hasError){
                  return Center(child: Text('Error Loading the task'),);
                  //Todo: show try again Button
                }
                var tasks = snapshot.data?.docs.map((e) => e.data()).toList();;
                return ListView.builder(
                    itemCount:tasks?.length,
                    itemBuilder: (_, index) {
                      return TaskItems(tasks![index]);
                    },);
              },
                stream: MyDatabase.getTasksRealTimeUpdates(selectedDate),)
          ),
        ],
      )

    );
  }
}
