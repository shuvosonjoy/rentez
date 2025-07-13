import 'package:flutter/material.dart';
import 'package:rent_ez/ui/ui.screens/login_screen.dart';
import 'package:rent_ez/ui/ui.widgets/background_body.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required child});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {


  @override
  void initState() {
    super.initState();
    goToLogin();
  }

void goToLogin(){
  Future.delayed(const Duration(seconds:3)).then((value) {
Navigator.pushAndRemoveUntil(context,
    MaterialPageRoute(builder: (context) => const LoginScreen()),
    (route) => false);
  });
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:BackgroundBody(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Welcome',style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.green,
              letterSpacing: 2,
            ),),

            Center(
              child: Image.asset('assets/images/mysylhet.jpg',
                width:300,
                height:280 ,
                fit: BoxFit.cover,
              ),
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('"Easy Rent Easy Life"',style: TextStyle(
                  fontSize: 20,
                  fontWeight:FontWeight.bold,
                  color: Colors.green,
                  //height: -2,

                ),)
              ],
            )

          ],
        ),
      ),




    );
  }
}
