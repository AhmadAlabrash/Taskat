import 'package:flutter/material.dart';
import 'package:taskat/style/icon_broken.dart';

class Screenthird extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Neue.Delete,
          color: Colors.grey[400],
          size: 120,
        ),
        Text("Deleted  Tasks",
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(height: 1, fontSize: 22))
      ],
    ));
  }
}
