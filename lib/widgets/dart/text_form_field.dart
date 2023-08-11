import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Text_Form_Field extends StatefulWidget {
  const Text_Form_Field({Key? key}) : super(key: key);

  @override
  State<Text_Form_Field> createState() => _Text_Form_FieldState();
}

class _Text_Form_FieldState extends State<Text_Form_Field> {
 final formkey = GlobalKey<FormState>();
 final _password = TextEditingController();
 final confirmation = TextEditingController();
 final _email = TextEditingController();

 Future _login () async {
   await FirebaseAuth.instance.signInWithEmailAndPassword
     (email: _email.text.trim(),
        password: _password.text.trim());
 }

 @override
 void dispose(){
   _password.dispose();
   _email.dispose();
   confirmation.dispose();
   super.dispose();
 }
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Column(
        children: [
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
              icon: const Icon(Icons.password),
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
                icon: const Icon(Icons.lock),
                labelText: 'Confirm password',
                hintText: 'Confirm password'
            ),
            validator: (value){
              if(value!.isEmpty){
                return 'Please enter valid password';
              }
             if(_password.text != confirmation.text){
               return 'password does not match';
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
                icon: const Icon(Icons.email),
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
      )
    );
  }
}
