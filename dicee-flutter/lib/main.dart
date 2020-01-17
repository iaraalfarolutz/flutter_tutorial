import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  return runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.red,
        appBar: AppBar(
          title: Text('Dicee'),
          backgroundColor: Colors.red,
        ),
        body: DicePage(),
      ),
    ),
  );
}

class DicePage extends StatefulWidget {
  @override
  _DicePageState createState() => _DicePageState();
}

class _DicePageState extends State<DicePage> {
  int left_dice = 1;
  int right_dice = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Row(
        children: <Widget>[
          Expanded(
            child: FlatButton(
              child: Image.asset('images/dice$left_dice.png'),
              onPressed: () {
                setDiceState();
              },
            ),
          ),
          Expanded(
            child: FlatButton(
              child: Image.asset('images/dice$right_dice.png'),
              onPressed: () {
                setDiceState();
              },
            ),
          ),
        ],
      ),
    );
  }

  void setDiceState() {
    setState(() {
      left_dice = Random().nextInt(6) + 1;
      right_dice = Random().nextInt(6) + 1;
    });
  }
}
