import 'package:flutter/material.dart';

class RecommendScreen extends StatefulWidget {
  final int emotionTag;
  final Color emotionColor;
  const RecommendScreen(this.emotionTag, this.emotionColor, {Key? key}) : super(key: key);
  @override
  State<RecommendScreen> createState() => _RecommendScreenState();
}

class _RecommendScreenState extends State<RecommendScreen> {
  
  @override
  Widget build(BuildContext context) {
    int tag = widget.emotionTag;
    Color emotionColor = widget.emotionColor;
    List statement = ["We're sorry to hear that, Would you like to try any of the following?", "We're happy to know that! Would you like to try any of the following?"];
    List activityNav = [['/notes/', '/options/', '/relax/'], ['/notes/', '/affirm/']];
    List activities = [["Journal", "Meditate", "Relax"], ["Journal", "Affirm"]];
    return Scaffold(
      backgroundColor: emotionColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: emotionColor,
        elevation: 2.0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text('Tell us more about it', 
        style: TextStyle(color: Color.fromARGB(255, 60, 60, 60),
        fontWeight: FontWeight.bold),
        ),
      ),
      
      body: SingleChildScrollView(
        child: SafeArea(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Wrap(
                spacing: 20.0,
                runSpacing: 20.0,
                children: [
                  SizedBox(
                    width: 300.0,
                    height: 150.0,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Column(
                            children: [
                              Text(statement[tag],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25.0))
                            ],
                          ),
                        ),
                      ),
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/notes/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(221, 187, 204, 1),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/journal.png",
                                  width: 80.0, height: 80.0),
                              const SizedBox(height: 8.0),
                              const Text("Journal",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/affirm/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(250, 243, 240, 1),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/affirm.png",
                                  width: 80.0, height: 80.0),
                              const SizedBox(height: 8.0),
                              const Text("Affirm",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/journal/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(221, 187, 204, 1),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/journal.png",
                                  width: 80.0, height: 80.0),
                              const SizedBox(height: 8.0),
                              const Text("Journal",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ])),
      )
    );
  }
}
