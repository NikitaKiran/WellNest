import 'dart:math';

import 'package:flutter/material.dart';
import 'package:funvas/funvas.dart';


class Viewer extends StatefulWidget {
  const Viewer({
    Key? key,
    required this.boxes,
  }) : super(key: key);


  final List<SizedBox> boxes;

  @override
  _ViewerState createState() => _ViewerState();
}

class _ViewerState extends State<Viewer> {
  int _selectedIndex = 0;

  @override
  void didUpdateWidget(covariant Viewer oldWidget) {
    super.didUpdateWidget(oldWidget);

    _selectedIndex = min(_selectedIndex, widget.boxes.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 32,
            ),
            child: Center(
              child: AspectRatio(
                aspectRatio: 1,
                child: 
                   widget.boxes[_selectedIndex],
                
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(32),
          child: OutlinedButton(
            onPressed: () {
              setState(() {
                _selectedIndex = (_selectedIndex + 1) % widget.boxes.length;
              });
            },
            child: const Text('Next'),
          ),
        ),
      ],
    );
  }
}