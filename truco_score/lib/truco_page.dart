import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:truco_score/score_list.dart';

class Truco extends StatefulWidget {
  final int players;
  Truco({Key key, this.players}) : super(key: key);
  @override
  _TrucoState createState() => _TrucoState();
}

class _TrucoState extends State<Truco> {
  ScoreList t1 = new ScoreList(score: 0, team: "NOSOTROS");
  ScoreList t2 = new ScoreList(score: 0, team: "ELLOS");
  ScoreList t3 = new ScoreList(score: 0, team: "TERCEROS");

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Truco',
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Truco')),
          backgroundColor: Colors.blueAccent,
        ),
        body: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Nosotros",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(flex: 5, child: t1),
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        heroTag: "Nosotros",
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          setState(() {
                            t1.updateScore();
                            t1.redrawScore();
                            t1.checkForWinner();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Text(
                        "Ellos",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 30.0,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: t2,
                    ),
                    Expanded(
                      flex: 1,
                      child: FloatingActionButton(
                        heroTag: "Ellos",
                        backgroundColor: Colors.green,
                        child: Icon(
                          Icons.add,
                        ),
                        onPressed: () {
                          setState(() {
                            t2.updateScore();
                            t2.redrawScore();
                            t2.checkForWinner();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
              if (widget.players == 3)
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Text(
                          "Terceros",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 30.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                      Expanded(flex: 6, child: t3),
                      Expanded(
                        flex: 1,
                        child: FloatingActionButton(
                          heroTag: "Terceros",
                          backgroundColor: Colors.green,
                          child: Icon(
                            Icons.add,
                          ),
                          onPressed: () {
                            setState(() {
                              t3.updateScore();
                              t3.redrawScore();
                              t3.checkForWinner();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
            ]),
      ),
    );
  }
}
