import 'package:flutter/material.dart';
import 'package:eventish/constants.dart';

enum TabItem { event, add, task, edit }

Map<TabItem, String> tabName = {
  TabItem.edit: 'edit',
  TabItem.add: 'add event',
  TabItem.event: 'events',
  TabItem.task: 'task',
};

Map<TabItem, Icon> tabIcon = {
  TabItem.edit: Icon(Icons.person),
  TabItem.add: Icon(Icons.add_box),
  TabItem.event: Icon(Icons.calendar_today),
  TabItem.task: Icon(Icons.playlist_add_check),
};

class MyBottomNavigationBar extends StatefulWidget {
  final TabItem currentTab;
  final ValueChanged<TabItem> onSelectTab;
  MyBottomNavigationBar(
      {@required this.currentTab, @required this.onSelectTab});
  @override
  _MyBottomNavigationBarState createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
          // sets the background color of the `BottomNavigationBar`
          canvasColor: kBackColor,
          // sets the active color of the `BottomNavigationBar` if `Brightness` is light
          primaryColor: kButtonColor),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          _buildItem(tabItem: TabItem.event),
          _buildItem(tabItem: TabItem.add),
          _buildItem(tabItem: TabItem.task),
          _buildItem(tabItem: TabItem.edit),
        ],
        onTap: (index) => widget.onSelectTab(
          TabItem.values[index],
        ),
        backgroundColor: kBackColor,
      ),
    );
  }

  BottomNavigationBarItem _buildItem({TabItem tabItem}) {
    String text = tabName[tabItem];
    IconData icon = tabIcon[tabItem].icon;
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _colorTabMatching(item: tabItem)),
      title: Text(
        text,
        style: TextStyle(
          color: _colorTabMatching(item: tabItem),
        ),
      ),
    );
  }

  Color _colorTabMatching({TabItem item}) {
    return widget.currentTab == item ? kButtonColor : Colors.grey;
  }
}
