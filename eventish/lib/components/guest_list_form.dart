import 'package:eventish/models/User.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'guest_list_singleton.dart';

// needs to be StatefulWidget, so we can keep track of the count of the fields internally
class GuestList extends StatefulWidget {
  const GuestList({this.initialCount, this.users});

  // also allow for a dynamic number of starting players
  final int initialCount;
  final List<User> users;

  @override
  _GuestListState createState() => _GuestListState();
}

class _GuestListState extends State<GuestList> {
  int fieldCount = 0;
  int nextIndex = 0;

  List<TextEditingController> controllers = <TextEditingController>[];
  GuestListSingleton singleton = new GuestListSingleton();

  // create the list of TextFields, based off the list of TextControllers
  List<Widget> _buildList() {
    int i;
    if (controllers.length < fieldCount) {
      for (i = controllers.length; i < fieldCount; i++) {
        if (widget.users != null && widget.users.isNotEmpty)
          controllers.add(
              TextEditingController(text: widget.users.elementAt(i).username));
        else
          controllers.add(TextEditingController());
      }
    }
    i = 0;
    return controllers.map<Widget>((TextEditingController controller) {
      int displayNumber = i + 1;
      i++;
      return TextField(
        controller: controller,
        maxLength: 20,
        onSubmitted: (text) {
          setState(() {
            singleton.addGuest(text);
          });
        },
        decoration: InputDecoration(
          labelText: "Guest $displayNumber",
          counterText: "",
          prefixIcon: const Icon(Icons.person),
          suffixIcon: IconButton(
            icon: Icon(Icons.clear),
            onPressed: () {
              setState(() {
                fieldCount--;
                controllers.remove(controller);
                singleton.removeGuest(controller.text);
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
            // singleton.addAllGuests(controllers);
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
}
