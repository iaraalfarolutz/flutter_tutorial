import 'package:flutter/material.dart';
import 'package:messageapp/main/mainBloc.dart';
import 'package:messageapp/main/mainProvider.dart';
import 'package:messageapp/models/user.dart';

import '../constants.dart';

class MainView extends StatelessWidget {
  final User user;
  MainView({this.user});
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = MainProvider.of(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Center(child: Text('Message App')),
      ),
      body: Container(
        child: Center(
          child: Text('Main Page ${user.nickname}'),
        ),
      ),
    );
  }
}
