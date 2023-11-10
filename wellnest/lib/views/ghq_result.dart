import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.score});
  final int score;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GHQ Screening'),
        backgroundColor: const Color(0xFFFFCACC),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            SizedBox(
              
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(child: (score > 4)? 
                Text('You seem to show signs of mental distress.\nIt is recommended that you consult a mental health professional in addition to using this app.', textAlign: TextAlign.justify, style: TextStyle(fontSize: 26),)
                :Text('You do not seem to show signs of mental distress!\nContinue using this app to take good care of your mental health.',textAlign: TextAlign.justify , style: TextStyle(fontSize: 26 ))),
              ),
            ),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushNamedAndRemoveUntil(
                    '/verify/',
                    (_) => false,
                  );
            },
            style: ElevatedButton.styleFrom(
              elevation: 4.0,
            ),
            child: Text('Proceed', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)))
          ],
        ),
      )

    );
  }
}