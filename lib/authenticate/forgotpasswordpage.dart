import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {

  final _email = TextEditingController();

  Future   Passwordreset() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: _email.text.trim());
      showDialog(context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                  'Password reset link sent successfully please check your email!'),
            );
          });
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }
  @override
  void dispose() {
    _email.dispose();
    super.dispose();
  }


    @override
    Widget build(BuildContext context) {
      return  Scaffold(
        appBar: AppBar(
         flexibleSpace: Image(
           image: AssetImage('assets/chat_image.jpg',
         ),
      fit: BoxFit.cover,
        ),
          toolbarHeight: 200.0,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter your email and we will send you a password reset link',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            TextFormField(
              controller: _email,
              decoration: InputDecoration(
                  enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400,
                      )
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
            SizedBox(height: 20,),
            ElevatedButton(onPressed: () {
              Passwordreset();
            },
                style: ButtonStyle(
                    alignment: Alignment.centerRight,
                    padding: MaterialStateProperty.all(EdgeInsets.symmetric(
                        horizontal: 100,vertical: 20
                    ),),
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurple.shade300),
                    shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        )
                    )
                ),
                child: const Text('Reset password',
                  style: TextStyle(fontSize: 20,color: Colors.black),)
            ),
          ],
        ),
      );
    }
  }



