import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellnest/views/4_7_8_breathing_view.dart';
import 'package:wellnest/views/affirm_view.dart';
import 'package:wellnest/views/box_breathing_view.dart';
import 'package:wellnest/views/custom_breathing_view.dart';
import 'package:wellnest/views/daily_quiz.dart';
import 'package:wellnest/views/doodle_view.dart';
import 'package:wellnest/views/ghq_view.dart';
import 'package:wellnest/views/gol_view.dart';
import 'package:wellnest/views/landing_view.dart';
import 'package:wellnest/views/note_view.dart';
import 'package:wellnest/views/relax_options_view.dart';
import 'package:wellnest/views/ttt_view.dart';
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
    debugShowCheckedModeBanner: false,
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
      '/daily_quiz/': (context) => const QuizScreen(),
      '/timer/': (context) => const TimerPage(),
      '/options/':(context) => const OptionsView(),
      '/box_breathing/':(context) => const BoxBreathingView(),
      '/478_breathing/':(context) => const Breathing478View(),
      '/custom_breathing/':(context) => const SelectCustomization(),
      '/landing/' :(context) => const LandingView(),
      '/notes/' :(context) => const NotesView(),
      '/relax/' : (context) => const RelaxOptionsView(),
      '/gol/' : (context) => const GameView(),
      '/ttt/' : (context) => const TTTPage(),
      '/doodle/' : (context) => const DrawingRoomScreen(),
      '/affirm/' : (context) => const AffirmPage(),
      '/ghq/' : (context) => const GHQView(),
      '/quiz/':(context) => const QuizScreen(),
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
