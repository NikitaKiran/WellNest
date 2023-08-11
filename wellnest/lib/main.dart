import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellnest/views/breathing_view.dart';
import 'package:wellnest/views/landing_view.dart';
import './views/options_view.dart';
import './views/login_view.dart';
import './views/home_view.dart';
import './views/meditation_view.dart';
import './views/register_view.dart';
import './views/setup_view.dart';
import 'firebase_options.dart';
import 'views/verify_email_view.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFFFFCACC)),
      useMaterial3: true,
    ),
    home: const LandingView(),
    routes: {
      '/start/':(context) => const HomePage(),
      '/login/': (context) => const LoginView(),
      '/register/': (context) => const RegisterView(),
      '/home/': (context) => const HomeView(),
      '/verify/': (context) => const VerifyEmailView(),
      '/setup/': (context) => const SetupView(),
      '/timer/': (context) => const TimerPage(),
      '/options/':(context) => const OptionsView(),
      '/breathing/':(context) => const BreathingView(),
      '/landing/' :(context) => const LandingView(),
    },
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user != null) {
                if (user.emailVerified) {
                  return const HomeView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }

            default:
              return const Scaffold(body: Center(child: CircularProgressIndicator(),),);
          }
        });
  }
}
