import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String basic_emotion;
  final Color givenColor;
  const Tile(this.givenColor, this.basic_emotion, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          basic_emotion,
          style: TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 60, 60 ,60)
          ),
          textAlign: TextAlign.center,
        ),
      ),
      color: givenColor,
    );
  }
}
