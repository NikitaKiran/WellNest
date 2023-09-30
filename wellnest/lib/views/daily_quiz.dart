import 'package:flutter/material.dart';
import 'package:wellnest/views/sub_choice.dart';
import 'package:wellnest/widgets/tile.dart';


class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);
  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen>{
  List<BasicEmotions> emotions = [];

  String currentState = "Happy";
  Color currentColor = Color.fromRGBO(245,245,178,1);

  @override
  void initState() {
    super.initState();
    emotions = allStates();
  }
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("How Are You Feeling Today?",
        style: TextStyle(color: Color.fromARGB(255, 60, 60, 60)),
        ),
        backgroundColor: Color.fromRGBO(212, 226, 212, 1),
      ),
      body: Stack(
        children: [
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            bottom: 0,
            child: Container(
              height: 60,
              width: 200,
              child: Center(
                child: Container(
                  height: 65,
                  width: MediaQuery.of(context).size.width / 1.1,
                  decoration: BoxDecoration(
                    color: Color.fromRGBO(212, 226, 212, 1),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                ),
              ),
            ),
          ),
          ListWheelScrollView.useDelegate(
            itemExtent: 100,
            physics: FixedExtentScrollPhysics(),
            useMagnifier: true,
            magnification: 1.5,
            onSelectedItemChanged: (index) {
              setState(() {
                currentState = emotions[index].names!;
                currentColor = emotions[index].color!;
              });
            },
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: emotions.length,
              builder: (context, index) {
                return Tile(
                    emotions[index].color!,
                    emotions[index].names!);
              },
            ),
          ),
        ],
      ),
      
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.arrow_forward),
        backgroundColor: Color.fromRGBO(212, 226, 212, 1),
        foregroundColor: Color.fromARGB(255, 60, 60, 60),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> SubChoiceScreen(currentState, currentColor)));
        },
      ),
    );
  }


}

class BasicEmotions {
  String? names;
  Color? color;

  BasicEmotions({
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

List<BasicEmotions> allStates() {
  List<BasicEmotions> emotions = [];
  BasicEmotions statesModel = new BasicEmotions();

  //1
  statesModel.setData("Happy", Color.fromRGBO(245,245,178,1));
  emotions.add(statesModel);
  statesModel = new BasicEmotions();

  //2
  statesModel.setData("Trust", Color.fromRGBO(178,245,178,1));
  emotions.add(statesModel);
  statesModel = new BasicEmotions();

  //3
  statesModel.setData("Fear", Color.fromRGBO(178,245,228,1));

  emotions.add(statesModel);
  statesModel = new BasicEmotions();

  //4
  statesModel.setData("Surprise", Color.fromRGBO(178,212,245,1));

  emotions.add(statesModel);
  statesModel = new BasicEmotions();

  //5
  statesModel.setData("Sad", Color.fromRGBO(178,178,245,1));

  emotions.add(statesModel);
  statesModel = new BasicEmotions();

  //6
  statesModel.setData("Disgust", Color.fromRGBO(228,178,245,1));

  emotions.add(statesModel);
  statesModel = new BasicEmotions();

  //7
  statesModel.setData("Anger", Color.fromRGBO(245,178,178,1));

  emotions.add(statesModel);
  statesModel = new BasicEmotions();

  //8
  statesModel.setData("Anticipation", Color.fromRGBO(255,222,180,1));

  emotions.add(statesModel);
  statesModel = new BasicEmotions();

  return emotions;
}