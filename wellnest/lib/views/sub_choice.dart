import 'package:flutter/material.dart';
import 'package:wellnest/views/recommend.dart';

class SubChoiceScreen extends StatefulWidget {
  final String emotion;
  final Color emotionColor;
  final List subEmotionsList;
  final List emotionType;
  const SubChoiceScreen(this.emotion, this.emotionColor, this.subEmotionsList, this.emotionType, {Key? key}) : super(key: key);
  @override
  State<SubChoiceScreen> createState() => _SubChoiceScreenState();
}

class _SubChoiceScreenState extends State<SubChoiceScreen> {
  
  @override
  Widget build(BuildContext context) {
    String emotion1 = widget.subEmotionsList[0];
    String emotion2 = widget.subEmotionsList[1];
    String emotion3 = widget.subEmotionsList[2];
    Color emotionColor = widget.emotionColor;
    int tag1 = widget.emotionType[0];
    int tag2 = widget.emotionType[1];
    int tag3 = widget.emotionType[2];
    return Scaffold(
      backgroundColor: const Color.fromRGBO(226, 220, 222, 1),
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
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                 children: [
                  Padding(
                    padding: const EdgeInsets.all(50.0),
                    child: Center(
                      child: Wrap(
                        spacing: 20.0,
                        runSpacing: 20.0,
                        children: [
                          SizedBox(
                            width: 300.0,
                            height: 100.0,
                            child: ElevatedButton(
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> RecommendScreen(tag1, emotionColor)));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: emotionColor,
                                fixedSize: const Size(350, 50),
                                elevation: 4.0
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Column(
                                    children: [
                                      Text(emotion1,
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> RecommendScreen(tag2, emotionColor)));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: emotionColor,
                                fixedSize: const Size(350, 50),
                                elevation: 4.0
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Column(
                                    children: [
                                      Text(emotion2,
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
                                Navigator.push(context, MaterialPageRoute(builder: (context)=> RecommendScreen(tag3, emotionColor)));
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: emotionColor,
                                fixedSize: const Size(350, 50),
                                elevation: 4.0
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(28.0),
                                  child: Column(
                                    children: [
                                      Text(emotion3,
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
