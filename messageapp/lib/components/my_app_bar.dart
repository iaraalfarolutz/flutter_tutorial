import 'package:flutter/material.dart';
import 'package:messageapp/main/mainBloc.dart';
import 'package:messageapp/main/mainProvider.dart';
import 'package:messageapp/models/user.dart';
import 'package:messageapp/settings/settingsView.dart';

import '../constants.dart';

onPushSettings(BuildContext context, User user) {
  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => SettingsView(
              user: user,
            )),
  );
}

onPushLogout(BuildContext context, User user) {
  MainBloc bloc = MainProvider.of(context);
  bloc.handleSignOut(context);
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Settings', icon: Icons.settings, onPush: onPushSettings),
  const Choice(title: 'Logout', icon: Icons.exit_to_app, onPush: onPushLogout),
];

class MyAppBar extends StatefulWidget implements PreferredSizeWidget {
  final User user;
  MyAppBar({this.user});
  @override
  _MyAppBarState createState() => _MyAppBarState();

  @override
  Size get preferredSize => new Size.fromHeight(kToolbarHeight);
}

class _MyAppBarState extends State<MyAppBar> {
  void _select(Choice choice) {
    choice.onPush(context, widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return new AppBar(
      backgroundColor: kMainColor,
      title: Center(child: Text('Message App')),
      actions: <Widget>[
        PopupMenuButton<Choice>(
          onSelected: _select,
          itemBuilder: (BuildContext context) {
            return choices.map((Choice choice) {
              return PopupMenuItem<Choice>(
                value: choice,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Icon(
                      choice.icon,
                      color: kMainColor,
                    ),
                    SizedBox(
                      width: 20.0,
                    ),
                    Text(choice.title),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ],
    );
  }
}

class Choice {
  const Choice({this.title, this.icon, this.onPush});

  final String title;
  final IconData icon;
  final Function onPush;
}
