import 'package:eventish/models/Task.dart';
import 'package:flutter/material.dart';

class ShowTask extends StatelessWidget {
  final Task task;
  final Function onPush;
  ShowTask({this.task, this.onPush});
  @override
  Widget build(BuildContext context) {
    String title = task.title;
    return Center(
      child: Container(
        child: Text('ShowTask: $title'),
      ),
    );
  }
}
