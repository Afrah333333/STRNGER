import 'package:flutter/material.dart';

import '../../screens/chat_screen.dart';
import '../../screens/home_screen.dart';
import '../../screens/relax_screen.dart';

class BottomNavBar extends StatefulWidget {
  
   BottomNavBar({Key? key}) : super(key: key);

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentindex = 0;

  final pages = [
    const HomePage(),
    const RelaxPage(),
    const ChatPage()
  ];

   void selectedtap( int index){
     setState(() {
       currentindex=index;
     });
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages.elementAt(currentindex),
      bottomNavigationBar: BottomNavigationBar(
        items:const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: ('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_video),
            label: ('Relax'),

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.phone),
            label: ('Chat'),

          ),
        ],
        type: BottomNavigationBarType.shifting,
        onTap: selectedtap,
        currentIndex: currentindex,
        selectedItemColor: Colors.deepPurple.shade500,
        unselectedItemColor: Colors.black54,
      ),
    );
  }
}
