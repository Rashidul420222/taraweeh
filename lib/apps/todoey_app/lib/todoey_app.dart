import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../lib/models/task_data.dart';
import '../lib/screens/task_screens.dart';

class TodoeyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<TaskData>(
      create: (context) => TaskData(),
      child: MaterialApp(
        home: SafeArea(
          child: TaskScreen(),
        ),
      ),
    );
  }
}
