import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import '../util/error_dialogue.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: const Color(0xFFFFCACC),
      ),
      body: Column(
        children: [
          Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset("assets/logo.png",
                                    width: 200.0, height: 200.0),
              ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _email,
              enableSuggestions: false,
              autocorrect: false,
              decoration: const InputDecoration(
                hintText: 'Enter your email here',
                /*enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      width: 3, color: const Color(0xFFFFCACC)), 
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 3, color: Color(0xFFDBC4F0)),
                ),*/
              ),
              keyboardType: TextInputType.emailAddress,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              controller: _password,
              obscureText: true,
              enableSuggestions: false,
              autocorrect: false,
              decoration:
                  const InputDecoration(hintText: 'Enter your password here'),
            ),
          ),
          TextButton(
            onPressed: () async {
              final email = _email.text;
              final password = _password.text;

              try {
                await FirebaseAuth.instance.signInWithEmailAndPassword(
                  email: email,
                  password: password,
                );
                final user = FirebaseAuth.instance.currentUser;
                if (user?.emailVerified ?? false) {
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/home/',
                      (_) => false,
                    );
                  }
                } else {
                  if (context.mounted) {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/verify/',
                      (_) => false,
                    );
                  }
                }
              } on FirebaseAuthException catch (e) {
                if (e.code == 'user-not-found') {
                  await showErrorDialogue(context, 'User not found!');
                } else if (e.code == 'wrong-password') {
                  await showErrorDialogue(context, 'Incorrect credentials');
                } else {
                  await showErrorDialogue(context, 'Error: ${e.code}');
                }
              } catch (e) {
                await showErrorDialogue(context, e.toString());
              }
            },
            child: const Text('Login'),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/register/', (route) => false);
              },
              child: const Text('Not registered yet? Register here!')),
              
        ],
      ),
    );
  }
}
