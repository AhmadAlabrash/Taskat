import 'package:flutter/material.dart';
import 'package:taskat/cubit/cubit.dart';

var diskey = GlobalKey();

Widget textfo({
  @required var lab,
  @required var preficon,
  var sufixicon,
  var onpressfuncation,
  @required var control,
}) =>
    TextFormField(
        decoration: InputDecoration(
          labelText: lab,
          prefixIcon: preficon,
          suffixIcon: sufixicon,
          border: OutlineInputBorder(),
        ),
        onTap: onpressfuncation,
        controller: control,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Data is invalid ';
          }
          return null;
        });
Widget itemtask(Map data, context) {
  return Dismissible(
    key: UniqueKey(),
    onDismissed: (direction) =>
        Cubittasks.getdata(context).delete(id: data["id"]),
    child: Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 40,
            child: Text('${data["time"]}'),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${data["title"]}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(height: 1, fontSize: 25),
              ),
              Text(
                '${data["date"]}',
                style: Theme.of(context)
                    .textTheme
                    .subtitle1!
                    .copyWith(height: 1.2),
              )
            ],
          ),
          Spacer(),
          IconButton(
              onPressed: () {
                Cubittasks.getdata(context).update(id: data["id"]);
              },
              icon: Icon(Icons.check_box))
        ],
      ),
    ),
  );
}
