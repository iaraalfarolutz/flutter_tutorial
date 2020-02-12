import 'package:eventish/components/Tab.dart';
import 'package:eventish/models/Event.dart';
import 'package:eventish/models/Task.dart';
import 'package:eventish/models/User.dart';
import 'package:eventish/screens/add_task.dart';
import 'package:eventish/screens/edit_event.dart';
import 'package:eventish/screens/location_page.dart';
import 'package:eventish/screens/show_event.dart';
import 'package:eventish/screens/show_task.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String showEvent = '/show/event';
  static const String editEvent = '/edit/event';
  static const String location = '/location';
  static const String addTask = '/add/tasks';
  static const String showTask = '/show/task';
}

class TabNavigator extends StatelessWidget {
  TabNavigator(
      {this.navigatorKey,
      this.tabItem,
      this.req,
      this.user,
      this.event,
      this.action});
  final String action;
  final User user;
  final Function req;
  final Event event;
  final GlobalKey<NavigatorState> navigatorKey;
  final TabItem tabItem;

  Future _push(BuildContext context,
      {String nextPage, Event event, User user, Task task, String newAction}) {
    var routeBuilders = _routeBuilders(context,
        nextPage: nextPage,
        event: event,
        newUser: user,
        task: task,
        newAction: newAction);
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => routeBuilders[nextPage](context)));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {String nextPage,
      Event event,
      User newUser,
      Task task,
      String newAction}) {
    return {
      TabNavigatorRoutes.root: (context) => MyTab(
            action: action,
            user: this.user,
            event: event,
            req: req,
            item: tabItem,
            onPush: ({nextPage, event, newUser, task}) => _push(context,
                nextPage: nextPage, event: event, user: newUser, task: task),
          ),
      TabNavigatorRoutes.editEvent: (context) => EditEvent(
            event: event,
            user: this.user,
            onPush: ({nextPage, event, newUser}) => _push(context,
                nextPage: nextPage,
                event: event,
                user: newUser,
                newAction: "ADD"),
          ),
      TabNavigatorRoutes.location: (context) => LocationPage(
            event: event,
            onPush: ({nextPage, event}) =>
                _push(context, nextPage: nextPage, event: event),
          ),
      TabNavigatorRoutes.showEvent: (context) => ShowEvent(
            event: event,
            onPush: ({nextPage, event}) =>
                _push(context, nextPage: nextPage, event: event),
          ),
      TabNavigatorRoutes.addTask: (context) => AddTask(
            user: newUser,
            action: newAction,
            onPush: ({nextPage, newUser}) =>
                _push(context, nextPage: nextPage, user: newUser),
          ),
      TabNavigatorRoutes.showTask: (context) => ShowTask(
            task: task,
            onPush: ({nextPage, newUser}) => _push(context,
                nextPage: nextPage,
                task: task,
                newAction: "UPDATE",
                user: newUser),
          ),
    };
  }

  @override
  Widget build(BuildContext context) {
    var routeBuilders = _routeBuilders(context);
    return Navigator(
        key: navigatorKey,
        initialRoute: TabNavigatorRoutes.root,
        onGenerateRoute: (routeSettings) {
          return MaterialPageRoute(
              builder: (context) => routeBuilders[routeSettings.name](context));
        });
  }
}
