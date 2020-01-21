import 'package:flutter/material.dart';
import 'package:eventish/constants.dart';

class MyBottomNavigationBar extends StatefulWidget {
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Events',
      style: kBottomNavigationBar,
    ),
    Text(
      'Index 1: New Event',
      style: kBottomNavigationBar,
    ),
    Text(
      'Index 2: Tasks',
      style: kBottomNavigationBar,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

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
      ],
      currentIndex: _selectedIndex,
      selectedItemColor: kButtonColor,
      backgroundColor: Color(0xFF12173A),
      onTap: _onItemTapped,
      type: BottomNavigationBarType.shifting,
    );
  }
}
