
import 'package:quotesapp/widgets/dart/timer.dart';
import 'package:quotesapp/widgets/dart/stats.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
// import 'package:video_player/video_player.dart';


enum SessionState {
  Initial,
  Starting,
  HoldBreathIn,
  HoldBreathOut,
  BreathingIn,
  BreathingOut,
  Ended,
  Invalid
}

//model for a breathing session
class BreatheSession {
 late int inBreaths; //how many in breaths
 late int outBreaths; //how many out breaths
 late double sessionLengthSeconds; //total length of session
}

class BreatheScreen extends StatefulWidget {
  BreatheScreen() : super();

  @override
  _BreatheScreenState createState() => _BreatheScreenState();
}

class _BreatheScreenState extends State<BreatheScreen>
    with SingleTickerProviderStateMixin {
  var selected = false;
  late AnimationController controller;

  var sessionState = SessionState.Initial;

  final TimerModel timer = new TimerModel();
  late String display;
  int countDown = 0;
  late Timer countDownTimer;
  var goUp = false;

  // late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    // Initialize the controller with your video asset
  //   _controller = VideoPlayerController.asset('assets/istockphoto.mp4')
  //     ..initialize().then((_) {
  //       setState(() {
  //         // You can start playing or manipulate the video state here
  //         _controller.play();
  //         _controller.setLooping(true);
  //       });
  //     });
   }

  @override
  void dispose() {
    // Dispose of the controller when the widget is disposed
    // _controller.dispose();
    super.dispose();
  }


