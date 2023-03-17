import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/settings_provider.dart';
import 'package:todo_app/my_database/my_database.dart';
import 'package:todo_app/my_database/task_db.dart';
import 'package:todo_app/ui/my_theme.dart';
import 'package:todo_app/utils/dialog%20utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../ui/screens/edit_screen/edit_screen.dart';

class TaskItems extends StatefulWidget {
  TaskMD taskMD;

  TaskItems(this.taskMD);

  @override
  State<TaskItems> createState() => _TaskItemsState();
}

class _TaskItemsState extends State<TaskItems> {
  late SettingsProvider settingsProvider;
  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Container(
      margin: EdgeInsets.only(left: 18,right: 18,bottom: 18,),
      // margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
      decoration: BoxDecoration(
          color: Colors.red, borderRadius: BorderRadius.circular(20)),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: 0.21,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              borderRadius: settingsProvider.currentLang=='en'?const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20)):const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
              onPressed: (context) {
                deleteTaskItem();
              },
              backgroundColor: const Color(0xFFFE4A49),
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label:AppLocalizations.of(context)!.delete,
            ),
          ],
        ),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, EditScreen.routeName,
                arguments: widget.taskMD);
            // Navigator.of(context).push(MaterialPageRoute(
            //   builder: (context) => EditScreen(widget.taskMD),
            // ));
          },
          child: Container(
            width: double.infinity,
            height: 100,
            // margin: EdgeInsets.symmetric(horizontal: 18, vertical: 8),
            decoration: BoxDecoration(
                color: settingsProvider.currentTheme == ThemeMode.dark? MyTheme.darkPrimary:Colors.white,
                borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: settingsProvider.currentLang=='en'? const EdgeInsets.only(left: 12):const EdgeInsets.only(right: 12),
                  color:
                  widget.taskMD.isDone? MyTheme.green: Theme.of(context).accentColor,
                  width: 6,
                  height: 80,
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        widget.taskMD.title,
                        style: Theme.of(context)
                            .textTheme
                            .headlineLarge
                            ?.copyWith(
                          color: widget.taskMD.isDone? MyTheme.green: Theme.of(context).accentColor,
                                overflow: TextOverflow.fade, fontSize: 20),
                      ),
                      Text(
                        widget.taskMD.description,
                        style:
                            Theme.of(context).textTheme.headlineSmall?.copyWith(
                              color: widget.taskMD.isDone? MyTheme.green: Theme.of(context).accentColor,
                                  fontSize: 14,
                                  overflow: TextOverflow.fade,
                                ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  width: 6,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      MyDatabase.markAsDone(widget.taskMD);
                    });
                  },
                  child: widget.taskMD.isDone
                      ? Padding(
                          padding: settingsProvider.currentLang=='en'?const EdgeInsets.only(right: 24.0):const EdgeInsets.only(left: 24.0),
                          child: Text(
                            AppLocalizations.of(context)!.done,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(color: MyTheme.green, fontWeight: FontWeight.bold),
                          ),
                        )
                      : Container(
                          width: 70,
                          height: 45,
                          margin:settingsProvider.currentLang=='en'? EdgeInsets.only(right: 14):EdgeInsets.only(left: 14),
                          decoration: BoxDecoration(
                              color: Theme.of(context).accentColor,
                              borderRadius: BorderRadius.circular(20)),
                          child: ImageIcon(AssetImage('assets/ic_check.png'),
                              color: Colors.white),
                        ),
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
    }, negActionTitle: 'No', negAction: () {});
  }
}
