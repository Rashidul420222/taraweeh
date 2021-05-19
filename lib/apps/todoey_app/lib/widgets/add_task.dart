import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taraweeh/apps/todoey_app/lib/models/task_data.dart';

class AddTask extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    String inputText;
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
      child: AlertDialog(
        title: Text(
          'New Task',
          textAlign: TextAlign.center,
          style:
              TextStyle(color: Colors.cyan[400], fontWeight: FontWeight.bold),
        ),
        content: TextField(
          textAlign: TextAlign.center,
          onChanged: (value) {
            inputText = value;
          },
        ),
        actions: [
          FlatButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'CANCEL',
              style: TextStyle(color: Colors.cyan[400]),
            ),
          ),
          FlatButton(
            onPressed: () {
              Provider.of<TaskData>(context, listen: false)
                  .addNewTask(inputText);
              Navigator.pop(context);
            },
            child: Text(
              'Add',
              style: TextStyle(color: Colors.cyan[400]),
            ),
          ),
        ],
      ),
    );
  }
}
