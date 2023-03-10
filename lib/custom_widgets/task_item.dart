import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/my_database/my_database.dart';
import 'package:todo_app/my_database/task_db.dart';
import 'package:todo_app/ui/my_theme.dart';
import 'package:todo_app/utils/dialog%20utils.dart';

import '../ui/screens/edit_screen/edit_screen.dart';

class TaskItems extends StatefulWidget {
  TaskMD taskMD;

  TaskItems(this.taskMD);

  @override
  State<TaskItems> createState() => _TaskItemsState();
}

class _TaskItemsState extends State<TaskItems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.21,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)),
              onPressed: (context) {
                deleteTaskItem();
              },
              backgroundColor: Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) {
                return EditScreen();
              },
            ));
          },
          child: Container(
            width: double.infinity,
            height: 100,
            // margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 12),
                  color: MyTheme.lightPrimary,
                  width: 6,
                  height: 80,
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.taskMD.title,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(overflow: TextOverflow.fade, fontSize: 20),
                    ),
                    Text(
                      widget.taskMD.description,
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontSize: 14,
                                overflow: TextOverflow.fade,
                              ),
                    )
                  ],
                ),
                const SizedBox(
                  width: 6,
                ),
                Container(
                  width: 70,
                  height: 45,
                  margin: EdgeInsets.only(right: 14),
                  decoration: BoxDecoration(
                      color: MyTheme.lightPrimary,
                      borderRadius: BorderRadius.circular(20)),
                  child: ImageIcon(AssetImage('assets/ic_check.png'),
                      color: Colors.white),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTaskItem() {
    DialogUtils.showMessage(
        context, 'Are you sure, you want to delete this task?',
        posActionTitle: 'Yes', posAction: () async {
      await MyDatabase.deleteTask(widget.taskMD);
      if (!mounted) return;
      DialogUtils.showMessage(context, 'Task Deleted Successfully.',
          posActionTitle: 'Ok',
          posAction: () {
            Navigator.of(context).pop();
          },
          negActionTitle: 'Undo',
          negAction: () {
            //Todo: Undo Button
          });
    }, negActionTitle: 'No', negAction: () {
    });
  }
}
