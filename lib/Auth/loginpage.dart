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
    await FirebaseAuth.instance.signInWithEmailAndPassword(email: email.text.trim(), password: password.text.trim());
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
            SizedBox(height: 50,),

            loginboxadv(
              email:email,
              password: password,
              onLogin: (){
                signIn();
              },

            ),
            Row(
              children: [
                SizedBox(width: 25,),
                Text("Don't have an account?",
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

class loginbox extends StatelessWidget {
  const loginbox({super.key, required this.email, required this.password, required this.onLogin});

  final TextEditingController email;
  final TextEditingController password;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              // Profile Image
              Expanded(
                flex: 1,
                child: Center(
                  child: SizedBox(
                    height: 100,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image.asset(
                        'asset/img/profile.jpg',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),

              // Email and Password Fields
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      decoration: const InputDecoration(
                        hintText: "Enter Email",
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: password,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: "Enter Password",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Login Button
          Center(
            child: TextButton(
              onPressed: onLogin,
              child: Container(
                height: 40,
                width: 100,
                decoration: BoxDecoration(
                  color: const Color(0xff8BB6D6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: Text(
                    "LOGIN",
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class loginboxadv extends StatelessWidget {
  const loginboxadv({super.key, required this.email, required this.password, required this.onLogin});

  final TextEditingController email;
  final TextEditingController password;
  final VoidCallback onLogin;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 0,right: 20),
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
                onPressed: onLogin,
                child: Container(
                  height: 40,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Color(0xffE6DCD0),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Login",
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
    );
  }
}