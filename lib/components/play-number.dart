import 'package:flutter/material.dart';

class PlayNumber extends StatelessWidget {
  // Color Theme
  final colors = ColorToUse();

  final String status;
  final int number;
  final Function onClick;

  PlayNumber({required this.status, required this.number, required this.onClick}) : super();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(colors.getColor(this.status)),
        minimumSize: MaterialStateProperty.all(Size(45, 45)),
      ),
      onPressed: () { this.onClick(this.number, this.status);},
      child: Text(this.number.toString(),
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold
        ),

      ),
    );
  }
}

class ColorToUse {
  static final available = Colors.grey;
  static final used = Colors.green;
  static final wrong = Colors.orange;
  static final candidate = Colors.lightBlue;

  Color getColor(status) {
    Color col =  Colors.grey;
    if (status == 'used') {
      col = used;
    }else if (status == 'wrong') {
      col = wrong;
    } else if (status == 'available') {
      col = available;
    } else if (status == 'candidate')  {
      col = candidate;
    }
    return col;
  }

}
