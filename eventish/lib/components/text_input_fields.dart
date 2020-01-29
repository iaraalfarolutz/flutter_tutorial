import 'dart:js';

import 'package:flutter/material.dart';

import '../constants.dart';

// needs to be StatefulWidget, so we can keep track of the count of the fields internally
class GuestList extends StatefulWidget {
  const GuestList({this.initialCount, this.guests, this.updater});

  // also allow for a dynamic number of starting players
  final int initialCount;
  final List<String> guests;
  final ValueChanged<List<String>> updater;

  @override
  _GuestListState createState() => _GuestListState();
}

class _GuestListState extends State<GuestList> {
  int fieldCount = 0;
  int nextIndex = 0;
  // you must keep track of the TextEditingControllers if you want the values to persist correctly
  List<TextEditingController> controllers = <TextEditingController>[];

  // create the list of TextFields, based off the list of TextControllers
  List<Widget> _buildList() {
    int i;
    // fill in keys if the list is not long enough (in case we added one)
    if (controllers.length < fieldCount) {
      for (i = controllers.length; i < fieldCount; i++) {
        controllers.add(TextEditingController());
      }
    }

    sendUpdates(getUsers());
    i = 0;
    // cycle through the controllers, and recreate each, one per available controller
    return controllers.map<Widget>((TextEditingController controller) {
      int displayNumber = i + 1;
      i++;
      sendUpdates(getUsers());
      return TextField(
        controller: controller,
        maxLength: 20,
        onSubmitted: (text) {
          setState(() {
            sendUpdates(getUsers());
          });
        },
        decoration: InputDecoration(
          labelText: "Guest $displayNumber",
          counterText: "",
          prefixIcon: const Icon(Icons.person),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              // when removing a TextField, you must do two things:
              // 1. decrement the number of controllers you should have (fieldCount)
              // 2. actually remove this field's controller from the list of controllers
              setState(() {
                fieldCount--;
                controllers.remove(controller);
                sendUpdates(getUsers());
              });
            },
          ),
        ),
      );
    }).toList(); // convert to a list
  }

  @override
  Widget build(BuildContext context) {
    // generate the list of TextFields
    final List<Widget> children = _buildList();

    // append an 'add player' button to the end of the list
    children.add(
      GestureDetector(
        onTap: () {
          // when adding a player, we only need to inc the fieldCount, because the _buildList()
          // will handle the creation of the new TextEditingController
          setState(() {
            sendUpdates(getUsers());
            fieldCount++;
          });
        },
        child: Container(
          color: kButtonColor,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Center(
              child: Text(
                'ADD',
                style: TextStyle(color: Colors.white, fontSize: 15.0),
              ),
            ),
          ),
        ),
      ),
    );

    // build the ListView
    return ListView(
      padding: EdgeInsets.all(0),
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  @override
  void initState() {
    super.initState();

    fieldCount = widget.initialCount;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(GuestList oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  List<String> getUsers() {
    List<String> users = new List<String>();
    for (int i = 0; i < controllers.length; i++) {
      users.add(controllers.elementAt(i).text);
    }
    return users;
  }

  void _handleBackupChanged(bool value) {
    sendUpdates(getUsers());
  }

  void sendUpdates(List<String> value) {
    if (widget.updater != null) widget.updater(value);
  }
}
