import 'package:flutter/material.dart';
import 'package:todo_app/my_database/my_database.dart';
import 'package:todo_app/my_database/task_db.dart';
import 'package:todo_app/ui/my_theme.dart';
import 'package:todo_app/utils/date_utils.dart';
import 'package:todo_app/utils/dialog%20utils.dart';

class AddTaskSheet extends StatefulWidget {
  @override
  State<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends State<AddTaskSheet> {
  var titleController = TextEditingController();

  var descController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 18),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                  child: Text(
                'Add New Task',
                style: Theme.of(context).textTheme.headlineLarge,
              )),
              TextFormField(
                controller: titleController,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return "Please enter a valid title";
                  }
                  return null;
                },
                decoration: InputDecoration(
                    labelStyle: Theme.of(context).textTheme.headlineLarge,
                    hintText: 'Enter Your Task Title'),
              ),
              TextFormField(
                controller: descController,
                validator: (input) {
                  if (input == null || input.trim().isEmpty) {
                    return "Please enter a valid description";
                  }
                  return null;
                },
                minLines: 1,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Task Description',
                  labelStyle: Theme.of(context).textTheme.headlineLarge,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Text(
                      'Select Date',
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
                        MyDateUtils.formatTaskDate(selectedDate),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: MyTheme.lightPrimary, fontSize: 22),
                      ),
                    ),
                  ),
                ],
              ),
              // ElevatedButton(onPressed: (){},
              //     child: Text('SUBMIT', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),))
              FloatingActionButton(
                  shape: StadiumBorder(side: BorderSide(color: Colors.white)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check,
                        size: 30,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        'SUBMIT',
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
    DialogUtils.showProgressDialog(context, 'Loading...');
    try {
      await MyDatabase.insertTasks(task);
      if (!mounted) return;
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'Task inserted Successfully.',
          posActionTitle: 'OK',
          posAction: () {
            Navigator.of(context).pop();
          },
          // negActionTitle: 'Cancel',
          // negAction: () {
          //   Navigator.of(context).pop();
          // },
          isDismissible: false);
    } catch (e) {
      DialogUtils.hideDialog(context);
      DialogUtils.showMessage(context, 'failed inserting the task.',
          posActionTitle: 'try again',
          posAction: () {
            insertTask();
          },
          negActionTitle: 'Cancel',
          negAction: () {
            Navigator.of(context).pop();
          },
          isDismissible: true);
    }
  }
}
