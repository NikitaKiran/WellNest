import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final String basicEmotion;
  final Color givenColor;
  const Tile(this.givenColor, this.basicEmotion, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: givenColor,
      child: Center(
        child: Text(
          basicEmotion,
          style: const TextStyle(
            fontSize: 22.0,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 60, 60 ,60)
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
