import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pie_chart/pie_chart.dart';

class PiechartScreen extends StatefulWidget {
  const PiechartScreen({Key? key}) : super(key: key);
  @override
  State<PiechartScreen> createState() => _PiechartScreenState();
}

class _PiechartScreenState extends State<PiechartScreen> {
  int key = 0;
  final user = FirebaseAuth.instance.currentUser;

  late List<mood> _mood = [];

  Map<String, double> getEmotionsData() {
    Map<String, double> dataMap = {
      "Happy": 1,
      "Trust": 1,
      "Fear": 1,
      "Surprise": 1,
      "Sad": 1,
      "Disgust": 1,
      "Anger": 1,
      "Anticipation": 1
    };
    for (var item in _mood) {
      dataMap[item.emotion] = item.emotionCount;
    }
      return dataMap;
    
  }

  List <Color> colorList= const [Color.fromRGBO(245,245,178,1),
  Color.fromRGBO(178,245,178,1),
  Color.fromRGBO(178,245,228,1),
  Color.fromRGBO(178,212,245,1), 
  Color.fromRGBO(178,178,245,1),
  Color.fromRGBO(228,178,245,1), 
  Color.fromRGBO(245,178,178,1), 
  Color.fromRGBO(255,222,180,1),
  ];

  Widget piechartexampleone() {
    return PieChart(
      key: ValueKey(key),
      dataMap: getEmotionsData(),
      chartRadius: MediaQuery.of(context).size.width / 1.7,
      colorList: colorList,
      legendOptions: const LegendOptions(
        showLegendsInRow: false,
        legendPosition: LegendPosition.bottom,
        showLegends: true,
        legendTextStyle: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      chartValuesOptions: const ChartValuesOptions(
        showChartValueBackground: false,
        showChartValues: true,
        showChartValuesInPercentage: true,
        showChartValuesOutside: false,
        decimalPlaces: 0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> emostream = FirebaseFirestore.instance.collection('Moods').where('UID', isEqualTo: user?.uid).snapshots();

    void getEmoFromSnapshot(snapshot) {
      if (snapshot.docs.isNotEmpty) {
        _mood = [];
        for (int i = 0; i < snapshot.docs.length; i++) {
          var a = snapshot.docs[i];
          mood emo = mood.fromjson(a.data());
          _mood.add(emo);
        }
      }
    }


    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Emotion records"),
        centerTitle: true,
        backgroundColor: const Color(0xFFFFCACC),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 50,
            ),
            StreamBuilder<Object>(
              stream: emostream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return const Text("something went wrong");
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                }
                final data = snapshot.requireData;
                print("data: $data");
                getEmoFromSnapshot(data);
                return piechartexampleone();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class mood{
  String emotion;
  double emotionCount;

  mood({
    required this.emotion,
    required this.emotionCount
  });

  factory mood.fromjson(Map<String, dynamic> json) {
    return mood(
      emotion: json['emotion'],
      emotionCount: json['emotionCount'],
    );
  }
}

