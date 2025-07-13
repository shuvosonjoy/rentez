
// ignore_for_file: non_constant_identifier_names

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rent_ez/app.dart';
import 'package:rent_ez/ui/ui.screens/home_screen.dart';
import 'package:rent_ez/ui/ui.screens/login_screen.dart';
import 'package:rent_ez/ui/ui.screens/sign_up_screen.dart';
import 'package:rent_ez/ui/ui.screens/splash_screen.dart';



void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

  );

  runApp(const RentEzApp());

}

class MyApp extends StatelessWidget{

  const MyApp({Key? Key}) : super(key: Key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const SplashScreen(

          child: LoginScreen(),
        ),
        '/login': (context) => const LoginScreen(),
        '/signUp': (context) => const SignUpScreen(),
        '/home': (context) => const HomeScreen(),
      },


    );

  }
}






