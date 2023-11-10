
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
    'felt you couldn\'t overcome your difficulties?',
    'been able to enjoy your normal day-to-day activities?',
    'been able to face up to your problems?',
    'been feeling unhappy and depressed?',
    'been losing confidence in yourself?',
    'been thinking of yourself as a worthless person?',
    'been feeling reasonably happy, all things considered?',
  ];
  final List<List<String>> options = [
    [' More than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' More than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' More than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' More than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' More than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' Not at all ', ' No more than usual ', ' More than usual ', ' Much more than usual '],
    [' More than usual ', ' Same as usual ', ' Less than usual ', ' Much less than usual '],
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
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('In the past two weeks have you...',
              style: TextStyle(
                color: Color.fromARGB(255, 102, 102, 102),
                fontSize: 24,
                fontWeight: FontWeight.bold),
              ),
            ),
            for (var i = 0; i< 12; i++)
                Column( 
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(questions[i], style: const TextStyle(color: Color.fromARGB(255, 77, 77, 77),fontSize: 16)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: CupertinoSlidingSegmentedControl(
                  children: {
                    0: Text(options[i][0], textAlign: TextAlign.center,),
                    1: Text(options[i][1], textAlign: TextAlign.center,),
                    2: Text(options[i][2], textAlign: TextAlign.center,),
                    3: Text(options[i][3], textAlign: TextAlign.center,),
                  },
                  groupValue: _op[i],
                  thumbColor: const Color(0xFFFFCACC),
                  //backgroundColor: Colors.blueGrey.shade100,
                  onValueChanged: (value) {
                    setState(() {
                      if (value != null) {
                        _score[i] = value ~/ 2;
                        _op[i] = value;
                      }
                    });
                  },
                ),
              )
            ),
            const SizedBox(height: 15,)
          ],
        ),
            
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: () {
                          Navigator.pop(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ResultPage(score: _score.sum)));
                          },
                          style: ElevatedButton.styleFrom(
                            elevation: 4.0,
                          ),
                          child:const Text('Confirm', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14))),
            ),
          ],
        ),
      ),
    );
  }
}

