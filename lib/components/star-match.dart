import 'package:flutter/material.dart';

class StartMatch extends StatefulWidget {
  const StartMatch({Key? key}) : super(key: key);

  @override
  _StartMatchState createState() => _StartMatchState();
}

class _StartMatchState extends State<StartMatch> {
  int _gameId = 1;

  startNewGame() {
    setState(() {
      _gameId++;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(

    );
  }
}
