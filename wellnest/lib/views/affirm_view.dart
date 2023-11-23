import 'dart:async';
import 'dart:convert';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String> fetchAffirmation() async {
  final response = await http
      .get(Uri.parse('https://www.affirmations.dev'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    return jsonDecode(response.body)["affirmation"];
  } else {
    throw Exception('Failed to load alffirmation');
  }
}

class AffirmPage extends StatefulWidget {
  const AffirmPage({super.key});

  @override
  State<AffirmPage> createState() => _AffirmPageState();
}

class _AffirmPageState extends State<AffirmPage> {
  late Future<String> affirmation;

  @override
  void initState() {
    super.initState(); 
    
  }

  @override
  Widget build(BuildContext context) {
    affirmation = fetchAffirmation();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Affirmations'),
          backgroundColor: Colors.green.shade100,
          actions: [
            IconButton(onPressed: (){
                        setState(() {
                          affirmation = fetchAffirmation();
                        });
                        
                        
                      }, icon: const Icon(Icons.refresh))
          ],
        ),
        backgroundColor: Colors.blue.shade100,
        body: FutureBuilder<String>(
          future: affirmation,
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
        return Center(child: const CircularProgressIndicator());
      }
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 40),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      snapshot.data!,
                      textStyle: const TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 102, 102, 102)
                      ),
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('${snapshot.error}'));
            }

            // By default, show a loading spinner.
            return Center(child: const CircularProgressIndicator());
          },
        ),
        bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(226, 220, 222, 1),
        elevation: 2.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                    .pushNamed('/home/');
                  },
                  icon: const Icon(
                    Icons.home,
                    size: 50,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                    .pushNamed('/ablog/');
                    },
                  icon: const Icon(
                    Icons.edit_note,
                    size: 50,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                    .pushNamed('/pie_chart/');
                  },
                  icon: const Icon(
                    Icons.pie_chart_rounded,
                    size: 45,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}


  