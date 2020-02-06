import 'package:eventish/models/Task.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';
import 'package:eventish/constants.dart';

class AddTask extends StatelessWidget {
  final User user;
  final Function onPush;
  final TextEditingController _multiLineTextFieldController =
      TextEditingController();
  AddTask({this.onPush, this.user});
  @override
  Widget build(BuildContext context) {
    String title;
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
                    onFieldSubmitted: (text) {
                      title = text;
                    },
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
                    onFieldSubmitted: (text) {
                      print("submitted");
                    },
                    onEditingComplete: () {
                      print("onedit");
                    },
                    cursorColor: kButtonColor,
                  ),
                ),
              ],
            ),
          ),
          RaisedButton(
            color: kButtonColor,
            child: Text("SAVE"),
            onPressed: () {
              Task task = new Task(
                  user: user.username,
                  confirmed: false,
                  description: _multiLineTextFieldController.text,
                  title: title);
              Navigator.of(context).pop(task);
            },
          ),
        ],
      ),
    );
  }
}
