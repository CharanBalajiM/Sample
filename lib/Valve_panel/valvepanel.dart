import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class Valvepanel extends StatefulWidget {
  const Valvepanel({super.key});

  @override
  State<Valvepanel> createState() => _ValvepanelState();
}

class _ValvepanelState extends State<Valvepanel> {
  bool isToggled = false;
  bool isToggledValve2 = false;

  @override
  void get initState {
    super.initState;
    fetchValveStatus(); // Fetch Firestore valve1 value on screen load
  }

  // Fetch valve1 value from Firestore
  void fetchValveStatus() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection('valve')
          .doc('valve_status')
          .get();

      if (snapshot.exists) {
        final data = snapshot.data();
        if (data != null && data.containsKey('valve1')) {
          setState(() {
            isToggled = data['valve1'] ?? false;
          });
        }
      }
    } catch (e) {
      print('Error fetching valve1 status: $e');
    }
  }

  // Update valve1 in Firestore when toggled
  void updateValve1Status(bool status) async {
    try {
      await FirebaseFirestore.instance.collection('valve').doc('valve_status').update({
        'valve1': status,
        status ? 'last_on' : 'last_off': DateTime.now().toString(),
      });
      print('Valve 1 status updated to $status');
    } catch (e) {
      print('Error updating valve1: $e');
    }
  }

  void updateValve2Status(bool status) async {
  try {
    await FirebaseFirestore.instance
        .collection('valve')
        .doc("valve_status")
        .update({
          'valve2': status,
          status ? 'valve2_last_on' : 'valve2_last_off': DateTime.now(),
        });
    print('Valve 2 status updated to $status');
  } catch (e) {
    print('Error updating valve 2: $e');
  }
}
void fetchValve2Status() async {
  final doc = await FirebaseFirestore.instance
      .collection('valve')
      .doc('valve_status')
      .get();

  if (doc.exists) {
    final data = doc.data();
    if (data != null && data.containsKey('valve2')) {
      setState(() {
        isToggledValve2 = data['valve2'];
      });
    }
  }
}

  
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final day = DateFormat('dd').format(now);
    final month = DateFormat('MMMM').format(now);

    return Scaffold(
      appBar: AppBar(
        title: Text('Valve Panel', style: GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: const Color(0xFFECECEC),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 20),
            child: Text(
              '$month $day',
              style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xff666666)),
            ),
          ),
          const SizedBox(height: 10),

          // Info Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                        child: Icon(Icons.add_chart, size: 20, color: Colors.blue)),
                    TextSpan(
                        text: ' Total valves',
                        style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xff666666))),
                    TextSpan(
                        text: " 3",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 66, 66, 66),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                        child: Icon(Icons.speed, size: 20, color: Color.fromARGB(255, 207, 83, 45))),
                    TextSpan(
                        text: ' Valve Pressure',
                        style: GoogleFonts.poppins(fontSize: 16, color: const Color(0xff666666))),
                    TextSpan(
                        text: " 20",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: const Color.fromARGB(255, 66, 66, 66),
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Toggle Valve Card
          Center(
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Valve Row
                  Row(
                    children: [
                      Image.asset(
                        isToggled ? 'asset/gif/valve.gif' : "asset/img/valve_img.png",
                        width: 40,
                        height: 40,
                      ),
                      const Spacer(),
                      Switch(
                        value: isToggled,
                        activeTrackColor: Colors.blue,
                        inactiveThumbColor: const Color.fromARGB(255, 85, 85, 85),
                        inactiveTrackColor: const Color.fromARGB(255, 235, 235, 235),
                        onChanged: (value) {
                          setState(() {
                            isToggled = value;
                          });
                          updateValve1Status(value);
            
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Valve 1 turned ON ', style: GoogleFonts.poppins()),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Valve 1 turned OFF ', style: GoogleFonts.poppins()),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        }
            
                      ),
                      Text(
                        isToggled ? 'ON' : 'OFF',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
            
                  const SizedBox(height: 10),
                  
                  Text("Valve 1",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Toggle Valve Card
          Center(
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Valve Row
                  Row(
                    children: [
                      Image.asset(
                        isToggled ? 'asset/gif/valve.gif' : "asset/img/valve_img.png",
                        width: 40,
                        height: 40,
                      ),
                      const Spacer(),
                      Switch(
                        value: isToggled,
                        activeTrackColor: Colors.blue,
                        inactiveThumbColor: const Color.fromARGB(255, 85, 85, 85),
                        inactiveTrackColor: const Color.fromARGB(255, 235, 235, 235),
                        onChanged: (value) {
                          setState(() {
                            isToggled = value;
                          });
                          updateValve1Status(value);
            
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Valve 1 turned ON ', style: GoogleFonts.poppins()),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Valve 1 turned OFF ', style: GoogleFonts.poppins()),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        }
            
                      ),
                      Text(
                        isToggled ? 'ON' : 'OFF',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
            
                  const SizedBox(height: 10),
                  
                  Text("Valve 2",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
          const SizedBox(height: 25),

          // Toggle Valve Card
          Center(
            child: Container(
              width: 250,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 8, offset: const Offset(0, 4)),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 30),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Valve Row
                  Row(
                    children: [
                      Image.asset(
                        isToggled ? 'asset/gif/valve.gif' : "asset/img/valve_img.png",
                        width: 40,
                        height: 40,
                      ),
                      const Spacer(),
                      Switch(
                        value: isToggled,
                        activeTrackColor: Colors.blue,
                        inactiveThumbColor: const Color.fromARGB(255, 85, 85, 85),
                        inactiveTrackColor: const Color.fromARGB(255, 235, 235, 235),
                        onChanged: (value) {
                          setState(() {
                            isToggled = value;
                          });
                          updateValve1Status(value);
            
                          if (value) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Valve 1 turned ON ', style: GoogleFonts.poppins()),
                                backgroundColor: Colors.green,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Valve 1 turned OFF ', style: GoogleFonts.poppins()),
                                backgroundColor: Colors.red,
                                duration: Duration(seconds: 1),
                              ),
                            );
                          }
                        }
            
                      ),
                      Text(
                        isToggled ? 'ON' : 'OFF',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
            
                  const SizedBox(height: 10),
                  
                  Text("Valve 3",
                      style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
