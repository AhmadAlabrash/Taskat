import 'package:conditional_builder/conditional_builder.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:taskat/cubit/state.dart';
import 'package:taskat/style/icon_broken.dart';
import 'cubit/cubit.dart';

import 'components/component.dart';

class Screensecond extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<Cubittasks, Statetasks>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) => ConditionalBuilder(
              condition: Cubittasks.getdata(context).tasklistdone.length != 0,
              builder: (context) => ListView.separated(
                  itemBuilder: (context, index) => itemtask(
                      Cubittasks.getdata(context).tasklistdone[index], context),
                  separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 1.0,
                          color: Colors.grey,
                          width: double.infinity,
                        ),
                      ),
                  itemCount: Cubittasks.getdata(context).tasklistdone.length),
              fallback: (context) => Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Neue.Folder,
                    color: Colors.grey[400],
                    size: 100,
                  ),
                  Text("You have not any done tasks",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(height: 1, fontSize: 22))
                ],
              )),
            ));
  }
}
