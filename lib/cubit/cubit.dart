import 'package:bloc/bloc.dart';

import 'package:sqflite/sqflite.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskat/archivedtasks.dart';
import 'package:taskat/cubit/state.dart';
import 'package:taskat/donetasks.dart';
import 'package:taskat/newtasks.dart';

class Cubittasks extends Cubit<Statetasks> {
  // ignore: not_initialized_non_nullable_instance_field
  Cubittasks() : super(Initstate());
  static Cubittasks getdata(context) => BlocProvider.of(context);

  List<Widget> screens = [Screenfirst(), Screensecond(), Screenthird()];
  var ind = 0;
  Database? database;

  IconData visible = Icons.add;
  IconData invisible = Icons.wallet_travel;
  List<Map> tasklist = [];
  List<Map> tasklistuntil = [];
  List<Map> tasklistdone = [];
  var titlecontrol = TextEditingController();
  var datecontrol = TextEditingController();
  var timecontrol = TextEditingController();

  void changenavbar(var valu) {
    ind = valu;
    emit(Changenav());
  }

  Future createdatabase() async {
    database = await openDatabase('todofinal.db', version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, time TEXT, date TEXT , state Text )');
    }, onOpen: (database) {
      emit(Createdatabase());
      getdatafromdb(database);

      print('database is opened now');
    }).catchError((error) {
      print('We Have An Error With $error');
      emit(Createdatabaseerror());
    });
  }

  Future inserttodatabase({
    @required var title,
    @required var time,
    @required var date,
  }) async {
    await database!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO tasks(title, time, date,state) VALUES("$title", "$time", "$date" ,"until" )');

      // ignore: expected_token
    }).then((value) {
      getdatafromdb(database);
      emit(Inserttodatabase());
      print('Your Task Is Edited Successfuly Now');
    }).catchError((error) {
      emit(Inserttodatabaseerror());
      print('Your Error Is $error');
    });
  }

  Future getdatafromdb(database) async {
    // ignore: body_might_complete_normally
    await database.rawQuery('Select * FROM tasks').then((value) {
      tasklist = value;
      tasklistuntil = [];
      tasklistdone = [];
      tasklist.forEach((element) {
        if (element["state"] == "until") {
          tasklistuntil.add(element);
        } else {
          tasklistdone.add(element);
        }
      });
      emit(Getdatafromdatabase());
      print('Data has come from database now');
    });
  }

  Future update({@required var id}) async {
    return await database!.rawUpdate('UPDATE tasks SET state =? WHERE id = ?',
        ['done', '$id']).then((value) {
      getdatafromdb(database);
      emit(Updatedatabase());
    }).catchError((error) {
      emit(Updatedatabaseerror());
    });
  }

  Future delete({@required var id}) async {
    return await database!
        .rawDelete('DELETE FROM tasks WHERE id = ?', ["$id"]).then((value) {
      getdatafromdb(database);
      emit(Deleterawfromdatabase());
      print("the task is deleted now from here");
    }).catchError((error) {
      emit(Deleterawfromdatabase());
    });
  }
// ignore: expected_token
}
