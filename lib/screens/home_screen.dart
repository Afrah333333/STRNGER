import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quotesapp/constants/dart/onBoard_pages.dart';
import 'package:quotesapp/models/dart/theme_model.dart';
import 'package:quotesapp/screens/chat_screen.dart';
import 'package:quotesapp/screens/relax_screen.dart';

import '../models/dart/DateTimeModel.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // final user = FirebaseAuth.instance.currentUser!;


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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:   [
                           Text('37cc',
                            style: TextStyle(color: Colors.black,
                                fontSize: 18),),
                          Text(' ${dateTimeModel.currentTime}',
                            style: TextStyle(color: Colors.black, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // ListView.builder(itemBuilder: (BuildContext context, int index) {
                  //   return Container(
                  //     child: Card(
                  //       shape: RoundedRectangleBorder(
                  //           borderRadius: BorderRadius.circular(10)),
                  //       child: const Padding(
                  //         padding: EdgeInsets.all(12.0),
                  //         child: Text(
                  //           "Lorem Ipsum is simply dummy text of the printing and typesetting industry. \nLorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
                  //           style: TextStyle(fontSize: 14),
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // }),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        height: 370,
                        color: Colors.deepPurple.shade200,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Text('Text ',
                              style: TextStyle(
                                  color: Colors.black54, fontSize: 25),),
                            Text(' Image',
                              style: TextStyle(
                                  color: Colors.deepPurple.shade500,
                                  fontSize: 25),),
                          ],
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
