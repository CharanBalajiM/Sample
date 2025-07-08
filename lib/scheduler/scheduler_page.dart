import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:scheduler/scheduler/widgets/date_time.dart';

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({super.key});

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Scheduler',
            style: GoogleFonts.poppins(
              fontSize: 20
            ),),
          backgroundColor: Color(0xFFECECEC),
        ),
        body: SingleChildScrollView(
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Date_Time(),
      const SizedBox(height: 15),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          'Upcoming Schedules',
          style: GoogleFonts.poppins(fontSize: 16),
        ),
      ),
      const SizedBox(height: 10),
      StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('Schedules')
            .orderBy('start')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Padding(
              padding: EdgeInsets.all(20),
              child: Text('No Schedules yet'),
            );
          }

          final schedules = snapshot.data!.docs;

          return ListView.builder(
            itemCount: schedules.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final doc = schedules[index];
              final start = DateTime.parse(doc['start']);
              final end = DateTime.parse(doc['end']);

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xfff5f5f5),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Start: ${DateFormat('dd MMM yyyy – hh:mm a').format(start)}',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                      Text(
                        'End: ${DateFormat('dd MMM yyyy – hh:mm a').format(end)}',
                        style: GoogleFonts.poppins(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    ],
  ),
),
    );
  }
}