import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(212, 226, 212, 1),
        elevation: 2.0,
        actions: [
          IconButton(
              onPressed: () async {
                final shouldLogout = await showLogoutDialogue(context);
                if (shouldLogout) {
                  if (context.mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (_) => false);
                  }
                  await FirebaseAuth.instance.signOut();
                }
              },
              icon: const Icon(Icons.logout))
        ],
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
                    width: 320.0,
                    height: 130.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(250, 243, 240, 1),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                      ),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text("How are you feeling today?",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 102, 102, 102),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromRGBO(255, 202, 204, 1.000),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/journal.png",
                                  width: 81.0, height: 80.0),
                              const SizedBox(height: 13.0),
                              const Text("Journal",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed('/timer/');
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(212, 226, 212, 1),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/meditate.png",
                                  width: 85.0, height: 85.0),
                              const SizedBox(height: 8.0),
                              const Text("Meditate",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(221, 187, 204, 1),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/relax.png",
                                  width: 80.0, height: 80.0),
                              const SizedBox(height: 8.0),
                              const Text("Relax",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 150.0,
                    height: 150.0,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromRGBO(250, 243, 240, 1),
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0)),
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Image.asset("assets/affirm.png",
                                  width: 80.0, height: 81.0),
                              const SizedBox(height: 8.0),
                              const Text("Affirm",
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 60, 60, 60),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18.0))
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          )
        ])),
      ),
      bottomNavigationBar: BottomAppBar(
        color: const Color.fromRGBO(250, 243, 240, 1),
        elevation: 2.0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: IconButton(
                  onPressed: () {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/home/', (_) => false);
                  },
                  icon: const Icon(
                    Icons.home,
                    size: 50,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.edit_note,
                    size: 50,
                  )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.person,
                    size: 50,
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

Future<bool> showLogoutDialogue(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Sign out'),
          content: const Text('Are you sure you want to log out?'),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: const Text('Log out'))
          ],
        );
      }).then((value) => value ?? false);
}
