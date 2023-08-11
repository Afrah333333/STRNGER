import 'package:flutter/material.dart';
import 'package:quotesapp/authenticate/login_screen.dart';
import 'package:quotesapp/authenticate/signup_screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
   bool showLoginPage = true;

 void ToggleScreen() {
 setState(() {
   showLoginPage =! showLoginPage;
 });
 }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginScreen(showSignUpPage: ToggleScreen,);
    }
    return Signup_page(showLoginPage: ToggleScreen,);
  }
}
