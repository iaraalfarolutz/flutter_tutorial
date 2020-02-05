import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ScoreList extends StatefulWidget {
  final int score;
  final String team;
  ScoreList({this.score, this.team});
  //esto que hice es re croto creo
  final _ScoreListState scoreListState = new _ScoreListState();
  @override
  _ScoreListState createState() => scoreListState;
  void updateScore() {
    scoreListState.updateScore();
  }

  void redrawScore() {
    scoreListState.redrawScore();
  }

  void checkForWinner() {
    scoreListState.checkForWinner();
  }
}

class _ScoreListState extends State<ScoreList> {
  List<Widget> scores;
  int score;
  @override
  void initState() {
    super.initState();
    this.scores = [];
    this.score = widget.score;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: this.scores,
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
    );
  }

  void updateScore() {
    this.score++;
  }

  void redrawScore() {
    setState(() {
      String imageTitle = 'images/$score.png';
      if (this.score < 6 && this.scores.isEmpty) {
        this.scores.clear();
      } else {
        int aux = this.score % 5;
        int level = (this.score / 5).ceil();
        if (level > 3) level++;
        if (aux == 0) aux = 5;
        imageTitle = 'images/$aux.png';

        if (this.scores.length > level - 1 && this.score != 16)
          this.scores.removeAt(level - 1);
      }

      Widget container = Container(
        alignment: Alignment.topCenter,
        child: Image.asset(imageTitle),
        height: 50.0,
        width: 50.0,
        margin: const EdgeInsets.all(3.0),
      );

      this.scores.add(container);

      if (this.score == 15) {
        Widget divider = new SizedBox(
          height: 30.0,
          width: 75.0,
          child: Divider(
            color: Colors.teal,
          ),
        );
        this.scores.add(divider);
      }
    });
  }

  void checkForWinner() {
    if (this.score > 30) {
      String winner = widget.team;
      Alert(
        context: context,
        title: '$winner WON!',
        desc: "Press clear to restart.",
        buttons: [
          DialogButton(
            child: Text(
              "CLEAR",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
      cleanBoard();
    }
  }

  void cleanBoard() {
    this.score = 0;
    this.scores.clear();
  }
}
