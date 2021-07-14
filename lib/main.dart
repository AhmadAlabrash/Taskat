import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskat/cubit/cubit.dart';
import 'package:taskat/cubit/state.dart';
import 'package:taskat/homelayout.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => Cubittasks()..createdatabase(),
        child: BlocConsumer<Cubittasks, Statetasks>(
            listener: (BuildContext context, state) {},
            builder: (BuildContext context, state) => MaterialApp(
                  debugShowCheckedModeBanner: false,
                  home: Homelayout(),
                  theme: ThemeData(
                    textTheme: TextTheme(
                      subtitle2: TextStyle(
                          fontFamily: 'vegan',
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      headline1: TextStyle(
                          fontFamily: 'vegan',
                          fontSize: 34,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                      subtitle1: TextStyle(fontFamily: 'vegan', fontSize: 18),
                    ),
                    primarySwatch: Colors.lightBlue,
                    scaffoldBackgroundColor: Colors.white,
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        elevation: 7, backgroundColor: Colors.white),
                    appBarTheme: AppBarTheme(
                        backgroundColor: Colors.white,
                        elevation: 0,
                        iconTheme: IconThemeData(color: Colors.black)),
                  ),
                  darkTheme: ThemeData(
                    primarySwatch: Colors.cyan,
                    scaffoldBackgroundColor: Colors.grey[600],
                    bottomNavigationBarTheme: BottomNavigationBarThemeData(
                        selectedItemColor: Colors.white,
                        elevation: 7,
                        backgroundColor: Colors.grey[400]),
                    appBarTheme: AppBarTheme(
                        backgroundColor: Colors.grey[400],
                        elevation: 0,
                        iconTheme: IconThemeData(color: Colors.black)),
                  ),
                  themeMode: ThemeMode.light,
                )));
  }
}
