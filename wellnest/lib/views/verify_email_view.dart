import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
        backgroundColor: const Color(0xFFD4E2D4),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Please verify your email',
                style: TextStyle(fontSize: 20),
              ),
            ),
            TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                  await FirebaseAuth.instance.signOut();
                  if (context.mounted) {
                    await showInfoDialogue(
                        context,
                        'Verification link sent to your registered mail ID. Verify your email and log in again!',
                        'Verify Email');
                  }
                  if (context.mounted) {
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (_) => false);
                  }
                },
                child: const Text('Send email verification')),
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Signing out'),
                        duration: Duration(seconds: 1),
                      ),
                    );
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil('/login/', (_) => false);
                  }
                },
                child: const Text('Login with another account'))
          ],
        ),
      ),
    );
  }
}

Future<void> showInfoDialogue(BuildContext context, String text, String head) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(head),
          content: Text(text),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK')),
          ],
        );
      });
}
