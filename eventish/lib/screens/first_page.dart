import 'package:eventish/screens/add_event.dart';
import 'package:eventish/screens/edit_profile.dart';
import 'package:eventish/screens/event_page.dart';
import 'package:eventish/screens/task_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventish/models/User.dart';
import 'package:eventish/components/bottom_navigation_bar.dart';

List<Widget> pages;
Widget currentPage;
Widget edit;
Widget add;
Widget event;
Widget task;

final PageStorageBucket bucket = PageStorageBucket();

class FirstPage extends StatefulWidget {
  final User user;
  FirstPage({this.user});
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  int currentTab;
  @override
  void initState() {
    edit = EditProfile(user: widget.user);
    add = AddEvent(user: widget.user);
    event = EventPage(user: widget.user);
    task = TaskPage(user: widget.user);
    pages = [event, add, task, edit];
    currentPage = event;
    currentTab = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark().copyWith(
        primaryColor: Color(0xFF12173A),
        scaffoldBackgroundColor: Color(0xFF0A0D22),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Eventish')),
        ),
        bottomNavigationBar: MyBottomNavigationBar(
          currentpage: currentTab,
          onItemTapped: (int index) async {
            setState(() {
              currentTab = index;
              currentPage = pages[index];
            });
          },
        ),
        body: IndexedStack(
          index: currentTab,
          children: pages,
        ),
      ),
    );
  }
}
