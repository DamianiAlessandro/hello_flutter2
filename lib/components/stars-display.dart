import 'package:flutter/material.dart';
import 'package:hello_flutter2/utils/MathUtils.dart';

class StartDisplay extends StatelessWidget {

  StartDisplay({required this.count});
  final int count;

  @override
  Widget build(BuildContext context) {

    List<Widget> children = [];
    MathUtils.range(1, this.count).forEach((starId) {
      children.add(Icon(
        Icons.star,
        color: Colors.yellow,
        size: 20.0,
      ));
    });
    return Container(
      height: 400,
      child: GridView(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          // One row and several columns
          crossAxisCount: 4,
          // Set the size of each child element (aspect ratio)
          childAspectRatio: 1.8,
          // The distance between the left and right of the element
          crossAxisSpacing: 1,
          // The distance up and down the child element
          mainAxisSpacing: 1,
        ),
        children: children,
      ),
    );

  }
}
