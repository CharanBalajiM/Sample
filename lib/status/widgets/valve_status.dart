import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // for formatting timestamp

class ValveStatus extends StatelessWidget {
  const ValveStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final docRef = FirebaseFirestore.instance.collection('valve').doc('valve_status');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 110,
      width: 325,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
        color: Color(0xFfD7D7D7)
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: StreamBuilder<DocumentSnapshot>(
          stream: docRef.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Text('Error loading data');
            }
            if (!snapshot.hasData || !snapshot.data!.exists) {
              return const Text('Loading...');
            }

            final data = snapshot.data!.data() as Map<String, dynamic>;

            final valve1 = data['valve1'] ?? false;
            final valve2 = data['valve2'] ?? false;
            final valve3 = data['valve3'] ?? false;
            final anyValveOn = valve1 || valve2 || valve3;
DateTime? parseTime(dynamic value) {
  if (value is Timestamp) return value.toDate();
  if (value is String) return DateTime.tryParse(value);
  return null;
}

final lastMotorOn = parseTime(data['last_on']);
final lastMotorOff = parseTime(data['last_off']);
            String formatTime(DateTime? time) {
              if (time == null) return 'N/A';
              return DateFormat.jm().format(time); // e.g. 12:15 PM
            }
            // You can add timestamps later like:
            // final startedAt = data['last_motor_on']?.toDate();
            // final stoppedAt = data['last_motor_off']?.toDate();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                   padding: const EdgeInsets.only(left: 20),
                   child: Row(
                     children: [
                       Text(
                        'Valve Status',
                        style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400),
                      ),
                      SizedBox(width: 40,),
                      Text(
                        anyValveOn ? 'Started at: ${formatTime(lastMotorOn)}':
                                    'Stopped at: ${formatTime(lastMotorOff)}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Color.fromARGB(255, 122, 122, 122)
                        ),
                      ),
                     ],
                     
                   ),
                 ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Valve:",
                          style:TextStyle(
                            color: Color(0xFF666666)
                          ) ,),
                        Text(
                          '${anyValveOn ? 'ON' : 'OFF'}',
                          style: TextStyle(
                            color: anyValveOn? Color(0xFF81C784):Color(0xffE2474A)
                          ),),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Motor:",
                          style: TextStyle(
                            color: Color(0xFF666666)
                          ),),
                        Text(
                          '${anyValveOn ? 'ON' : 'OFF'}',
                          style: TextStyle(
                            color: anyValveOn? Color(0xFF81C784):Color(0xffE2474A)
                          ),),
                      ],
                    ),
                  ]
                )
                // Example time display:
                // Text(anyValveOn ? 'Started at: ${DateFormat.jm().format(startedAt)}' : 'Stopped at: ${DateFormat.jm().format(stoppedAt)}'),
              ],
            );
          },
        ),
      ),
    );
  }
}