import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quotesapp/authenticate/signup_screen.dart';
import 'package:quotesapp/widgets/dart/loading.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/onboardingscreen.dart';
import '../services/auth_services.dart';
import '../widgets/dart/text_form_field.dart';
import 'forgotpasswordpage.dart';



class LoginScreen extends StatefulWidget {
final VoidCallback showSignUpPage;
  const LoginScreen({Key? key, required this.showSignUpPage}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final AuthService _auth = AuthService();
  final formkey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final confirmation = TextEditingController();
  final _email = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _password.dispose();
    _email.dispose();
    confirmation.dispose();
    super.dispose();
  }

  Future _login() async {
    if (formkey.currentState!.validate()) {
      setState(() => _isLoading = true);
      dynamic result = await FirebaseAuth.instance.signInWithEmailAndPassword(

         password: _password.text.trim(), email:_email.text.trim() );
      if (result == null) {
        setState(() {
          _isLoading = false;
          // error = 'Could not sign in with those credentials';
        });
      }
    }
  }


    @override
    Widget build(BuildContext context) {
      return _isLoading ? Loading() : Scaffold(

          body: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 150,
                    width: double.infinity,
                    child: Image.asset('assets/chat_image.jpg',
                      fit: BoxFit.cover,
                    )
                ),
                SizedBox(height: 20,),
                const Text('Welcome!!!',
                  style: TextStyle(fontSize: 25),),
                SizedBox(height: 20,),
                Form(
                    key: formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _password,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white,
                                  )
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400)
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              labelText: 'Enter password',
                              hintText: 'enter password'
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid password';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => _password.text = value);
                          },
                        ),
                        const SizedBox(height: 3,),
                        TextFormField(
                          controller: confirmation,
                          obscureText: true,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400)
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              labelText: 'Confirm password',
                              hintText: 'Confirm password'
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid password';
                            }
                            if (_password.text.trim() !=
                                confirmation.text.trim()) {
                              return 'Enter valid email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => confirmation.text = value);
                          },
                        ),
                        const SizedBox(height: 5,),
                        TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)
                              ),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade400)
                              ),
                              fillColor: Colors.grey.shade200,
                              filled: true,
                              labelText: 'Enter email',
                              hintText: 'Enter email'
                          ),
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter valid email';
                            }
                            return null;
                          },
                          onChanged: (value) {
                            setState(() => _email.text = value);
                          },
                        ),


                      ],
                    )
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 250),
                  child: TextButton(onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) =>
                        ForgotPasswordPage()));
                  },
                      child: Text('forgot password?',
                        style: TextStyle(color: Colors.deepPurple.shade300),)),
                ),
                GestureDetector(
                  onTap: _login,
                  child: Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.only(top: 10.0),
                    width: 220.0,
                    height: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.0),
                      color: Colors.deepPurple.shade300,
                    ),
                    child: _isLoading
                        ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                        : Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                const Text('or continue with'),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: ElevatedButton(onPressed: () {

                  },
                    style: ButtonStyle(
                        alignment: Alignment.centerRight,
                        padding: MaterialStateProperty.all(
                          EdgeInsets.all(10.0),),
                        backgroundColor: MaterialStateProperty.all(
                            Colors.white),
                        shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            )
                        )
                    ),
                    child: Image.asset('assets/google.png',
                      height: 60,
                      width: 60,),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Not yet registered?'),
                    SizedBox(width: 3,),
                    GestureDetector(
                      onTap: widget.showSignUpPage,
                      child: Text('Register here',
                        style: TextStyle(color: Colors.deepPurple.shade300),),
                    )
                  ],
                )
              ],
            ),
          )
      );
    }
  }
