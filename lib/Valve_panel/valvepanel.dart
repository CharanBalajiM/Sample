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
  bool isToggledValve1 = false;
  bool isToggledValve2 = false;
  bool isToggledValve3 = false;
    void initState() {
    super.initState();
    fetchValveStatuses();
  }


  @override
  void fetchValveStatuses() async {
    try {
      final doc = await FirebaseFirestore.instance
          .collection('valve')
          .doc('valve_status')
          .get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          setState(() {
            isToggledValve1 = data['valve1'] ?? false;
            isToggledValve2 = data['valve2'] ?? false;
            isToggledValve3 = data['valve3'] ?? false;
          });
        }
      }
    } catch (e) {
      print('Error fetching valve statuses: $e');
    }
  }

  void updateValveStatus(String valveKey, bool status) async {
    try {
      await FirebaseFirestore.instance
          .collection('valve')
          .doc('valve_status')
          .update({
        valveKey: status,
        '${valveKey}_last_${status ? 'on' : 'off'}': DateTime.now(),
      });
      print('$valveKey updated to $status');
    } catch (e) {
      print('Error updating $valveKey: $e');
    }
  }

  void showSnackbar(BuildContext context, bool isOn, String label) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$label turned ${isOn ? 'ON' : 'OFF'}',
            style: GoogleFonts.poppins()),
        backgroundColor: isOn ? Colors.green : Colors.red,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  Widget buildValveCard({
    required String label,
    required bool toggled,
    required void Function(bool) onChanged,
  }) {
    return Center(
      child: Container(
        width: 250,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(horizontal: 30),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Image.asset(
                  toggled ? 'asset/gif/valve.gif' : "asset/img/valve_img.png",
                  width: 40,
                  height: 40,
                ),
                const Spacer(),
                Switch(
                  value: toggled,
                  activeTrackColor: Colors.blue,
                  inactiveThumbColor: const Color.fromARGB(255, 85, 85, 85),
                  inactiveTrackColor:
                      const Color.fromARGB(255, 235, 235, 235),
                  onChanged: onChanged,
                ),
                Text(
                  toggled ? 'ON' : 'OFF',
                  style: GoogleFonts.poppins(fontSize: 14),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(label,
                style: GoogleFonts.poppins(
                    fontSize: 16, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final day = DateFormat('dd').format(now);
    final month = DateFormat('MMMM').format(now);
     @override
    @override
   void initState() {
    super.initState();
    fetchValveStatuses();
  }
    return Scaffold(
      appBar: AppBar(
        title: Text('Valve Panel', style: GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: const Color(0xFFECECEC),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Date Display
          Padding(
            padding: const EdgeInsets.only(left: 20, top: 0),
            child: Text(
              '$month $day',
              style: GoogleFonts.poppins(
                  fontSize: 16, color: const Color(0xff666666)),
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
                      child: Icon(Icons.add_chart,
                          size: 20, color: Colors.blue),
                    ),
                    TextSpan(
                      text: ' Total valves',
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: const Color(0xff666666)),
                    ),
                    TextSpan(
                      text: " 3",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 66, 66, 66),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    const WidgetSpan(
                      child: Icon(Icons.speed,
                          size: 20,
                          color: Color.fromARGB(255, 207, 83, 45)),
                    ),
                    TextSpan(
                      text: ' Valve Pressure',
                      style: GoogleFonts.poppins(
                          fontSize: 16, color: const Color(0xff666666)),
                    ),
                    TextSpan(
                      text: " 20",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: const Color.fromARGB(255, 66, 66, 66),
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 25),

          // Valve 1
          buildValveCard(
            label: "Valve 1",
            toggled: isToggledValve1,
            onChanged: (value) {
              setState(() => isToggledValve1 = value);
              updateValveStatus('valve1', value);
              showSnackbar(context, value, 'Valve 1');
            },
          ),
          const SizedBox(height: 25),

          // Valve 2
          buildValveCard(
            label: "Valve 2",
            toggled: isToggledValve2,
            onChanged: (value) {
              setState(() => isToggledValve2 = value);
              updateValveStatus('valve2', value);
              showSnackbar(context, value, 'Valve 2');
            },
          ),
          const SizedBox(height: 25),

          // Valve 3
          buildValveCard(
            label: "Valve 3",
            toggled: isToggledValve3,
            onChanged: (value) {
              setState(() => isToggledValve3 = value);
              updateValveStatus('valve3', value);
              showSnackbar(context, value, 'Valve 3');
            },
          ),
        ],
      ),
    );
  }
}
