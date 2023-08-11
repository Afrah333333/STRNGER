import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animate_gradient/animate_gradient.dart';
import 'package:quotesapp/authenticate/Wrapper.dart';

import 'package:shared_preferences/shared_preferences.dart';
import '../authenticate/login_screen.dart';
import 'onboardingscreen.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({Key? key}) : super(key: key);

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen>  with SingleTickerProviderStateMixin {
late bool isViewed;



  @override
  void initState()  {
    super.initState();

   _storeOnboardInfo();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    // Wait for a few seconds and then navigate to the next screen
    Timer(const Duration(seconds: 10), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => isViewed  ? onBoardingScreen():Wrapper()),
      );
    });
  }

_storeOnboardInfo() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
 isViewed =  prefs.getBool('BoardKey')??false;
  print(prefs.getBool('BoardKey'));
}

  @override


  @override
  Widget build(BuildContext context) {
  return AnimateGradient(
    primaryBegin: Alignment.topLeft,
    primaryEnd: Alignment.bottomRight,
    secondaryBegin: Alignment.bottomRight,
    secondaryEnd: Alignment.topLeft,
    primaryColors:  [
      Colors.black,
      Colors.indigo.shade700,
      Colors.deepPurple.shade300,
    ],
    secondaryColors:  [
      Colors.deepPurple.shade300,
      Colors.indigo.shade700,
      Colors.black,
    ],
    child: const Center(
      child: Text('STRANGERS',
      style: TextStyle(fontSize: 50,color: Colors.white,decoration: TextDecoration.none),),
    ),


  );
  }
}

