import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/my_database/task_db.dart';
import 'package:todo_app/ui/my_theme.dart';

import '../../../custom_widgets/task_item.dart';
import '../../../my_database/my_database.dart';

class TasksListTAb extends StatefulWidget {
  @override
  State<TasksListTAb> createState() => _TasksListTAbState();
}

class _TasksListTAbState extends State<TasksListTAb> {
  var selectedDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 102,
                color: MyTheme.lightPrimary,
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
                monthColor: Colors.black,
                dayColor: Colors.blueAccent,
                activeDayColor: Colors.black,
                activeBackgroundDayColor: Colors.blueAccent[300],
                dotsColor:Colors.black,
                locale: 'en_ISO',
              ),
            ],
          ),
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
