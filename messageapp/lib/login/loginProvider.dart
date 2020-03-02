import 'package:flutter/material.dart';
import 'package:messageapp/login/loginBloc.dart';

class LoginProvider extends InheritedWidget {
  final LoginBloc bloc = LoginBloc();

  LoginProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static LoginBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<LoginProvider>()).bloc;
  }
}
