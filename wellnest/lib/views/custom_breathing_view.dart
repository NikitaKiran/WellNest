import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomBreathingView extends StatefulWidget {
  const CustomBreathingView({super.key, required this.timings});
  final List timings;
  @override
  State<CustomBreathingView> createState() => _CustomBreathingViewState();
}

class _CustomBreathingViewState extends State<CustomBreathingView>
    with TickerProviderStateMixin {
  late List timing;
  late AnimationController _breathingController;
  var _breathe = 0.0;
  var _displaytext = "Breathe In";
  bool isPlaying = false;
  final player = AudioPlayer();
  late Timer t;
  @override
  void initState() {
    super.initState();
    timing = widget.timings;
    player.setSource(AssetSource('music.mp3'));
    _breathingController = AnimationController(
        vsync: this,
        duration: Duration(seconds: timing[0]),
        reverseDuration: Duration(seconds: timing[2]));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isPlaying) {
        _displaytext = "Hold";
        t = Timer(Duration(seconds: timing[1]), () {
          if (isPlaying) {
            _breathingController.reverse(from: 1);
            _displaytext = "Breathe Out";
          }
        });
      } else if (status == AnimationStatus.dismissed && isPlaying) {
        _displaytext = "Hold";
        t = Timer(Duration(seconds: timing[3]), () {
          if (isPlaying) {
            _breathingController.forward(from: 0);
            _displaytext = "Breathe In";
          }
        });
      }
    });

    _breathingController.addListener(() {
      setState(() {
        _breathe = _breathingController.value;
      });
    });
  }

  @override
  void dispose() {
    if (!_breathingController.isAnimating && isPlaying){
      t.cancel();
    }
    player.dispose();
    _breathingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = 200.0 + 100.0 * _breathe;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Custom Breathwork'),
          backgroundColor: const Color(0xFFFFCACC),
        ),
        backgroundColor: const Color.fromARGB(255, 236, 239, 236),
        body: Column(
          children: [
            SizedBox(
              height: 400,
              width: 400,
              child: Center(
                child: SizedBox(
                  height: size,
                  width: size,
                  child: CircleAvatar(
                      backgroundColor: const Color(0xFFFFCACC),
                      child: Text(
                        _displaytext,
                        style: const TextStyle(fontSize: 20),
                      )),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (_breathingController.isAnimating) {
                        setState(() {
                          isPlaying = false;
                          _displaytext = "Breathe In";
                        });
                        _breathingController.reset();
                        player.pause();
                      } else {
                        if (!isPlaying) {
                          player.resume();
                          _breathingController.forward(from: 0);
                          setState(() {
                            isPlaying = true;
                          });
                        } else {
                          setState(() {
                            isPlaying = false;
                            _displaytext = "Breathe In";
                          });
                          t.cancel();
                          _breathingController.reset();
                          player.pause();
                        }
                      }
                    },
                    child: RoundButton(
                      icon: isPlaying == true ? Icons.stop : Icons.play_arrow,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class RoundButton extends StatelessWidget {
  const RoundButton({
    Key? key,
    required this.icon,
  }) : super(key: key);
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 5,
      ),
      child: CircleAvatar(
        backgroundColor: const Color(0xFFFFCACC),
        radius: 30,
        child: Icon(
          icon,
          size: 36,
          color: const Color.fromRGBO(250, 243, 240, 1),
        ),
      ),
    );
  }
}

class SelectCustomization extends StatefulWidget {
  const SelectCustomization({super.key});

  @override
  State<SelectCustomization> createState() => _SelectCustomizationState();
}

class _SelectCustomizationState extends State<SelectCustomization> {
  var _val1 = 1.0;
  var _val2 = 0.0;
  var _val3 = 1.0;
  var _val4 = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Custom Breathwork'),
          backgroundColor: const Color(0xFFFFCACC),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column( crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Breathe In Time(in seconds)'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                    CupertinoSlider(
                      value: _val1,
                      min: 1.0,
                      divisions: 10,
                      max: 10,
                      activeColor: Color.fromRGBO(221, 187, 204, 1),
                      thumbColor: Color.fromRGBO(221, 187, 204, 1),
                      onChanged: (double value) {
                        setState(() {
                          _val1 = value;
                        });
                      },
                    ),
                    Text('${_val1.round()}'),
                  ],
                ),
              ),
              Text('Hold Time(in seconds)'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                    CupertinoSlider(
                      value: _val2,
                      min :0,
                      divisions: 10,
                      max: 10,
                      activeColor: Color.fromRGBO(221, 187, 204, 1),
                      thumbColor: Color.fromRGBO(221, 187, 204, 1),
                      onChanged: (double value) {
                        setState(() {
                          _val2 = value;
                        });
                      },
                    ),
                    Text('${_val2.round()}'),
                  ],
                ),
              ),
              Text('Breathe Out Time(in seconds)'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                    CupertinoSlider(
                      value: _val3,
                      min: 1.0,
                      divisions: 10,
                      max: 10,
                      activeColor: Color.fromRGBO(221, 187, 204, 1),
                      thumbColor: Color.fromRGBO(221, 187, 204, 1),
                      onChanged: (double value) {
                        setState(() {
                          _val3 = value;
                        });
                      },
                    ),
                    Text('${_val3.round()}'),
                  ],
                ),
              ),
              Text('Hold Time(in seconds)'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row( mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    
                    CupertinoSlider(
                      value: _val4,
                      divisions: 10,
                      max: 10,
                      activeColor: Color.fromRGBO(221, 187, 204, 1),
                      thumbColor: Color.fromRGBO(221, 187, 204, 1),
                      onChanged: (double value) {
                        setState(() {
                          _val4 = value;
                        });
                      },
                    ),
                    Text('${_val4.round()}'),
                  ],
                ),
                
              ),
              ElevatedButton(onPressed: () {
                Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder: (context) => CustomBreathingView(timings: [_val1.toInt(),_val2.toInt(),_val3.toInt(),_val4.toInt()])));
                },child:const Text('Confirm')),
            ],
          ),
        ));
  }
}
