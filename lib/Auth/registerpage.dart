import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scheduler/status/status.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/Auth/loginpage.dart';


class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  TextEditingController email=TextEditingController();
  TextEditingController password=TextEditingController();
    Future<void> register()async{
            if (email.text.isEmpty || password.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Email and password cannot be empty")),
        );
        return;
      }
      if (password.text.length < 6) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Password must be at least 6 characters")),
        );
        return;
      }

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
      appBar: AppBar(
        backgroundColor: Color(0xFFECECEC),
        title: Text(
          'Welcome new user!',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),),
      ),
      body:  
      Column(
        children: [
          Text(
              'Please register your Email and Password',
              style: GoogleFonts.inter(
                fontSize: 16,                
                fontWeight: FontWeight.w500
            ),),
          SizedBox(height: 50,),          
          Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.topCenter,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20,right: 20),
              child: Container(
                width: 350,
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(20),
                ),
                padding: EdgeInsets.only(top: 50,left:30,right: 30 ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffE6DCD0),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        controller: email,
                        cursorColor: const Color.fromARGB(255, 90, 90, 90),
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          fontWeight: FontWeight.w500
                        ),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: GoogleFonts.inter(
                              color: Colors.white,
                            )),
                        ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Color(0xffE6DCD0),
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: TextField(
                        controller: password,
                        cursorColor: const Color.fromARGB(255, 109, 109, 109),
                        style: GoogleFonts.inter(
                          color: const Color.fromARGB(255, 90, 90, 90),
                          fontWeight: FontWeight.w500
                        ),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintStyle: GoogleFonts.inter(
                              color: const Color.fromARGB(255, 255, 255, 255),
                            )),
                        ),
                    ),
                const SizedBox(height: 10),
                Center(
                  child: TextButton(
                    onPressed: register,
                    child: Container(
                      height: 40,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Color(0xffE6DCD0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Register",
                          style: GoogleFonts.roboto(
                            color: const Color.fromARGB(255, 90, 90, 90),
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                  ],
                ),
              ),
            ),
            Positioned(
              top:-40 ,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage("asset/img/cropped_circle_image.png"),
              )
              )
          ],
          ),
          Row(
              children: [
                SizedBox(width: 50,),
                Text("Already have an account?",
                style: TextStyle(
                  fontSize: 16
                ),),
                TextButton(onPressed: (){
            Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Loginpage()),
          );
        }, 
        child: Text(
           "Log in",
            style: TextStyle(
              color: const Color.fromARGB(255, 47, 71, 255),
              fontSize: 16
            ),),),
              ],
            )
        ],
      ),
    );
  }
}