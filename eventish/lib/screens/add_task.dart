import 'package:eventish/models/Task.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';
import 'package:eventish/constants.dart';

class AddTask extends StatefulWidget {
  final User user;
  final Function onPush;
  final String action;
  final Task task;

  AddTask({this.onPush, this.user, this.action, this.task});
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController _multiLineTextFieldController =
      TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  bool confirmed;

  @override
  void initState() {
    super.initState();
    confirmed = widget.task != null ? widget.task.confirmed : false;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: widget.task != null
                          ? widget.task.title != null
                              ? widget.task.title
                              : "Title"
                          : "Title",
                      labelStyle: TextStyle(color: kButtonColor),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kButtonColor)),
                      border: OutlineInputBorder(),
                      fillColor: kButtonColor,
                      hoverColor: kButtonColor,
                      labelText: 'Title',
                    ),
                    controller: _titleController,
                    cursorColor: kButtonColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    controller: _multiLineTextFieldController,
                    decoration: InputDecoration(
                      hintText: widget.task != null
                          ? widget.task.description != null
                              ? widget.task.description
                              : "Description"
                          : "Description",
                      labelStyle: TextStyle(color: kButtonColor),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: kButtonColor)),
                      border: OutlineInputBorder(),
                      fillColor: kButtonColor,
                      hoverColor: kButtonColor,
                      labelText: 'Description',
                    ),
                    cursorColor: kButtonColor,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        'Confirmed: ',
                        style: TextStyle(
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Switch(
                      activeColor: kButtonColor,
                      value: confirmed,
                      onChanged: (bool val) {
                        setState(() {
                          this.confirmed = val;
                          print(confirmed);
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
          RaisedButton(
            color: kButtonColor,
            child: Text(widget.action.toUpperCase()),
            onPressed: () {
              Task task = new Task(
                  user: widget.user.username,
                  confirmed: confirmed,
                  description: _multiLineTextFieldController.text,
                  title: _titleController.text);
              Navigator.of(context).pop(task);
            },
          ),
        ],
      ),
    );
  }
}
