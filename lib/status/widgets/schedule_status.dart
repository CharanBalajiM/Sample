import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class ScheduleStatus extends StatefulWidget {
  const ScheduleStatus({super.key});

  @override
  State<ScheduleStatus> createState() => _ScheduleStatusState();
}

class _ScheduleStatusState extends State<ScheduleStatus> {
  Map<String, dynamic>? lastRun;
  Map<String, dynamic>? nextRun;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    fetchScheduleSummary();
  }

  void fetchScheduleSummary() async {
    final now = DateTime.now();

    final snapshot = await FirebaseFirestore.instance
        .collection('Schedules')
        .get();

    final docs = snapshot.docs.map((doc) {
      final data = doc.data();
      return {
        'id': doc.id,
        'start': DateTime.tryParse(data['start']),
        'end': DateTime.tryParse(data['end']),
      };
    }).where((d) => d['start'] != null && d['end'] != null).toList();

docs.sort((a, b) =>
  (b['end'] as DateTime).compareTo(a['end'] as DateTime));
final last = docs.firstWhere(
  (d) => (d['end'] as DateTime).isBefore(now),
  orElse: () => {},
);

docs.sort((a, b) =>
  (a['start'] as DateTime).compareTo(b['start'] as DateTime));
final next = docs.firstWhere(
  (d) => (d['start'] as DateTime).isAfter(now),
  orElse: () => {},
);


if (mounted) {
  setState(() {
    lastRun = last.isNotEmpty ? last : null;
    nextRun = next.isNotEmpty ? next : null;
    loading = false;
  });
}
  }

  String formatTime(DateTime? dt) {
    if (dt == null) return 'N/A';
    return DateFormat('hh:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      height: 110,
      width: 325,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFD7D7D7)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: loading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                          'Schedule Status',
                          style: GoogleFonts.inter(fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                  ),
                  const SizedBox(height: 5),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Text(
                          'Last Run:',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            ),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          '${lastRun != null ? '${formatTime(lastRun!['start'])} - ${formatTime(lastRun!['end'])}' : 'None'}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Padding(
                    padding: const EdgeInsets.only(left: 40),
                    child: Row(
                      children: [
                        Text(
                          'Next Run:',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Color(0xFF666666),
                            ),
                        ),
                        SizedBox(width: 5,),
                        Text(
                          '${nextRun != null ? '${formatTime(nextRun!['start'])} - ${formatTime(nextRun!['end'])}' : 'None'}',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.lightGreen,
                            fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
