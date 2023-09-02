import 'package:flutter/material.dart';

class RelaxOptionsView extends StatelessWidget {
  const RelaxOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relax'),
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
                            .pushNamed('/ttt/');
                },
                
                child: const Center(child: Text("Tic Tac Toe", style: TextStyle(fontSize: 20),)),
              )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                            .pushNamed('/gol/');
                },
                
                child: const Center(child: Text("Conway's Game of Life", style: TextStyle(fontSize: 20),)),
              )),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                            .pushNamed('/478_breathing/');
                },
                
                child: const Center(child: Text("Doodle", style: TextStyle(fontSize: 20),)),
              )),
        ],
      ),
    );
  }
}
