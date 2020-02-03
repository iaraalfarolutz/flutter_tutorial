import 'package:eventish/components/Tab.dart';
import 'package:eventish/models/Event.dart';
import 'package:eventish/models/User.dart';
import 'package:eventish/screens/edit_event.dart';
import 'package:eventish/screens/location_page.dart';
import 'package:eventish/screens/show_event.dart';
import 'package:flutter/material.dart';
import 'bottom_navigation_bar.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String showEvent = 'show/event';
  static const String editEvent = '/edit/event';
  static const String location = '/location';
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

  Future _push(BuildContext context, {String nextPage, Event event}) {
    var routeBuilders =
        _routeBuilders(context, nextPage: nextPage, event: event);
    return Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => routeBuilders[nextPage](context)));
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext context,
      {String nextPage, Event event}) {
    return {
      TabNavigatorRoutes.root: (context) => MyTab(
            action: action,
            user: user,
            event: event,
            req: req,
            item: tabItem,
            onPush: ({nextPage, event}) =>
                _push(context, nextPage: nextPage, event: event),
          ),
      TabNavigatorRoutes.editEvent: (context) => EditEvent(
            event: event,
            onPush: ({nextPage, event}) =>
                _push(context, nextPage: nextPage, event: event),
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
