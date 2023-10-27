import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wellnest/views/ghq_result.dart';

class GHQView extends StatefulWidget {
  const GHQView({super.key});

  @override
  State<GHQView> createState() => _GHQViewState();
}

class _GHQViewState extends State<GHQView> {
  final List <int> _score = [0,0,0,0,0,0,0,0,0,0,0,0];
  final List <int> _op = [0,0,0,0,0,0,0,0,0,0,0,0];
  final List<String> questions = [
    'been able to concentrate on whatever you\'re doing?',
    'lost much sleep over worry?',
    'felt that you are playing a useful part in things?',
    'felt capable of making decisions about things?',
    'felt constantly under strain?',
    'felt you couldn’t overcome your difficulties?',
    'been able to enjoy your normal day-to-day activities?',
    'been able to face up to your problems?',
    'been feeling unhappy and depressed?',
    'been losing confidence in yourself?',
    'been thinking of yourself as a worthless person?',
    'been feeling reasonably happy, all things considered?',
  ];
  final List<List<String>> options = [
    [' More so than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' More so than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' More so than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' More so than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' More so than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' More so than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GHQ Screening'),
        backgroundColor: const Color(0xFFFFCACC),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text('In the past two weeks have you...',style: TextStyle(fontSize: 20),),
            ),
            for (var i = 0; i< 12; i++)
                Column( 
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(questions[i]),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CupertinoSegmentedControl(
                      children: {
                        0: Text(options[i][0]),
                        1: Text(options[i][1]),
                        2: Text(options[i][2]),
                        3: Text(options[i][3]),
                      },
                      groupValue: _op[i],
                
                      unselectedColor: Colors.blueGrey.shade100,
                      onValueChanged: (value) {
                        setState(() {
                          _score[i] = value ~/ 2;
                          _op[i] = value;
                        });
                      },
                    ),
            ),
            SizedBox(height: 15,)
          ],
        ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {
                          Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(score: _score.sum)));
                          },child:const Text('Confirm')),
            ),
          ],
        ),
      ),
    );
  }
}

