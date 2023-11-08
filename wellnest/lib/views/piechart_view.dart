import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class PiechartScreen extends StatefulWidget {
  const PiechartScreen({Key? key}) : super(key: key);
  @override
  State<PiechartScreen> createState() => _PiechartScreenState();
}

class _PiechartScreenState extends State<PiechartScreen>{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Emotion records"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFCACC),
      ),
    );
  }
}

Map<String, double> dataMap = {
    "Flutter": 5,
    "React": 3,
    "Xamarin": 2,
    "Ionic": 2,
  };
