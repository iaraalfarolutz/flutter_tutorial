import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:messageapp/components/my_app_bar.dart';
import 'package:messageapp/main/mainBloc.dart';
import 'package:messageapp/main/mainProvider.dart';
import 'package:messageapp/models/user.dart';

import '../constants.dart';

class MainView extends StatefulWidget {
  final User user;
  MainView({this.user});
  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  @override
  Widget build(BuildContext context) {
    final MainBloc bloc = MainProvider.of(context);
    bloc.addUsers();
    return new WillPopScope(
      onWillPop: onBackPressed,
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: MyAppBar(user: widget.user),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
              stream: bloc.getStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
                    ),
                  );
                } else {
                  return Flexible(
                    child: ListView.builder(
                      padding: EdgeInsets.all(10.0),
                      itemBuilder: (context, index) =>
                          buildItem(context, snapshot.data.elementAt(index)),
                      itemCount: snapshot.data.length,
                    ),
                  );
                }
              },
            )
          ],
        ),
      ),
    );
  }

  Future<bool> onBackPressed() async {
    showDialog<bool>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Are you sure you want to exit the app'),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes, Im sure'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
            FlatButton(
              child: Text('No'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
          ],
        );
      },
    ).then((value) {
      if (value) exit(0);
      return value;
    });
  }
}

buildItem(BuildContext context, User user) {
  return Container(
    child: FlatButton(
      child: Row(
        children: <Widget>[
          Material(
            child: user.photoUrl != null && user.photoUrl != ""
                ? CachedNetworkImage(
                    placeholder: (context, url) => Container(
                      child: CircularProgressIndicator(
                        strokeWidth: 1.0,
                        valueColor: AlwaysStoppedAnimation<Color>(kMainColor),
                      ),
                      width: 50.0,
                      height: 50.0,
                      padding: EdgeInsets.all(15.0),
                    ),
                    imageUrl: user.photoUrl,
                    width: 50.0,
                    height: 50.0,
                    fit: BoxFit.cover,
                  )
                : Icon(
                    Icons.account_circle,
                    size: 50.0,
                    color: Colors.grey,
                  ),
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
            clipBehavior: Clip.hardEdge,
          ),
          Flexible(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Text(
                      'Nickname: ${user.nickname}',
                      style: TextStyle(color: kMainColor),
                    ),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                  ),
                  Container(
                    child: Text(
                      'About me: ${user.aboutMe ?? 'Not available'}',
                      style: TextStyle(color: kMainColor),
                    ),
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                  )
                ],
              ),
              margin: EdgeInsets.only(left: 20.0),
            ),
          ),
        ],
      ),
      onPressed: () {
        //Vemos depsues
      },
      color: Colors.grey.shade100,
      padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    ),
    margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
  );
}
