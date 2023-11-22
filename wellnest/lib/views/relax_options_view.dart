import 'package:flutter/material.dart';

class RelaxOptionsView extends StatelessWidget {
  const RelaxOptionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relax'),
        backgroundColor: const Color.fromRGBO(226, 220, 222, 1),
      ),
      backgroundColor: const Color.fromARGB(255, 236, 239, 236),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                            .pushNamed('/gol/');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 50),
                  elevation: 4.0
                ),
                child: const Center(child: Text("Conway's Game of Life", style: TextStyle(fontSize: 22),)),
              )),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                            .pushNamed('/doodle/');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 50),
                  elevation: 4.0
                ),
                child: const Center(child: Text("Doodle", style: TextStyle(fontSize: 22),)),
              )),
              Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40,vertical: 10),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context)
                            .pushNamed('/pattern/');
                },
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(350, 50),
                  elevation: 4.0
                ),
                child: const Center(child: Text("Pattern Viewer", style: TextStyle(fontSize: 22),)),
              )),
        ],
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
