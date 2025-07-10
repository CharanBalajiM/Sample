import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scheduler/scheduler/widgets/date_time.dart';

class SchedulerPage extends StatefulWidget {
  const SchedulerPage({super.key});

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class _SchedulerPageState extends State<SchedulerPage> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    // Only keep the date part
    DateTime selectedDay = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    return Scaffold(
      appBar: AppBar(
        title: Text('Scheduler', style: GoogleFonts.poppins(fontSize: 20)),
        backgroundColor: const Color(0xFFECECEC),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Date_Time(onDateSelected: (date) {  },),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('Upcoming Schedules', style: GoogleFonts.poppins(fontSize: 16)),
            ),
            const SizedBox(height: 10),
            FourteenDaySelector(
              selectedDate: selectedDate,
              onDateSelected: (newDate) {
                setState(() {
                  selectedDate = newDate;
                });
              },
            ),
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
                    child: Text('No schedules yet'),
                  );
                }

                final docs = snapshot.data!.docs.where((doc) {
                  final startTime = DateTime.parse(doc['start']);
                  return startTime.year == selectedDay.year &&
                         startTime.month == selectedDay.month &&
                         startTime.day == selectedDay.day;
                }).toList();

                if (docs.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.all(20),
                    child: Text('No schedules for this day',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: const Color.fromARGB(255, 137, 143, 254))),
                  );
                }

                return ListView.builder(
                  itemCount: docs.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final start = DateTime.parse(doc['start']);
                    final end = DateTime.parse(doc['end']);
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text('${DateFormat('hh:mm a').format(start)}',
                                style: GoogleFonts.poppins(
                                      color: const Color.fromARGB(255, 137, 143, 254),
                                      fontWeight: FontWeight.w500)),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Container(
                            padding: const EdgeInsets.all(14),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 137, 143, 254),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Start: ${DateFormat('hh:mm a').format(start)}',
                                      style: GoogleFonts.poppins(color: Colors.white)),
                                  Text('End: ${DateFormat('hh:mm a').format(end)}',
                                      style: GoogleFonts.poppins(color: Colors.white)),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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

class FourteenDaySelector extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const FourteenDaySelector({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final List<DateTime> upcomingDays = List.generate(
      14,
      (index) => DateTime.now().add(Duration(days: index)),
    );

    return SizedBox(
      height: 70,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: upcomingDays.length,
        itemBuilder: (context, index) {
          final date = upcomingDays[index];
          final isSelected = date.day == selectedDate.day &&
              date.month == selectedDate.month &&
              date.year == selectedDate.year;

          return GestureDetector(
            onTap: () => onDateSelected(date),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('E').format(date), // Mon
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected ? Colors.green : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    decoration: isSelected
                        ? const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: Colors.green, width: 2),
                            ),
                          )
                        : null,
                    child: Text(
                      DateFormat('dd').format(date),
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? Colors.green : Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
