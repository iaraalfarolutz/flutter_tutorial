import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';

class TaskPage extends StatefulWidget {
  final User user;
  final Function onPush;
  TaskPage({this.user, this.onPush});
  @override
  _TaskPageState createState() => _TaskPageState();
}

class _TaskPageState extends State<TaskPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Task page'),
      ),
    );
  }
}
