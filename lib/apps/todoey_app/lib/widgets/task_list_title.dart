import 'package:flutter/material.dart';

class TaskListTile extends StatelessWidget {
  final String name;
  final bool isDane;
  final Function checkBoxCallback;
  const TaskListTile({this.name, this.isDane, this.checkBoxCallback});
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      title: Text(
        name ?? '',
        style:
            TextStyle(decoration: isDane ? TextDecoration.lineThrough : null),
      ),
      value: isDane,
      onChanged: checkBoxCallback,
    );
  }
}
