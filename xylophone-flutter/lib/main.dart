import 'package:flutter/material.dart';
import 'package:audioplayers/audio_cache.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  final player = AudioCache();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              builKey(Colors.red, 1),
              builKey(Colors.orange, 2),
              builKey(Colors.yellow, 3),
              builKey(Colors.green, 4),
              builKey(Colors.teal, 5),
              builKey(Colors.blue, 6),
              builKey(Colors.purple, 7),
            ],
          ),
        ),
      ),
    );
  }

  Expanded builKey(Color color, int sound) {
    return Expanded(
      child: FlatButton(
        child: null,
        color: color,
        onPressed: () {
          player.play('note$sound.wav');
        },
      ),
    );
  }
}
