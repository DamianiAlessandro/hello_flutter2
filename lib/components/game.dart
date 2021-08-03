import 'dart:async';

import 'package:flutter/material.dart';
import 'package:hello_flutter2/components/play-number.dart';
import 'package:hello_flutter2/components/stars-display.dart';
import 'package:hello_flutter2/utils/MathUtils.dart';

class Game extends StatefulWidget {
  const Game({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Game> {
  int _stars = 9;
  List _availableNums = [];
  List _candidateNums = [];
  int _secondsLeft = 40;
  var subsTimer;

  bool candidatesAreWrong = false;
  String gameStatus = 'active';

  @override
  void initState() {
    setState(() {
      _stars = MathUtils.random(1, 9);
      _availableNums = MathUtils.range(1, 9);
      _candidateNums = [];
      _secondsLeft = 40;
      candidatesAreWrong = false;
      gameStatus = _availableNums.length == 0
          ? 'won'
          : _secondsLeft == 0
              ? 'lost'
              : 'active';
      timerCallBack();
    });
  }

  startNewGame() {
    setState(() {
      _stars = MathUtils.random(1, 9);
      _availableNums = MathUtils.range(1, 9);
      _candidateNums = [];
      _secondsLeft = 40;
      candidatesAreWrong = false;
      gameStatus = _availableNums.length == 0
          ? 'won'
          : _secondsLeft == 0
              ? 'lost'
              : 'active';
      timerCallBack();
    });
  }

  timerCallBack() {
    setState(() {
      _secondsLeft = _secondsLeft - 1;
      if (_secondsLeft > 0 && _availableNums.length > 0) {
        subsTimer =
            new Timer(const Duration(seconds: 1), () => {timerCallBack()});
      }
    });
  }

  setGameState(List newCandidateNums) {
    setState(() {
      if (subsTimer != null) {
        subsTimer.cancel();
        timerCallBack();
      }

      if (MathUtils.sum(newCandidateNums) != _stars) {
        _candidateNums = newCandidateNums;
      } else {
        _availableNums =
            _availableNums.where((n) => !newCandidateNums.contains(n)).toList();
        _stars = MathUtils.randomSumIn(_availableNums, 9);
        _candidateNums = [];
        gameStatus = _availableNums.length == 0
            ? 'won'
            : _secondsLeft == 0
                ? 'lost'
                : 'active';
      }
    });
  }

  String numberStatus(number) {
    if (!_availableNums.contains(number)) {
      return 'used';
    }

    if (_candidateNums.contains(number)) {
      return candidatesAreWrong ? 'wrong' : 'candidate';
    }

    return 'available';
  }

  onNumberClick(number, currentStatus) {
    if (currentStatus == 'used' || _secondsLeft == 0) {
      return;
    }
    List newCandidateNums = [];
    if (currentStatus == 'available') {
      newCandidateNums = List.from(_candidateNums)..addAll([number]);
    } else {
      newCandidateNums = _candidateNums.where((cn) => cn != number).toList();
    }

    setGameState(newCandidateNums);
  }

  generatePlayNumbers() {
    List<Widget> children = [];
    MathUtils.range(1, 9).forEach((num) {
      children.add(PlayNumber(
          status: numberStatus(num), number: num, onClick: onNumberClick));
    });
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          children: [
            Text(
              'Pick 1 or more numbers that sum to the number of stars. You have 40 seconds in order to complete the game',
              textAlign: TextAlign.center,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView(
                      children: [
                        if (_secondsLeft > 0 && _availableNums.length > 0)
                          StartDisplay(count: _stars),
                        if (_secondsLeft == 0 || _availableNums.length == 0)
                          TextButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.lightGreen),
                              minimumSize:
                                  MaterialStateProperty.all(Size(90, 90)),
                            ),
                            onPressed: () {
                              this.startNewGame();
                            },
                            child: Text('START PLAY'),
                          )
                      ],
                    ),
                  )
                ],
              ), // And rest of them in ListView
            ),
            /*Row(
              children: const <Widget>[
                Expanded(
                  child: Text('Deliver features faster', textAlign: TextAlign.center),
                ),
                StartDisplay(count: _stars),
              ],
            ),*/

            Expanded(
              child: ListView(
                children: [
                  Container(
                    height: 400,
                    child: GridView(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        // One row and several columns
                        crossAxisCount: 3,
                        // Set the size of each child element (aspect ratio)
                        childAspectRatio: 2,
                        // The distance between the left and right of the element
                        crossAxisSpacing: 1,
                        // The distance up and down the child element
                        mainAxisSpacing: 1,
                      ),
                      children: this.generatePlayNumbers(),
                    ),
                  )
                ],
              ),
            ),
            Text(
              'Time Remaining: ${_secondsLeft}',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
