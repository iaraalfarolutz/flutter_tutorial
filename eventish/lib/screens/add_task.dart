import 'package:eventish/models/Task.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';
import 'package:eventish/constants.dart';

class AddTask extends StatelessWidget {
  final User user;
  final Function onPush;
  final String action;
  final TextEditingController _multiLineTextFieldController =
      TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  AddTask({this.onPush, this.user, this.action});
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
                      hintText: "Title",
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
                      hintText: "Description",
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
              ],
            ),
          ),
          RaisedButton(
            color: kButtonColor,
            child: Text(action.toUpperCase()),
            onPressed: () {
              Task task = new Task(
                  user: user.username,
                  confirmed: false,
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
