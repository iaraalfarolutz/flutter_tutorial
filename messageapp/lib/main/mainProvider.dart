import 'package:flutter/material.dart';
import 'package:messageapp/main/mainBloc.dart';

class MainProvider extends InheritedWidget {
  final MainBloc bloc = new MainBloc();

  MainProvider({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static MainBloc of(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<MainProvider>()).bloc;
  }
}
