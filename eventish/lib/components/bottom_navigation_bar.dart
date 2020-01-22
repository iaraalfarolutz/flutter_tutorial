import 'package:flutter/material.dart';
import 'package:eventish/constants.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final int currentpage;
  final Function onItemTapped;
  MyBottomNavigationBar(
      {@required this.currentpage, @required this.onItemTapped});
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.calendar_today),
          title: Text('Events'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box),
          title: Text('New Event'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.playlist_add_check),
          title: Text('Tasks'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          title: Text('Profile'),
        ),
      ],
      currentIndex: widget.currentpage,
      onTap: widget.onItemTapped,
      selectedItemColor: kButtonColor,
      backgroundColor: Color(0xFF12173A),
      type: BottomNavigationBarType.shifting,
    );
  }
}
