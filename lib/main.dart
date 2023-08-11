import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quotesapp/firebase_options.dart';
import 'package:quotesapp/screens/splashscreen.dart';
import 'package:quotesapp/services/auth_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_core/firebase_core.dart';
import 'models/dart/user.dart';
import 'package:provider/provider.dart';
import 'package:quotesapp/models/dart/theme_model.dart';
import 'package:quotesapp/models/dart/DateTimeModel.dart';
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform
   );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MultiProvider(
      providers: [
         ChangeNotifierProvider(
          create: (_) => ThemeModel(),
        ),
        ChangeNotifierProvider(
          create: (_) => DateTimeModel()
        ),
      ],
      child: Consumer<ThemeModel>(
        builder: (context, ThemeModel themeNotifier, child) {
         return MaterialApp(
            title: 'Flutter Demo',
            theme: themeNotifier.isDark ? ThemeData.dark() : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: Splashscreen(),
          );
        }
      ),
    );
  }
}

