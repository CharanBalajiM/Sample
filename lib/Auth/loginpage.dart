import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/Auth/registerpage.dart';
import 'package:scheduler/Status/status.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<Loginpage> {

  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
  Future<void> signIn()async{
    if (email.text.isEmpty || password.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter both email and password')),
      );
      return;
  }
    try{
    final UserCredential =await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
    Navigator.pushReplacement(
      context, 
      MaterialPageRoute(builder: (context)=>StatusPage()));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text("Login Succesful!"))));
    }
    on FirebaseAuthException catch (e){
      String message;
        print('Error code: ${e.code}');

      switch(e.code){
        case 'invalid-credential':
        message="Email or Password does'nt match";
        break;
        case 'user-disabled':
        message="This user account has been disabled";
        break;
        case 'too-many-requests':
        message="Too many attempts. Try again later";
        break;
        default:
        message="Login failed.${e.message}";
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text(message)),));
    }
    catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Center(child: Text('An error has occured. Please try again')))
      );
    }
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFECECEC),
        title: Text(
          'Welcome user!',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Please Enter your Login Credentials',
              style: GoogleFonts.inter(
                fontSize: 16,                
                fontWeight: FontWeight.w500
              ),),
            SizedBox(height: 20,),
            Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.all(5),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Center(
                          child: Container(
                            height: 100,
                            width: 100,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'asset/img/profile.jpg'))),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                                      
                          children:[
                            TextField(
                              controller: email,
                              decoration: InputDecoration(
                                hintText: "Enter Email",
                              ),
                            ),
                            TextField(
                              controller: password,
                              decoration: InputDecoration(
                                hintText: "Enter Password"
                              ),
                            ),
                            
                             ]),
                      ),
                      SizedBox(width: 10,)],),
                      Center(
                          child: TextButton(onPressed: (()=>signIn()), 
                          child: Container(
                            height: 30,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Color(0xff8BB6D6),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Center(
                              child: Text("LOGIN",
                              style: GoogleFonts.inter(
                                color: const Color.fromARGB(255, 255, 255, 255),
                                fontWeight: FontWeight.bold,
                                fontSize: 18
                                
                              ),),
                            ),
                          ),),
                          
                        ),
                ],
              ),
            ),
            Row(
              children: [
                SizedBox(width: 25,),
                Text("Don't have a account?",
                style: TextStyle(
                  fontSize: 16
                ),),
                TextButton(onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Registerpage()),
          );
        }, 
        child: Text(
           "Register here",
            style: TextStyle(
              color: const Color.fromARGB(255, 255, 61, 47),
              fontSize: 16
            ),),),
              ],
            )
          ],
        ),
      ),
    );
  }
}