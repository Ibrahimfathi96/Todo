import 'package:flutter/material.dart';
import 'package:todo_app/my_database/my_database.dart';
import 'package:todo_app/utils/date_utils.dart';
import 'package:todo_app/utils/dialog%20utils.dart';
import '../../../my_database/task_db.dart';
import '../../my_theme.dart';


class EditScreen extends StatefulWidget {
  static const String routeName = 'edit-screen';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  @override
  Widget build(BuildContext context) {
    var taskMD = ModalRoute.of(context)?.settings.arguments as TaskMD;

    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Task'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 102,
              color: MyTheme.lightPrimary,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30, bottom: 100, top: 30),
              child: Center(
                child: Container(
                  padding: EdgeInsets.only(bottom: 30),
                  height: MediaQuery.of(context).size.height * 0.6,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey, //New
                          blurRadius: 25.0,
                        )
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    padding: EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                            child: Text(
                          'Edit Task',
                          style: Theme.of(context).textTheme.headlineLarge,
                        )),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(
                                flex: 1,
                              ),
                              TextFormField(
                                initialValue: taskMD.title,
                                  onChanged: (value){
                                  taskMD.title = value;
                                  },
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge
                                      ?.copyWith(overflow: TextOverflow.fade, fontSize: 20),

                                decoration: InputDecoration(
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                    hintText: 'Edit the title'),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              TextFormField(
                                initialValue: taskMD.description,
                                  onChanged: (value){
                                  taskMD.description = value;
                                  },
                                  style: Theme.of(context)
                                  .textTheme
                                  .headlineLarge
                                  ?.copyWith(overflow: TextOverflow.fade, fontSize: 20),
                                maxLines: 4,
                                minLines: 1,
                                decoration: InputDecoration(
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                    hintText: 'Edit the description'),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      'Select Time',
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleLarge,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        showTaskDatePicker(taskMD);
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 4.0, horizontal: 12),
                                        child: Text(
                                          MyDateUtils.formatTaskDate(taskMD.dateTime),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  color: MyTheme.lightPrimary,
                                                  fontSize: 22),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(
                                flex:2,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                elevation: 10,
                                backgroundColor: MyTheme.lightPrimary,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            onPressed: () {
                              editTask(taskMD);
                            },
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
                          ),
                        ),
                        // FloatingActionButton(
                        //   elevation: 0,
                        //     shape: StadiumBorder(
                        //         side: BorderSide(
                        //             color: Colors.white
                        //         )
                        //     ),
                        //     child: Row(
                        //       mainAxisAlignment: MainAxisAlignment.center,
                        //       children: [
                        //         Icon(Icons.check, size: 30,),
                        //         SizedBox(width: 6,),
                        //         Text('SUBMIT', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),)
                        //       ],
                        //     ),
                        //     onPressed: (){
                        //     }),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
  var selectedDate = DateTime.now();
  void showTaskDatePicker(TaskMD taskMD) async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: taskMD.dateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 3650)));
    if (userSelectedDate == null) {
      return;
    }
    setState(() {
      taskMD.dateTime = userSelectedDate;
    });
  }

  void editTask (TaskMD taskMD) async {
    Navigator.of(context).pop();
    if (!mounted) return;
    DialogUtils.showMessage(context, 'Edit Successfully', posActionTitle:'OK', posAction: (){
      Navigator.pop(context);
    } );
    await MyDatabase.editTasks(taskMD);
  }
}
