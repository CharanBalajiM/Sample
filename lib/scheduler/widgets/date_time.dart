import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Date_Time extends StatelessWidget {
  const Date_Time({super.key});

  @override
  Widget build(BuildContext context) {
      final now=DateTime.now();
      final day=DateFormat('dd').format(now);
      final month=DateFormat('MMMM').format(now);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    children: [
                      Text(
                        day,
                        style: GoogleFonts.rajdhani(
                          fontSize: 18,
                          color: Color.fromARGB(255, 158, 158, 158),
                          fontWeight: FontWeight.bold
                        ),),
                        SizedBox(width: 5,),
                      Text(
                        month,
                        style: GoogleFonts.rajdhani(
                          fontSize: 18,
                          color: Color.fromARGB(255, 158, 158, 158),
                          fontWeight: FontWeight.bold
                        ),),
                    ],
                  ),
                  Text(
                    'Today',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),)
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 148, 185, 99),
                    side: BorderSide(color: Color(0xffA2CA6C))
                  ),
                  onPressed: ()=>addschedule(context),
                  child:Text(
                    '+ Add Schedule',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      color: Colors.white
                    ),), ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

void addschedule(BuildContext context){
  DateTime StartDate=DateTime.now();
  TimeOfDay StartTime=TimeOfDay.now();
  DateTime EndDate=DateTime.now();
  TimeOfDay EndTime=TimeOfDay.now();
  showDialog(
    context: context, 
    builder: (context){
      return StatefulBuilder(
        builder: (context,setState)=>AlertDialog(
          title: Text(
            'Add new schedule',
            style: GoogleFonts.poppins(

            ),),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Start Timing:',
                style: GoogleFonts.inter(
                  fontSize:18,
                  color: const Color.fromARGB(255, 38, 38, 38),
                  fontWeight: FontWeight.w400
                ),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10,),
                    Text('${DateFormat('dd MMMM yyyy').format(StartDate)} ${StartTime.format(context)}'),
                    SizedBox(width: 20,),
                    Center(
                      child: ElevatedButton(
                        onPressed: ()async{
                          final pickeddate= await showDatePicker(
                            context: context,
                            initialDate: StartDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            );
                            if (pickeddate!=null){
                              setState(()=>StartDate=pickeddate);
                            }
                            final pickedtime = await showTimePicker(
                            context: context,
                            initialTime: StartTime);
                            if (pickedtime!=null){
                              setState(()=>StartTime=pickedtime);
                            }
                          },
                        child: Text('Pick Date and time')),
                    ),
                  ],
                ),
              Text('Schedule will start on ${DateFormat('dd MMMM yyyy').format(StartDate)} at ${StartTime.format(context)}'),
              SizedBox(height: 10,),
              Text(
                'Ends Timing:',
                style: GoogleFonts.inter(
                  fontSize:18,
                  color: const Color.fromARGB(255, 38, 38, 38),
                  fontWeight: FontWeight.w400
                ),),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(height: 10,),
                    Text('${DateFormat('dd MMMM yyyy').format(EndDate)} ${EndTime.format(context)}'),
                    SizedBox(width: 20,),
                    Center(
                      child: ElevatedButton(
                        onPressed: ()async{
                          final pickeddate= await showDatePicker(
                            context: context,
                            initialDate: StartDate,
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2100),
                            );
                            if (pickeddate!=null){
                              setState(()=>StartDate=pickeddate);
                            }
                            final pickedtime = await showTimePicker(
                            context: context,
                            initialTime: StartTime);
                            if (pickedtime!=null){
                              setState(()=>StartTime=pickedtime);
                            }
                          },
                        child: Text('Pick Date and time')),
                    ),
                  ],
                ),
              Text('Schedule will end on ${DateFormat('dd MMMM yyyy').format(EndDate)} at ${EndTime.format(context)}'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: ()=>Navigator.pop(context),
                    child: Text('Clear')),
                  ElevatedButton(
                    onPressed: ()async{
                      final DateTime fullstart = DateTime(
                        StartDate.year,
                        StartDate.month,
                        StartDate.day,
                        StartTime.minute,
                        StartTime.hour,
                      );
                      final DateTime fullend = DateTime(
                        EndDate.year,
                        EndDate.month,
                        EndDate.day,
                        EndTime.minute,
                        EndTime.hour,
                      );
                      if(fullend.isBefore(fullstart)){
                        SnackBar(content: Text("Pick start timing first"),);
                      }
                      await FirebaseFirestore.instance.collection("Schedules").add(
                        {
                          'start':fullstart.toIso8601String(),
                          'end':fullend.toIso8601String(),
                          'created at':FieldValue.serverTimestamp(),
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Center(child: Text("Submitted Succesfully!"))));
                    },
                    child: Text('Submit'))
                ],
              )
            ],
          ),
        ));
});
}