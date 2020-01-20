import 'package:eventish/components/bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('FIRST PAGE')),
        body: Center(
          child: Column(
            children: <Widget>[
              Text('Holis'),
            ],
          ),
        ),
      ),
    );
  }
}
