import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/settings_provider.dart';
import 'package:todo_app/my_database/my_database.dart';
import 'package:todo_app/my_database/task_db.dart';
import 'package:todo_app/ui/my_theme.dart';
import 'package:todo_app/utils/date_utils.dart';
import 'package:todo_app/utils/dialog%20utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class AddTaskSheet extends StatefulWidget {
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  var titleController = TextEditingController();
  var descController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  late SettingsProvider settingsProvider;

  @override
  Widget build(BuildContext context) {
    settingsProvider = Provider.of(context);
    return Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 18),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
                child: Text(
              AppLocalizations.of(context)!.add_new_task,
              style: Theme.of(context).textTheme.headlineLarge,
            )),
            TextFormField(
              controller: titleController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return AppLocalizations.of(context)!.valid_title;
                }
                return null;
              },
              decoration: InputDecoration(
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: Theme.of(context).accentColor
                      )
                  ),
                  labelStyle: Theme.of(context).textTheme.headlineLarge,
                  hintText: AppLocalizations.of(context)!.task_hint,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  )
              ),
            ),
            TextFormField(
              controller: descController,
              validator: (input) {
                if (input == null || input.trim().isEmpty) {
                  return AppLocalizations.of(context)!.valid_desc;
                }
                return null;
              },
              minLines: 1,
              maxLines: 4,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).accentColor
                    )
                ),
                hintText: AppLocalizations.of(context)!.task_description,
                  hintStyle: TextStyle(
                      color: Colors.grey
                  ),
                labelStyle: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(
                    AppLocalizations.of(context)!.select_date,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                const SizedBox(
                  height: 6,
                ),
                InkWell(
                  onTap: () {
                    showTaskDatePicker();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 12),
                    child: Text(
                      MyDateUtils.formatTaskDate(selectedDate,context),
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          color: Theme.of(context).accentColor, fontSize: 22),
                    ),
                  ),
                ),
              ],
            ),
            // ElevatedButton(onPressed: (){},
            //     child: Text('SUBMIT', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),))
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
                elevation: 10,
                backgroundColor: Theme.of(context).accentColor,
                padding: const EdgeInsets.symmetric(vertical: 10)
              ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.check,
                      size: 30,
                      color:Colors.white ,
                    ),
                    const SizedBox(
                      width: 6,
                    ),
                    Text(
                      AppLocalizations.of(context)!.submit,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall
                          ?.copyWith(color: Colors.white),
                    )
                  ],
                ),
                onPressed: () {
                  insertTask();
                })
          ],
        ),
      ),
    );
  }

  var selectedDate = DateTime.now();
  void showTaskDatePicker() async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now().subtract(const Duration(days: 365)),
        lastDate: DateTime.now().add(const Duration(days: 3650)));
    if (userSelectedDate == null) {
      return;
    }
    setState(() {
      selectedDate = userSelectedDate;
    });
  }

  void insertTask() async {
    //step 1 -> validate form
    if (formKey.currentState?.validate() == false) {
      return;
    }
    // step 2 -> insert task
    TaskMD task = TaskMD(
        title: titleController.text,
        description: descController.text,
        dateTime: selectedDate);
    DialogUtils.showProgressDialog(context, AppLocalizations.of(context)!.load);
    try {
      await MyDatabase.insertTasks(task).timeout(const Duration(milliseconds: 500), onTimeout: (){Navigator.pop(context);});
      if (!mounted) return;
      DialogUtils.showMessage(context, AppLocalizations.of(context)!.task_insert,
          posActionTitle: AppLocalizations.of(context)!.ok,
          posAction: () {
            Navigator.of(context).pop();
          },
          negActionTitle: AppLocalizations.of(context)!.cancel,
          negAction: () {
            Navigator.of(context).pop();
          },
          isDismissible: false);
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, AppLocalizations.of(context)!.failed_inserting,
          posActionTitle: AppLocalizations.of(context)!.try_again,
          posAction: () {
            insertTask();
          },
          negActionTitle: AppLocalizations.of(context)!.cancel,
          negAction: () {
            Navigator.of(context).pop();
          },
          isDismissible: true);
    }
  }
}
