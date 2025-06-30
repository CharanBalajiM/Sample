import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'widgets/date_selector.dart';
import 'widgets/time_selector.dart';



class SchedulerPage extends StatefulWidget {
  const SchedulerPage({super.key});

  @override
  State<SchedulerPage> createState() => _SchedulerPageState();
}

class ScheduleEntry {
  final DateTime dateTime;

  ScheduleEntry(this.dateTime);
}

class _SchedulerPageState extends State<SchedulerPage> {
  DateTime? selectedDate;
  int selectedHour = 12;
  int? selectedMinute;
  bool isAm = true;
  List<DateTime> _savedSchedules = [];


String _formatSelectedDateTime() {
  if (selectedDate == null || selectedMinute == null) {
    return 'Please select date and time';
  }

  int hour = selectedHour;
  if (!isAm && hour != 12) hour += 12;
  if (isAm && hour == 12) hour = 0;

  final fullDateTime = DateTime(
    selectedDate!.year,
    selectedDate!.month,
    selectedDate!.day,
    hour,
    selectedMinute!,
  );

  return 'Selected: ${DateFormat('MMMM d, y – hh:mm a').format(fullDateTime)}';
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            const Text(
              'Schedule Date and Time',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 20),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],
              ),
              child: Column(
                children: [
                  DateSelector(
                    onDateChanged: (date) {
                      setState(() => selectedDate = date);
                    },
                  ),
                  const SizedBox(height: 20),
                  TimeSelector(
                    onTimeChanged: (hour, minute, am) {
                      setState(() {
                        selectedHour = hour;
                        selectedMinute = minute;
                        isAm = am;
                      });
                    },
                  ),

                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                _formatSelectedDateTime(),
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              
            ),

            ElevatedButton(
              onPressed: () {
                if (selectedDate == null || selectedMinute == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text("Please select date and time")),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Convert to 24hr format
                int hour = selectedHour;
                if (!isAm && hour != 12) hour += 12;
                if (isAm && hour == 12) hour = 0;

                final fullDateTime = DateTime(
                  selectedDate!.year,
                  selectedDate!.month,
                  selectedDate!.day,
                  hour,
                  selectedMinute!,
                );

                setState(() {
                  _savedSchedules.add(fullDateTime);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Center(
                      child: Text("Schedule saved: ${DateFormat('MMM d, y – hh:mm a').format(fullDateTime)}"),
                    ),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text('Save Schedule'),
            ),

            const SizedBox(height: 20),
            Text('Upcoming Schedules',style: TextStyle(
              fontSize: 16,
            ),),
            Container(
              height: 200,
              width: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(color: Colors.black12, blurRadius: 4),
                ],),
              child: _savedSchedules.isEmpty
                ?const Center(child: Text('No Schedules added'),)
                : Builder(
                  builder: (context) {
                    return ListView.builder(
                      itemCount: _savedSchedules.length,
                      itemBuilder: (context, index) {
                        final entry = _savedSchedules[index];
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Text(
                                DateFormat('MMM d, y – hh:mm a').format(entry),
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                setState(() {
                                  _savedSchedules.removeAt(index);
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Schedule Deleted')),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                    
                  }
                )
            ),
          ],
        ),
      ),
    );
  }
}
