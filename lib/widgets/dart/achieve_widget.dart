import 'package:flutter/material.dart';

class WinEffect extends StatefulWidget {


  const WinEffect({Key? key, }) : super(key: key);

  @override
  _WinEffectState createState() => _WinEffectState();
}

class _WinEffectState extends State<WinEffect> {
  double opacity = 1.0;
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    _startWinAnimation();
  }

  void _startWinAnimation() async {
    // Simulate the burning animation
    await Future.delayed(Duration(seconds: 5));

    setState(() {
      opacity = 0.0;
      scale = 2.0;
    });

    // Navigate back to the home screen
    await Future.delayed(Duration(seconds: 1));

    Navigator.of(context).pop(); // Close the burning screen
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 300,
          width: 300,
          decoration: BoxDecoration(
            image:  DecorationImage(
              image:  AssetImage("assets/congratulations-confetti.gif"),
              fit: BoxFit.fill,
            ),
          ),
          child: Center(
            child: AnimatedContainer(
              duration: Duration(seconds: 2),
              transform: Matrix4.identity()..scale(scale),
              child: Opacity(
                opacity: opacity,

              ),
            ),
          ),
        ),
      ),
    );
  }
}
