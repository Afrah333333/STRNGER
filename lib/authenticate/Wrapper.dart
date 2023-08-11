import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quotesapp/authenticate/login_screen.dart';
import 'package:quotesapp/authenticate/signup_screen.dart';
import 'package:quotesapp/screens/home_screen.dart';
import '../models/dart/user.dart';
import 'Auth_page.dart';

import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    final user = Provider.of<Person>(context);

    // return either the Home or Authenticate widget
    if (user == null){
      return AuthPage();
    } else {
      return HomePage();
    }

  }
}
