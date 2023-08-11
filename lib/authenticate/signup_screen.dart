import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../widgets/dart/text_form_field.dart';

class Signup_page extends StatefulWidget {
  final VoidCallback showLoginPage;
  const Signup_page({Key? key, required this.showLoginPage}) : super(key: key);

  @override
  State<Signup_page> createState() => _Signup_pageState();
}

class _Signup_pageState extends State<Signup_page> {

  final formkey = GlobalKey<FormState>();
  final _password = TextEditingController();
  final confirmation = TextEditingController();
  final _email = TextEditingController();
  final _username = TextEditingController();
  final _country = TextEditingController();
  final _age = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose(){
    _password.dispose();
    _email.dispose();
    confirmation.dispose();
    _username.dispose();
    _country.dispose();
    _age.dispose();
    super.dispose();
  }

  Future SignUp () async {
    if(formkey.currentState!.validate()){
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _email.text.trim(),
          password: _password.text.trim());
   await addUserDetails(
        _username.text.trim(),
        int.parse(_age.text.trim()),
        _email.text.trim(),
        _country.text.trim());
  }
    showDialog(context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(
                'Please supply valid inputs'),
          );
        });
  }



  Future addUserDetails(
  String Username  , int age, String Country, String Email 
      ) async {
    await FirebaseFirestore.instance.collection('usercl').add({
      'Username': Username,
      'age': age,
      'Country': Country,
      'Email': Email,
    }
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  height: 150,
                  width: double.infinity,
                  child: Image.asset('assets/chat_image.jpg',
                    fit: BoxFit.cover,
                  )
              ),
              const Text('Welcome back !!',
                style: TextStyle(fontSize: 25),),
          Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextFormField(
                      controller: _username,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400)
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          labelText: 'Enter username',
                          hintText: 'Enter username'
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter valid username';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _age,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400)
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          labelText: 'Enter age',
                          hintText: 'Enter age'
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter valid age';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _country,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400)
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          labelText: 'Enter country',
                          hintText: 'Enter country'
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter valid country';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _password,
                      obscureText: true,
                      decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey.shade400)
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          labelText: 'Enter password',
                          hintText: 'enter password'
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter valid password';
                        }
                        return null;
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
                              borderSide: BorderSide(color: Colors.grey.shade400)
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          labelText: 'Confirm password',
                          hintText: 'Confirm password'
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter valid password';
                        }
                        if(_password.text.trim() != confirmation.text.trim()){
                          return 'enter valid password';
                        }
                        return  null;
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
                              borderSide: BorderSide(color: Colors.grey.shade400)
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          labelText: 'Enter email',
                          hintText: 'Enter email'
                      ),
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter valid email';
                        }
                        return null;
                      },
                    ),


                  ],
                ),
              )
          ),
            GestureDetector(
              onTap: SignUp,
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
                    :  Text(
                  "Sign Up",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment:MainAxisAlignment.center ,
                  children: [
                    Text('Already registered?'),
                    SizedBox(width: 3,),
                    GestureDetector(
                      onTap: widget.showLoginPage,
                      child: Text('Login here',
                        style: TextStyle(color: Colors.deepPurple.shade300),),
                    )
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
