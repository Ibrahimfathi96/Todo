import 'package:flutter/material.dart';

import '../../my_theme.dart';


class EditScreen extends StatelessWidget {
  static const String routeName = 'edit-screen';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:() => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Edit Task'),
        ),
        body: Stack(
          children: [
            Container(
              height: 102,
              color: MyTheme.lightPrimary,
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
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
                        Center(child: Text('Edit Task', style: Theme.of(context).textTheme.headlineLarge,)),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Spacer(flex: 1,),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelStyle: Theme.of(context).textTheme.headlineLarge,
                                    hintText: 'Edit the title'
                                ),
                              ),
                              Spacer(flex: 1,),
                              TextFormField(
                                maxLines: 4,
                                minLines: 3,
                                decoration: InputDecoration(
                                    labelStyle: Theme.of(context).textTheme.headlineLarge,
                                    hintText: 'Edit the description'
                                ),
                              ),
                              Spacer(flex: 2,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                                    child: Text('Select Time', style: Theme.of(context).textTheme.headlineSmall,),
                                  ),
                                  const SizedBox(height: 6,),
                                  Center(
                                    child: InkWell(
                                      onTap: (){
                                        // showTaskDatePicker();
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                                        child: Text(
                                          '1/7/1996', style: Theme.of(context).textTheme.titleSmall?.copyWith(color: MyTheme.lightPrimary, fontSize: 22),),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(flex: 2,),
                            ],
                          ),
                        ),
                        FloatingActionButton(
                          elevation: 0,
                            shape: StadiumBorder(
                                side: BorderSide(
                                    color: Colors.white
                                )
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.check, size: 30,),
                                SizedBox(width: 6,),
                                Text('SUBMIT', style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white),)
                              ],
                            ),
                            onPressed: (){
                            }),
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
}