start() {
    setState(() {
      goUp = !goUp;
      selected = !selected;
      timer.stopwatch.start();
      sessionState = SessionState.Starting; // Start the session
      this.beginExcerciseRoutine();
    });
  }

  stop() {
    setState(() {
      timer.stopwatch.stop();
      this.sessionState = SessionState.Ended;
      this.countDownTimer.cancel();
      this.countDown;    });
  }





  final oneSec = const Duration(seconds: 1);
  beginExcerciseRoutine() {
    this.sessionState = nextState(sessionState);
    countDown = 5;
    countDownTimer = Timer.periodic(oneSec, (timer) {
      //Decrement the countDown
      setState(() {
        countDown--;
        if (countDown < 0) {
          countDown = 5;
          sessionState = nextState(sessionState);
        }
      });
    });
  }

  SessionState nextState(SessionState state) {
    SessionState next;
    switch (state) {
      case SessionState.Initial:
        next = SessionState.Starting;
        break;
      case SessionState.Starting:
        next = SessionState.BreathingIn;
        break;
      case SessionState.BreathingIn:
        next = SessionState.HoldBreathIn;
        break;
      case SessionState.BreathingOut:
        next = SessionState.HoldBreathOut;
        break;
      case SessionState.HoldBreathIn:
        next = SessionState.BreathingOut;
        break;
      case SessionState.HoldBreathOut:
        next = SessionState.BreathingIn;
        break;
      case SessionState.Ended:
        next = SessionState.Ended;
        break;
      default:
        next = SessionState.Invalid;
        break;
    }
    return next;
  }

  //Returns the appropriate instruction string based
  //on the given state
  String instructionText(SessionState state) {
    String text;
    switch (state) {
      case SessionState.Initial:
        text = "Press Play to Begin";
        break;
      case SessionState.Starting:
        text = "Get Ready...";
        break;
      case SessionState.BreathingIn:
        text = "Breathe in Slowly";
        break;
      case SessionState.BreathingOut:
        text = "Breathe out Slowly";
        break;
      case SessionState.HoldBreathIn:
      case SessionState.HoldBreathOut:
        text = "Hold";
        break;
      case SessionState.Ended:
        text = "Great Job!";
        break;
      default:
        text = "INVALID STATE";
        break;
    }
    return text;
  }

  //returns the action button based on session state
  Widget actionButton(SessionState state) {
    if (state == SessionState.Initial) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: FloatingActionButton(
          backgroundColor: Colors.deepPurple.shade300,
          onPressed: this.start,
          child: Icon(Icons.play_arrow),
        ),
      );
    } else if (state == SessionState.Ended) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            backgroundColor: Colors.deepPurple.shade300,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                   builder: (context) =>

                  StatsScreen(

                  ),
                ),
              );

            },
            child: Icon(Icons.insert_chart),
          ),
          FloatingActionButton(
            backgroundColor: Colors.deepPurple.shade300,
            onPressed: () {
              setState(() {
                sessionState = SessionState.Initial;
                timer.stopwatch.reset();
              });
            },
            child: Icon(Icons.refresh),
          ),
        ],
      );
    } else {
      return FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade300,
        onPressed: this.stop,
        child: Icon(Icons.stop),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade200,
      body: SafeArea(
        child: Stack(
          children: [
            this._background(context), //background image/animation
            TimerText(
              dependencies: this.timer,
            ),
            this.foreground(context) //everything in the foreground
          ],
        ),
      ),
      floatingActionButton: this.actionButton(this.sessionState),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
//videoplayer
//   Widget _VideoBackground() {
//     if (_controller.value.isInitialized) {
//       return SizedBox.expand(
//         child: FittedBox(
//           fit: BoxFit.cover,
//           child: SizedBox(
//             width: _controller.value.size!.width, // No need for null check here
//             height: _controller.value.size!.height, // No need for null check here
//             child: VideoPlayer(_controller),
//           ),
//         ),
//       );
//     } else {
//       return Container(); // Return an empty container or loading indicator
//     }
//   }
//


  var person = AssetImage('assets/guy_meditate.png');
  //draw background
  Widget _background(BuildContext context) {
    return Stack(
      children: [
        Align(alignment: Alignment.center, child: this._mountainLayer(context)),
        Align(
          alignment: Alignment.center,
          //Avatar over the Mountains
          child: AnimatedContainer(
            duration: Duration(seconds: 2),
            onEnd: () => setState(() {
              goUp = !goUp;
            }),
            padding: EdgeInsets.only(
              top: goUp ? 0 : 20,
              bottom: goUp ? 100 : 50,
            ),
            child: TextButton(
              onPressed: () {
                setState(() {
                  goUp = !goUp;
                });
              },
              child: Image(
                image: person,
                height: 150,
              ),
            ),
          ),
        ),
      ],
    );
  }

  //draw mountain view layer
  Widget _mountainLayer(BuildContext context) {
    return SizedBox.expand(
      child: Image.asset('assets/nature.jpg'),
    );
  }

  circle() {
    CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
  }

  double getDiameter(SessionState state) {
    double diameter;
    switch (state) {
      case SessionState.Initial:
        diameter = 30;
        break;
      case SessionState.Starting:
        diameter = 30;
        break;
      case SessionState.BreathingIn:
        diameter = 100;
        break;
      case SessionState.BreathingOut:
        diameter = 30;
        break;
      case SessionState.HoldBreathIn:
        diameter = 100;
        break;
      case SessionState.HoldBreathOut:
        diameter = 30;
        break;
      case SessionState.Ended:
        diameter = 100;
        break;
      default:
        diameter = 5;
        break;
    }
    return diameter;
  }

  Widget foreground(BuildContext context) {

      display = 'Get ready';

    return Container(
      alignment: Alignment.bottomCenter,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0, bottom: 100.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      person = AssetImage('assets/meditation_bg.png');
                    });
                  },
                  child: Image(
                    image: AssetImage('assets/meditation_bg.png'),
                    height: 50,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60.0, bottom: 85.0),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      person = AssetImage('assets/guy_meditate.png');
                    });
                  },
                  child: Image(
                    image: AssetImage('assets/guy_meditate.png'),
                    height: 50,
                  ),
                ),
              ),
            ],
          ),

          Padding(
            padding: EdgeInsets.only(top: 225),
            child: AnimatedContainer(
              duration: Duration(seconds: 5),
              color: Colors.deepPurple.shade200,
              width: 500,
              height: 175,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Text(
                      instructionText(sessionState),
                      style: TextStyle(fontSize: 28),
                    ),
                  ),
                  Expanded(
                      child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AnimatedContainer(
                              duration: Duration(seconds: 5),
                              width: getDiameter(sessionState),
                              height: getDiameter(sessionState),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.deepPurple.shade200,
                              ),
                              child: countDown != null
                                  ? Text(
                                '$countDown',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 28),
                              )
                                  : Text(''),
                              alignment: Alignment.center,
                            ),
                          ])),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}