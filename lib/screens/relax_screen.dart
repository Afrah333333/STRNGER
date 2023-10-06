import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quotesapp/screens/breathingscreen.dart';
import 'package:quotesapp/screens/calm_sound_screen.dart';
import 'package:quotesapp/screens/player_screen.dart';
import 'package:quotesapp/models/dart/song.dart';
import 'package:quotesapp/widgets/dart/category_card.dart';



class RelaxPage extends StatefulWidget {
  const RelaxPage({Key? key}) : super(key: key);

  @override
  State<RelaxPage> createState() => _RelaxPageState();
}

class _RelaxPageState extends State<RelaxPage> {

  @override

  Widget build(BuildContext context) {
    var size = MediaQuery.of(context)
        .size; //this gonna give us total height and with of our device
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            // Here the height of the container is 45% of our total height
            height: size.height * .45,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade300,
              image: DecorationImage(
                alignment: Alignment.centerLeft,
                image: AssetImage("assets/undraw_pilates_gpdb.png"),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: Colors.deepPurple.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: SvgPicture.asset("assets/menu.svg",
                      ),
                    ),
                  ),
                  Text(
                    "Good Morning \nAfrah",
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium
                        ?.copyWith(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(height: 220,),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: .85,
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 20,
                      children: <Widget>[
                        CategoryCard(
                          title: "Meditation",
                          svgSrc: "assets/Meditation.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return BreatheScreen();
                              }),
                            );
                          },
                        ),

                        CategoryCard(
                          title: "Music",
                          svgSrc: "assets/yoga.svg",
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                return SoundPage();
                              }),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
