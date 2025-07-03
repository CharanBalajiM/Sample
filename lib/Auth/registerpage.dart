import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/status/status.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
    Future<void> register()async{
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context)=> StatusPage()));
      }
      on FirebaseAuthException catch (e){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration failed: ${e.message}')),
        );
      }
    }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 50,left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Please Enter email and password to register'),
            TextField(
              controller: email,
              decoration: InputDecoration(
                hintText: "Enter Email"
              ),
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                hintText: "Enter Password"
              ),
            ),
            Center(
              child: ElevatedButton(onPressed: (()=>register()),
              child: Text("REGISTER")),
            ),
            
          ],
        ),
      ),
    );
  }
}