import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:taskat/cubit/state.dart';
import 'package:taskat/style/icon_broken.dart';

import 'components/component.dart';
import 'cubit/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class Homelayout extends StatelessWidget {
  var scaffkey = GlobalKey<ScaffoldState>();
  var formkey = GlobalKey<FormState>();
  var isshow = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubittasks, Statetasks>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state) => Scaffold(
        key: scaffkey,
        appBar: AppBar(
          leading: null,
          title: Text(
            'Taskat',
            style: Theme.of(context).textTheme.headline1,
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.search, color: Colors.black),
              onPressed: () {},
            ),
            PopupMenuButton(
              icon: Icon(Icons.more_vert, color: Colors.black),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.read_more),
                    title: Text('About'),
                  ),
                ),
                const PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                  ),
                ),
                const PopupMenuItem(
                  child: ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Exit'),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        body: Cubittasks.getdata(context)
            .screens[Cubittasks.getdata(context).ind],
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(icon: Icon(Neue.Edit), label: 'New Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Neue.Shield_Done), label: 'Done Tasks'),
            BottomNavigationBarItem(
                icon: Icon(Neue.Delete), label: 'Archived Tasks'),
          ],
          currentIndex: Cubittasks.getdata(context).ind,
          onTap: (val) {
            Cubittasks.getdata(context).changenavbar(val);
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            if (isshow) {
              if (formkey.currentState!.validate()) {
                Cubittasks.getdata(context)
                    .inserttodatabase(
                        date: Cubittasks.getdata(context).datecontrol.text,
                        time: Cubittasks.getdata(context).timecontrol.text,
                        title: Cubittasks.getdata(context).titlecontrol.text)
                    .then((value) {
                  isshow = false;
                  Cubittasks.getdata(context).datecontrol.text = '';
                  Cubittasks.getdata(context).timecontrol.text = '';
                  Cubittasks.getdata(context).titlecontrol.text = '';
                  Navigator.pop(context);
                });
              }
            } else {
              isshow = true;
              scaffkey.currentState!
                  .showBottomSheet((context) => Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Form(
                          key: formkey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              textfo(
                                  lab: 'Title Of Task',
                                  preficon: Icon(Neue.Document),
                                  control:
                                      Cubittasks.getdata(context).titlecontrol),
                              SizedBox(
                                height: 10,
                              ),
                              textfo(
                                  lab: 'Time Of Task',
                                  preficon: Icon(Neue.Time_Circle),
                                  control:
                                      Cubittasks.getdata(context).timecontrol,
                                  onpressfuncation: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    )
                                        .then((value) => Cubittasks.getdata(
                                                    context)
                                                .timecontrol
                                                .text =
                                            value!.format(context).toString())
                                        .catchError((er) {
                                      print('we have an error with $er');
                                    });
                                  }),
                              SizedBox(
                                height: 10,
                              ),
                              textfo(
                                  lab: 'Date Of Task',
                                  preficon: Icon(Neue.Calendar),
                                  control:
                                      Cubittasks.getdata(context).datecontrol,
                                  onpressfuncation: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.utc(2022),
                                    )
                                        .then((value) => Cubittasks.getdata(
                                                    context)
                                                .datecontrol
                                                .text =
                                            DateFormat.yMMMd().format(value!))
                                        .catchError((er) {
                                      print('we have an error with $er');
                                    });
                                  })
                            ],
                          ),
                        ),
                      ))
                  .closed
                  .then((value) {
                isshow = false;
              });
            }
          },
          child: isshow ? Icon(Neue.Add_User) : Icon(Neue.Paper_Upload),
        ),
      ),
    );
  }
}
