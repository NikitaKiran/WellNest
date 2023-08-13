import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


class BoxBreathingView extends StatefulWidget {
  const BoxBreathingView({super.key});

  @override
  State<BoxBreathingView> createState() => _BoxBreathingViewState();
}

class _BoxBreathingViewState extends State<BoxBreathingView>
    with TickerProviderStateMixin {
  late AnimationController _breathingController;
  var _breathe = 0.0;
  var _displaytext = "Breathe In";
  bool isPlaying = false;
  final player = AudioPlayer();
  late Timer t;
  @override
  void initState() {
    super.initState();
    player.setSource(AssetSource('music.mp3'));
    _breathingController =
        AnimationController(vsync: this, duration: const Duration(seconds: 5));
    _breathingController.addStatusListener((status) {
      if (status == AnimationStatus.completed && isPlaying) {
        _displaytext = "Hold";
        t = Timer(const Duration(seconds: 5), () {
          if (isPlaying) {
             _breathingController.reverse(from: 1);
             _displaytext = "Breathe Out";
          }});
       
      } else if (status == AnimationStatus.dismissed && isPlaying) {
        _displaytext = "Hold";
        t = Timer(const Duration(seconds: 5), () {
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
          title: const Text('Box Breathing'),
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
                      child: Text(_displaytext,style: const TextStyle(fontSize: 20),)),
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
                      if (_breathingController.isAnimating){
                        setState(() {
                          isPlaying = false;
                          _displaytext = "Breathe In";
                        });
                        _breathingController.reset();
                        player.pause();
                        
                      }
                      else{
                        if (!isPlaying){
                          player.resume();
                          _breathingController.forward(from: 0);
                          setState(() {
                            isPlaying = true;
                          });
                        } else{
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
