import 'package:flutter/material.dart';
import 'package:wellnest/gol/game_of_life.dart';


class GameView extends StatelessWidget {
  const GameView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: const Color(0xFFFFCACC), title: const Text('Conway\'s Game of Life'),),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all()),
              child: const GameOfLife(
                milliseconds: 200,
                cellSize: 14,
                hideControls: false,
                cellsColor:  Color(0xFFD4E2D4),
              ),
            ),
          ),
        ),
    );
  }
}