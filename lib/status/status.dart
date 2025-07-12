import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/scheduler/scheduler_page.dart';
import 'package:scheduler/Auth/loginpage.dart';
import 'package:scheduler/status/quickaction.dart';
import 'package:scheduler/status/widgets/schedule_status.dart';
import 'package:scheduler/status/widgets/valve_status.dart';
import 'package:scheduler/Valve_panel/valvepanel.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  int _selectedIndex = 0;


Widget _getPage(int index) {
  switch (index) {
    case 0:
      return _statusMainContent(); // now called fresh every time
    case 1:
      return Valvepanel() ;
    case 2:
      return const SchedulerPage();

    default:
      return const Center(child: Text('Page not found'));
  }
}

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      drawer: SizedBox(
        width: 220, // Set your desired drawer width
        child: Drawer(
          backgroundColor: const Color(0xFFECECEC),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                height: 100,
                color: const Color(0xFFECECEC),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 25, left: 10),
                child: const Center(
                  child: Text(
                    'More',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Divider(color: Colors.black,),
              const ListTile(
                leading: Icon(Icons.home),
                title: Text('Home'),
                contentPadding: EdgeInsets.symmetric(horizontal: 16),

              ),
              ListTile(
          leading: const Icon(Icons.logout_rounded),
          title: const Text('Logout'),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
          onTap: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => Loginpage()),
            );
          },
        ),
            ],
          ),
        ),
      ),

      appBar: AppBar(
        backgroundColor: const Color(0xFFECECEC),
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

      // Main content switches based on selected index
      body: _getPage(_selectedIndex),

      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.plumbing ),
            label: 'Valve Panel',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: (index) {

    setState(() {
      _selectedIndex = index;
    });
  },

        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  // Your original dashboard content
  Widget _statusMainContent() {
    return ListView(
      padding: const EdgeInsets.only(top: 15, bottom: 25),
      children: [
        const wishes(),
        const SizedBox(height: 20),
        const Quickaction(),
        const SizedBox(height: 25),
        Column(
          children: const [
            ValveStatus(),
            SizedBox(height: 25),
            ScheduleStatus(),
            SizedBox(height: 25),
            weather_status(),
          ],
        ),
      ],
    );
  }
}

// Greeting widget
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
            'Good Morning, User!',
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w500,
              color: Color(0xFF333333), 
            ),
          ),
          Text(
            'What Shall We Do Today?',
            style: GoogleFonts.poppins(
              color: Color(0xFF666666),
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }
}
class weather_status extends StatelessWidget {
  const weather_status({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 110,
      width: 325,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: Color(0xFfD7D7D7),
        )
      ),
      child: Column(
        crossAxisAlignment:CrossAxisAlignment.start ,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20,left: 40),
            child: Row(
              children: [
                Text("Weather Status",
                style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400),),
                SizedBox(width: 40,),
                  Row(
                    children: [
                      Text("Weather:",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 122, 122, 122)
                              ),
                            ),
                      Text("Good",
                              style: TextStyle(
                                fontSize: 12,
                                color: Color.fromARGB(255, 114, 215, 103)
                              ),
                            ),
                    ],
                  ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 80),
            child: Row(
              children: [
                Text('It may rain soon',
                style:TextStyle(
                  color: Color(0xFF666666)
                  ) ,),
                  Icon(Icons.water_drop_outlined,color: Colors.blue,)
              ],
            ),
          )
        ],
      ),
    );
  }
}
