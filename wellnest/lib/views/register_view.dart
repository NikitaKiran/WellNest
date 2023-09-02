import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';

import '../widgets/error_dialogue.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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
        title: const Text('Register'),
        backgroundColor: const Color(0xFFD4E2D4),
      ),
      body: SingleChildScrollView(
        child: Column(
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
                decoration:
                    const InputDecoration(hintText: 'Enter your email here'),
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
                final pass = _password.text;
      
                try {
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                      email: email, password: pass);
                  if (context.mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/setup/', (_) => false);
                  }
                } on FirebaseAuthException catch (e) {
                  if (e.code == 'weak-password') {
                    await showErrorDialogue(context, 'Weak Password!');
                  } else if (e.code == 'email-already-in-use') {
                    await showErrorDialogue(context, 'Email is already in use!');
                  } else if (e.code == 'invalid-email') {
                    await showErrorDialogue(context, 'Invalid Email');
                  } else {
                    await showErrorDialogue(context, 'Error: ${e.code}');
                  }
                } catch (e) {
                  await showErrorDialogue(context, e.toString());
                }
              },
              child: const Text('Register'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil('/login/', (route) => false);
                },
                child: const Text('Already registered? Login here!'))
          ],
        ),
      ),
    );
  }
}
