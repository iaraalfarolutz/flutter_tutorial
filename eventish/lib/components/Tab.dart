import 'package:eventish/models/Event.dart';
import 'package:eventish/models/User.dart';
import 'package:eventish/screens/edit_profile.dart';
import 'package:eventish/screens/event_form.dart';
import 'package:eventish/screens/event_list_page.dart';
import 'package:eventish/screens/task_page.dart';
import 'package:flutter/material.dart';

import 'bottom_navigation_bar.dart';

class MyTab extends StatelessWidget {
  final TabItem item;
  final User user;
  final Event event;
  final String action;
  final Function req;
  final Function onPush;
  Widget rootPage;

  MyTab(
      {this.item, this.user, this.event, this.req, this.onPush, this.action}) {
    switch (this.item) {
      case TabItem.add:
        rootPage = EventForm(
          user: user,
          request: req,
          action: action,
          event: event,
          onPush: onPush,
        );
        break;
      case TabItem.edit:
        rootPage = EditProfile(
          user: user,
          onPush: onPush,
        );
        break;
      case TabItem.event:
        rootPage = EventListPage(
          user: user,
          onPush: onPush,
        );
        break;
      case TabItem.task:
        rootPage = TaskPage(
          user: user,
          onPush: onPush,
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return rootPage;
  }
}
