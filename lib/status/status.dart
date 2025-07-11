import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scheduler/scheduler/scheduler_page.dart';
import 'package:scheduler/Auth/loginpage.dart';
import 'package:scheduler/status/quickaction.dart';
import 'package:scheduler/status/shedulestatus.dart';
import 'package:scheduler/status/widgets/valve_status.dart';
import 'package:scheduler/Valve_panel/valvepanel.dart';

class StatusPage extends StatefulWidget {
  const StatusPage({super.key});

  @override
  State<StatusPage> createState() => _StatusPageState();
}

class _StatusPageState extends State<StatusPage> {
  int _selectedIndex = 0;

// REMOVE _pages and initState entirely

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
              child: const Center(
                child: Text(
                  'Drawer Header',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            const ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
            ),
            Row(
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Loginpage()),
                    );
                  },
                  child: const Text('Logout'),
                ),
                const Icon(Icons.logout)
              ],
            ),
          ],
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
            Schedulestatus(),
            SizedBox(height: 25),
            Schedulestatus(),
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
