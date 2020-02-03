import 'package:eventish/components/TabNavigator.dart';
import 'package:eventish/components/web_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:eventish/models/User.dart';
import 'package:eventish/components/bottom_navigation_bar.dart';

class FirstPage extends StatefulWidget {
  final navigatorKey = GlobalKey<NavigatorState>();
  final User user;
  FirstPage({this.user});
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TabItem _currentTab = TabItem.task;

  Map<TabItem, GlobalKey<NavigatorState>> navigatorKeys = {
    TabItem.edit: GlobalKey<NavigatorState>(),
    TabItem.add: GlobalKey<NavigatorState>(),
    TabItem.event: GlobalKey<NavigatorState>(),
    TabItem.task: GlobalKey<NavigatorState>(),
  };

  Function req = (event, location) {
    return WebService.postEvent(event, location);
  };

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async =>
          !await navigatorKeys[_currentTab].currentState.maybePop(),
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Eventish')),
        ),
        backgroundColor: Color(0xFF0A0D22),
        bottomNavigationBar: MyBottomNavigationBar(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabItem.event),
          _buildOffstageNavigator(TabItem.add),
          _buildOffstageNavigator(TabItem.task),
          _buildOffstageNavigator(TabItem.edit),
        ]),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabItem tabItem) {
    return Offstage(
        offstage: _currentTab != tabItem,
        child: TabNavigator(
          user: widget.user,
          req: req,
          action: "SAVE",
          navigatorKey: navigatorKeys[tabItem],
          tabItem: tabItem,
        ));
  }

  void _selectTab(TabItem tabItem) {
    setState(() {
      _currentTab = tabItem;
    });
  }
}
