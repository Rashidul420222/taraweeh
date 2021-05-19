import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/task_data.dart';
import '../widgets/task_list_title.dart';

class TaskList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TaskData>(builder: (context, data, child) {
      return ListView.builder(
        itemCount: data.dataCount,
        itemBuilder: (context, index) => Dismissible(
          key: Key(data.task.toString()),
          onDismissed: (direction) {
            data.task.removeAt(index);
          },
          child: TaskListTile(
            name: data.task[index].name,
            isDane: data.task[index].isDone,
            checkBoxCallback: (checkBoxState) {
              data.updateTask(data.task[index]);
            },
          ),
        ),
      );
    });
  }
}
