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
    List activityNav = [['/notes/', '/options/', '/relax/'], ['/notes/', '/affirm/','/doodle/']];
    List activities = [["Journal", "Meditate", "Relax"], ["Journal", "Affirm", "Doodle"]];
    return Scaffold(
      backgroundColor: emotionColor,
      appBar: AppBar(
        centerTitle: true,
        elevation: 5.0,
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
                    width: 300.0,
                    height: 100.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(activityNav[tag][0]);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(350, 50),
                        elevation: 4.0
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Column(
                            children: [
                              Text(activities[tag][0],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300.0,
                    height: 100.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(activityNav[tag][1]);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(350, 50),
                        elevation: 4.0
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Column(
                            children: [
                              Text(activities[tag][1],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 300.0,
                    height: 100.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(activityNav[tag][2]);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(350, 50),
                        elevation: 4.0
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(28.0),
                          child: Column(
                            children: [
                              Text(activities[tag][2],
                                  style: const TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24.0))
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
