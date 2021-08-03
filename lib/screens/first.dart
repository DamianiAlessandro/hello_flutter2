import 'package:flutter/material.dart';
import 'package:hello_flutter2/components/game.dart';
import 'package:hello_flutter2/components/skeleton-scaffold.dart';

class FirstPage extends StatelessWidget {

  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonScaffold(title: 'Game', body: Center(
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: Game(),
    ));
  }
}
