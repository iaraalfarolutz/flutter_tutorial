import 'package:eventish/models/Event.dart';
import 'package:eventish/models/Task.dart';
import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';
import 'package:eventish/constants.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class AddTask extends StatefulWidget {
  final User user;
  final Function onPush;
  final String action;
  final Task task;
  final Event event;

  AddTask({this.onPush, this.user, this.action, this.task, this.event});
  @override
  _AddTaskState createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  String myUser;
  bool isAdd = false;
  Task myTask;
  String myAction;
  final TextEditingController _multiLineTextFieldController =
      TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  bool confirmed;
  GlobalKey<AutoCompleteTextFieldState<String>> autocomplateKey =
      new GlobalKey();

  @override
  void initState() {
    super.initState();
    isAdd = widget.task != null ? false : true;
    if (isAdd) {
      myTask = new Task();
      myAction = "ADD";
      confirmed = false;
    } else {
      confirmed = widget.task.confirmed;
      myTask = widget.task;
      myAction = "UPDATE";
    }
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
                      hintText: myTask != null
                          ? myTask.title != null ? myTask.title : "Title"
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
                      hintText: myTask != null
                          ? myTask.description != null
                              ? myTask.description
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
                ),
                Container(
                  child: isAdd
                      ? AutoCompleteTextField(
                          clearOnSubmit: false,
                          decoration: InputDecoration(
                            hintText: "Guest:",
                            suffixIcon: new Icon(Icons.search),
                            labelStyle: TextStyle(color: kButtonColor),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: kButtonColor)),
                          ),
                          style: TextStyle(color: Colors.white),
                          itemBuilder: (context, suggestion) => new Padding(
                              child: new ListTile(
                                title: new Text(suggestion),
                              ),
                              padding: EdgeInsets.all(8.0)),
                          key: autocomplateKey,
                          suggestions: widget.event.getGuestsUsernames(),
                          submitOnSuggestionTap: true,
                          itemSorter: (first, second) {
                            return first.compareTo(second);
                          },
                          itemSubmitted: (user) {
                            myUser = user;
                          },
                          itemFilter: (item, query) {
                            return item
                                .toLowerCase()
                                .startsWith(query.toLowerCase());
                          })
                      : Container(height: 0),
                )
              ],
            ),
          ),
          RaisedButton(
            color: kButtonColor,
            child: Text(myAction.toUpperCase()),
            onPressed: () {
              myUser = isAdd ? myUser : widget.user.username;
              Task task = new Task(
                  user: myUser,
                  confirmed: confirmed,
                  description: _multiLineTextFieldController.text,
                  eventId: widget.event.id,
                  title: _titleController.text);
              Navigator.of(context).pop(task);
            },
          ),
        ],
      ),
    );
  }
}
