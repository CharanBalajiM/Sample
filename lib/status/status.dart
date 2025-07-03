import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/Auth/loginpage.dart';
import 'package:scheduler/scheduler/scheduler_page.dart';

class StatusPage extends StatelessWidget {
  const StatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: Drawer(
        backgroundColor: const Color(0xFFECECEC),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 100,
              color: const Color(0xFFECECEC),
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(top: 25, left: 10),
              child: Center(
                child: const Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20),
                  
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            Row(children: [
              ElevatedButton(onPressed: ()async{
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context)=>Loginpage()),
                );
              },
             child: Text('Logout')),
             Icon(Icons.logout)
            ],),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Color(0xFFECECEC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.menu, color: Colors.black),
          onPressed: () => scaffoldKey.currentState?.openDrawer(),
        ),
        title: Center(
          child: Text(
            'MYtech',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ),
        actions: const [SizedBox(width: 48)], // to balance leading icon
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 15, bottom: 25),
        children: [
          const wishes(),
          const SizedBox(height: 20),
          const Quickaction(),
          const SizedBox(height: 25),
          ListView.builder(
            itemCount: 1, // Update as needed
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                children: const [
                  ValvestatusAdv(),
                  SizedBox(height: 25),
                  Schedulestatus(),
                  SizedBox(height: 25),
                  Schedulestatus(),
                  SizedBox(height: 25),
                  Button(),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}


class AppTitle extends StatelessWidget {
  const AppTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'MYtech',
      style: GoogleFonts.poppins(
        fontSize: 26,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }
}




class Button extends StatelessWidget {
  const Button({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SchedulerPage()),
          );
        },
        child: const Text(
          'Open Scheduler',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Colors.lightGreen,
          ),
        ),
      ),
    );
  }
}


class wishes extends StatelessWidget {
  const wishes({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good Morning, Barath!',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333),
            ),
          ),
                Text('What Shall We Do Today?',
                style: GoogleFonts.poppins(
                  color: Color(0xFF666666),
                  fontSize: 15,
                ),),
        ],
      ),
    );

    
          
          
          
  }
}

class Quickaction extends StatelessWidget {
  const Quickaction({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Container(
              
              height: 80,
              width: 280,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10,left: 15),
                      child: Text('Quick Action',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      ),),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                        children: [
                          Container(
                            height: 25,
                            width: 120,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFA2CA6C),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'All Valves : ',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 13
                                        )
                                      ),
                                      TextSpan(
                                        text: 'ON',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF166119),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ],
                                  ),
                                  
                                  
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 120,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFE87D7D),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child: Row(
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'All Valves : ',
                                        style: GoogleFonts.inter(
                                          color: Colors.white,
                                          fontSize: 13
                                        )
                                      ),
                                      TextSpan(
                                        text: 'OFF',
                                        style: GoogleFonts.inter(
                                          color: Color(0xFF960808),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ],
                                  ),
                                  
                                  
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  
                ),
              ),
            );
  }
}


class Valvestatus extends StatelessWidget {
  const Valvestatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Container(
              height: 95,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFfD7D7D7)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40,top: 15),
                    child: Text(
                      'Valve status',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text('Motor : ',
                                style: GoogleFonts.inriaSans(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w400,
                                  fontSize:16
                                ),),
                                Text('On',
                                style: GoogleFonts.inriaSans(
                                  color: Color(0xFF81C784),
                                  fontSize:16

                                ),)
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Valve : ',
                            style: GoogleFonts.inriaSans(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w400,
                                  fontSize:16

                                ),),
                            Text('On',
                                style: GoogleFonts.inriaSans(
                                  color: Color(0xFF81C784),
                                  fontSize:16
                                ),)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              
            ),
          );
  }
}




class ValvestatusAdv extends StatelessWidget {
  const ValvestatusAdv({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFfD7D7D7)
                ),
              ),
              child: ExpansionTile(title: Text(
                'Valve status:',
                style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
          children: [
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Motor : ',style: GoogleFonts.inriaSans(
                      color: Color(0xFF666666),
                      fontSize: 16,
                    ),),
                  Text('ON : ',style: GoogleFonts.inriaSans(
                      color: Color(0xFF81C784),
                      fontSize: 16,
                    ),)
                  
                ],
              ),
            ),
            ListTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Valve : ',style: GoogleFonts.inriaSans(
                      color: Color(0xFF666666),
                      fontSize: 16,
                    ),),
                  Text('ON : ',style: GoogleFonts.inriaSans(
                      color: Color(0xFF81C784),
                      fontSize: 16,
                    ),)
                  
                ],
              ),
            ),
          ],
        ),
            ));
  }
}

class Schedulestatus extends StatelessWidget {
  const Schedulestatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Container(
              height: 95,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFfD7D7D7)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40,top: 15),
                    child: Text(
                      'Schedule status',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400
                      ),),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text('Motor : ',
                                style: GoogleFonts.inriaSans(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w400,
                                  fontSize:16
                                ),),
                                Text('On',
                                style: GoogleFonts.inriaSans(
                                  color: Color(0xFF81C784),
                                  fontSize:16

                                ),)
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Valve : ',
                            style: GoogleFonts.inriaSans(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w400,
                                  fontSize:16

                                ),),
                            Text('On',
                                style: GoogleFonts.inriaSans(
                                  color: Color(0xFF81C784),
                                  fontSize:16
                                ),)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              
            ),
          );
  }
}


