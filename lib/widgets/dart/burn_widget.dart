import 'package:flutter/material.dart';

class BurningEffect extends StatefulWidget {
  final String text;

  const BurningEffect({Key? key, required this.text}) : super(key: key);

  @override
  _BurningEffectState createState() => _BurningEffectState();
}

class _BurningEffectState extends State<BurningEffect> {
  double opacity = 1.0;
  double scale = 1.0;

  @override
  void initState() {
    super.initState();
    _startBurningAnimation();
  }

  void _startBurningAnimation() async {
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
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image:  DecorationImage(
          image:  AssetImage("assets/fire.gif"),
      fit: BoxFit.fill,
        ),
        ),
        child: Center(
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            transform: Matrix4.identity()..scale(scale),
            child: Opacity(
              opacity: opacity,
              child: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 30,
                  color: Colors.orange.shade800,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
