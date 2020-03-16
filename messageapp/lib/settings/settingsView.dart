import 'package:flutter/material.dart';
import 'package:messageapp/models/user.dart';

import '../constants.dart';

class SettingsView extends StatelessWidget {
  final User user;
  SettingsView({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Center(child: Text('Message App')),
      ),
      body: Column(
        children: <Widget>[
          CircleAvatar(
            child: Image.network(user.photoUrl),
            radius: 50.0, //arreglar
          ),
        ],
      ),
    );
  }
}
