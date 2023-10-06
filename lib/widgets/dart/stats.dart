import 'package:flutter/material.dart';
import 'package:quotesapp/widgets/dart/timer.dart';

class Session {
  final DateTime startTime;
  final Duration sessionLength;

  Session({
    required this.startTime,
    required this.sessionLength,
  });
}

class StatsScreen extends StatefulWidget {
  @override
  _StatsScreenState createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  final List<Session> sessions = [];

  // Define a function to add a session to the list
  void addSession(TimerModel dependencies) {
    setState(() {
      // Calculate the session length
      final sessionLength = dependencies.elapsedTime;

      // Create a new Session object
      final session = Session(
        startTime: DateTime.now(),
        sessionLength: sessionLength,
      );

      // Add the session to the list
      sessions.add(session);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Stats'),
        centerTitle: true,
        backgroundColor: Colors.deepPurple.shade200,
      ),
      body: ListView.builder(
        itemCount: sessions.length,
        itemBuilder: (context, index) {
          final session = sessions[index];
          final formattedTime =
              "${session.sessionLength.inMinutes.toString().padLeft(2, '0')}:${(session.sessionLength.inSeconds % 60).toString().padLeft(2, '0')}";

          return ListTile(
            title: Text("Session ${index + 1}"),
            subtitle: Text(formattedTime),
          );
        },
      ),
      floatingActionButton: ElevatedButton(
        onPressed: () {
          // Call the addSession() function when the user stops a session
          // addSession();
        },
        child: Text('Stop Session'),
      ),
    );
  }
}
