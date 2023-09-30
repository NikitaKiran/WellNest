import 'package:flutter/material.dart';

class SubChoiceScreen extends StatefulWidget {
  final String emotion;
  final Color emotionColor;
  const SubChoiceScreen(this.emotion, this.emotionColor, {Key? key}) : super(key: key);
  @override
  State<SubChoiceScreen> createState() => _SubChoiceScreenState();
}

class _SubChoiceScreenState extends State<SubChoiceScreen> {
  
  
  @override
  Widget build(BuildContext context) {
    Color emotionColor = widget.emotionColor;
    return Scaffold(
      backgroundColor: emotionColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: emotionColor,
        elevation: 2.0,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text('Tell us more about it', 
        style: TextStyle(color: Color.fromARGB(255, 60, 60, 60),
        fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
        ),
      ),
    );
  }
}

class SubEmotions {
  String? names;
  Color? color;

  SubEmotions({
    this.names,
    this.color,
  });

  void setData(String getName, Color getColor) {
    names = getName;
    color = getColor;
  }

  String getName() {
    return names!;
  }
}

List<SubEmotions> allStates() {
  List<SubEmotions> emotions = [];
  SubEmotions statesModel = new SubEmotions();

  //1
  statesModel.setData("Happy", Color.fromRGBO(245,245,178,1));
  emotions.add(statesModel);
  statesModel = new SubEmotions();

  //2
  statesModel.setData("Satisfied", Color.fromRGBO(178,245,178,1));
  emotions.add(statesModel);
  statesModel = new SubEmotions();

  //3
  statesModel.setData("Fear", Color.fromRGBO(178,245,228,1));

  emotions.add(statesModel);
  statesModel = new SubEmotions();

  //4
  statesModel.setData("Surprise", Color.fromRGBO(178,212,245,1));

  emotions.add(statesModel);
  statesModel = new SubEmotions();

  //5
  statesModel.setData("Sad", Color.fromRGBO(178,178,245,1));

  emotions.add(statesModel);
  statesModel = new SubEmotions();

  //6
  statesModel.setData("Disgust", Color.fromRGBO(228,178,245,1));

  emotions.add(statesModel);
  statesModel = new SubEmotions();

  //7
  statesModel.setData("Anger", Color.fromRGBO(245,178,178,1));

  emotions.add(statesModel);
  statesModel = new SubEmotions();

  //8
  statesModel.setData("Anticipation", Color.fromRGBO(255,222,180,1));

  emotions.add(statesModel);
  statesModel = new SubEmotions();

  return emotions;
}