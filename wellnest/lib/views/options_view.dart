import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OptionsView extends StatelessWidget {
  const OptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meditate'),
        backgroundColor: const Color(0xFFFFCACC),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 239, 236),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical:10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                            .pushNamed('/timer/');
                },
                
                child: const Center(child: Text("Meditation Timer", style: TextStyle(fontSize: 20),)),
              )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                            .pushNamed('/breathing/');
                },
                
                child: const Center(child: Text("Guided Breathing", style: TextStyle(fontSize: 20),)),
              ))
        ],
      ),
    );
  }
}
