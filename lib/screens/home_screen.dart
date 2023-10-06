import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:quotesapp/constants/dart/onBoard_pages.dart';
import 'package:quotesapp/models/dart/theme_model.dart';
import 'package:quotesapp/screens/achievements.dart';
import 'package:quotesapp/screens/chat_screen.dart';
import 'package:quotesapp/screens/image.dart';
import 'package:quotesapp/screens/relax_screen.dart';
import 'package:quotesapp/screens/secrets.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/dart/DateTimeModel.dart';
import '../services/database.dart';
import '../widgets/dart/burn_widget.dart';
import '../widgets/dart/dialog_box.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // final user = FirebaseAuth.instance.currentUser!;
  final TextEditingController secretController = TextEditingController();
  final List<String> secrets = [];




  @override
  void initState() {
    super.initState();
  }








  @override
  Widget build(BuildContext context) {
    return Consumer2<ThemeModel,DateTimeModel>(
        builder: (context, ThemeModel themeNotifier, dateTimeModel,child) {
          return Scaffold(
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, left: 10),
                    child: Row(
                      children: [
                        Row(
                          children: [
                            Text('Welcome ',
                              style: TextStyle(
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 25),),
                            const Text(' Afrah',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 25),),
                          ],
                        ),

                        const SizedBox(width: 130),
                        ElevatedButton(
                          onPressed: () {
                            themeNotifier.isDark
                                ? themeNotifier.isDark = false
                                : themeNotifier.isDark = true;
                            print("Theme change clicked");
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(Colors
                                  .deepPurple.shade200),
                              foregroundColor: MaterialStateProperty.all(Colors
                                  .white),
                              shadowColor: MaterialStateProperty.all(Colors
                                  .transparent),
                              shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(

                                      borderRadius: BorderRadius.circular(60.0)
                                  ))

                          ),
                          child: Icon(themeNotifier.isDark
                                  ? Icons.nightlight_round
                                  : Icons.wb_sunny),
                              ),
                      ],
                    ),

                  ),
                  Text(' ${dateTimeModel.currentDate}',
                    style: TextStyle(
                        color: Colors.black54, fontSize: 15),),
                  SizedBox(height: 10),
                  Container(
                    width: 380,
                    height: 200,
                    decoration: BoxDecoration(
                        image: const DecorationImage(
                            image: AssetImage('assets/chat_image.jpg'),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(16.0)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 20.0, top: 10.0, bottom: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:   [
                          Text(' ${dateTimeModel.currentTime}',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 300,
                        color: Colors.deepPurple.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            TextButton(onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SecretPage(
                                  ),
                                ),
                              );
                            },
                              child: Text(
                        'Secret',
                        style: TextStyle(
                          color: Colors.black54,
                          fontSize: 25,
                        ),
                      ),
                      ),

                            TextButton(onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => MultipleImageSelector(
                                  ),
                                ),
                              );
                            },
                              child: Text(
                                'images',
                                style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 25,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      height: 60,
                      width: 370,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => Achievementpage(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.deepPurple.shade200,

                        ),
                        child: const Text('GOALS',
                          style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

          );
        }
    );
  }
}
