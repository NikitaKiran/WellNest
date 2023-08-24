import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class LandingView extends StatefulWidget {
  const LandingView({super.key});

  @override
  State<LandingView> createState() => _LandingViewState();
}

class _LandingViewState extends State<LandingView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 6), () {
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/start/',
        (_) => false,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/logo.png",
                    width: MediaQuery.of(context).size.width / 2,
                    height: MediaQuery.of(context).size.width / 2),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'WellNest',
                      textStyle: const TextStyle(
                        fontSize: 32.0,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 102, 102, 102)
                      ),
                      speed: const Duration(milliseconds: 500),
                    ),
                  ],
                  totalRepeatCount: 1,
                ),
              ),
            )
                ],
              ),
          ),
        ));
  }
}
