import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:messageapp/constants.dart';
import 'package:messageapp/login/loginBloc.dart';
import 'package:messageapp/main/mainProvider.dart';
import 'package:messageapp/main/mainView.dart';
import 'package:messageapp/models/user.dart';

import 'loginProvider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final LoginBloc bloc = LoginProvider.of(context);
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kMainColor,
        title: Center(child: Text('Message App')),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text(
              'Message App',
              style: TextStyle(
                  fontFamily: 'PoiretOne',
                  color: kMainColor,
                  fontSize: 65.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder(
              stream: bloc.getStream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.active &&
                    snapshot.hasData &&
                    snapshot.data != null) {
                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    openDetailPage(snapshot.data, context);
                  });
                }
                return RaisedButton(
                    child: Text(
                      'SIGN IN WITH GOOGLE',
                      style: TextStyle(color: Colors.white),
                    ),
                    color: Colors.red,
                    hoverColor: kButtonColor,
                    padding: EdgeInsets.all(20.0),
                    onPressed: () => bloc.signInUser());
              }),
        ],
      ),
    );
  }
}

openDetailPage(User user, BuildContext context) {
  final page = MainProvider(child: MainView(user: user));
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (context) => page),
  );
}
