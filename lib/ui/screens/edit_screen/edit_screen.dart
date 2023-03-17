import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/Providers/settings_provider.dart';
import 'package:todo_app/my_database/my_database.dart';
import 'package:todo_app/utils/date_utils.dart';
import 'package:todo_app/utils/dialog%20utils.dart';
import '../../../my_database/task_db.dart';
import '../../my_theme.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';



class EditScreen extends StatefulWidget {
  static const String routeName = 'edit-screen';

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  late SettingsProvider settingsProvider;
  @override
  Widget build(BuildContext context) {
    var taskMD = ModalRoute.of(context)?.settings.arguments as TaskMD;
    settingsProvider = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.edit_task),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: 102,
              color: Theme.of(context).accentColor,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 30, left: 30, bottom: 100, top: 30),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  height: MediaQuery.of(context).size.height * 0.7,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: settingsProvider.currentTheme== ThemeMode.dark? MyTheme.darkPrimary:Colors.grey, //New
                          blurRadius: 25.0,
                        )
                      ],
                      color: settingsProvider.currentTheme==ThemeMode.dark?MyTheme.darkPrimary:Colors.white,
                      borderRadius: BorderRadius.circular(25)),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                            child: Text(
                              AppLocalizations.of(context)!.edit_task,
                          style: Theme.of(context).textTheme.headlineLarge,
                        )),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Spacer(
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
                                  enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Theme.of(context).accentColor
                                      )
                                  ),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                    hintText: AppLocalizations.of(context)!.edit_title,
                                  hintStyle: const TextStyle(
                                    color: Colors.grey
                                  )
                                ),
                              ),
                              const Spacer(
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
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Theme.of(context).accentColor
                                        )
                                    ),
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .headlineLarge,
                                    hintText: AppLocalizations.of(context)!.edit_desc,
                                    hintStyle: const TextStyle(
                                    color: Colors.grey
                                )),
                              ),
                              const Spacer(
                                flex: 1,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12.0),
                                    child: Text(
                                      AppLocalizations.of(context)!.select_date,
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
                                          MyDateUtils.formatTaskDate(taskMD.dateTime,context),
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleSmall
                                              ?.copyWith(
                                                  color: Theme.of(context).accentColor,
                                                  fontSize: 22),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Spacer(
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
                                backgroundColor: Theme.of(context).accentColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            onPressed: () {
                              editTask(taskMD);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.check,
                                  size: 30,
                                ),
                                const SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  AppLocalizations.of(context)!.save_changes,
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
    DialogUtils.showMessage(context, AppLocalizations.of(context)!.edit_succ, posActionTitle:AppLocalizations.of(context)!.ok, posAction: (){
      Navigator.pop(context);
    } );
    await MyDatabase.editTasks(taskMD);
  }
}
