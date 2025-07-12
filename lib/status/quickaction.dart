import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quickaction extends StatefulWidget {
  const Quickaction({super.key});

  @override
  State<Quickaction> createState() => _QuickactionState();
}

class _QuickactionState extends State<Quickaction> {
 bool isValveOn=false;

 void togglevalveon() async{
  setState((){
    isValveOn=!isValveOn;
  });

  await FirebaseFirestore.instance
  .collection('valve')
  .doc('valve_status')
  .update({
    'valve1':true,
    'valve2':true,
    'valve3':true,
    'last_on':DateTime.now()});

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Center(
      child: Text("All Valves On",
      style:TextStyle(color: Colors.white) ,),
    ),
    backgroundColor: const Color(0xFFA2CA6C),
    duration: Duration(seconds: 1),)
  );
 }
 void togglevalveoff() async{
  setState((){
    isValveOn=!isValveOn;
  });

  await FirebaseFirestore.instance
  .collection('valve')
  .doc('valve_status')
  .update({
    'valve1':false,
    'valve2':false,
    'valve3':false,
    'last_off':DateTime.now()});

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Center(
      child: Text("All Valves Off",
      style:TextStyle(color: Colors.white) ,),
    ),
    backgroundColor: const Color(0xFFE87D7D),
    duration: Duration(seconds: 1),)
  );
 }

@override
  Widget build(BuildContext context) {
    return Center(
           child: Container(
             height: 80,
             width: 280,
             decoration: BoxDecoration(
               color: Colors.white,
               borderRadius: BorderRadius.circular(15),
             ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Padding(
                     padding: const EdgeInsets.only(top: 10,left: 15),
                     child: Text('Quick Action',
                     style: GoogleFonts.inter(
                       fontSize: 16,
                       fontWeight: FontWeight.w400
                     ),),
                   ),
                   Padding(
                     padding: const EdgeInsets.all(10),
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.spaceEvenly ,
                       children: [
                        GestureDetector(
                          onTap: togglevalveon,
                          child: 
                         Container(
                           height: 25,
                           width: 120,
                           padding: EdgeInsets.only(left: 10),
                           decoration: BoxDecoration(
                             color: Color(0xFFA2CA6C),
                             borderRadius: BorderRadius.circular(20),
                             boxShadow: [BoxShadow(
                              color: const Color.fromARGB(255, 170, 224, 173),
                              blurRadius: 4,
                              offset: Offset(0, 2)
                             )]
                           ),
                           child: Row(
                             children: [
                               Text.rich(
                                 TextSpan(
                                   children: [
                                     TextSpan(
                                       text: 'All Valves : ',
                                       style: GoogleFonts.inter(
                                         color: Colors.white,
                                         fontSize: 13
                                       )
                                     ),
                                     TextSpan(
                                       text: 'ON',
                                       style: GoogleFonts.inter(
                                         color: Color.fromARGB(255, 14, 97, 17),
                                         fontSize: 15,
                                         fontWeight: FontWeight.bold
                                       )
                                     )
                                   ],
                                 ),
                                 
                                 
                               )
                             ],
                           ),
                         ),),
                         GestureDetector(
                          onTap: togglevalveoff,
                          child: 
                         Container(
                           height: 25,
                           width: 120,
                           padding: EdgeInsets.only(left: 10),
                           decoration: BoxDecoration(
                             color: Color(0xFFE87D7D),
                             borderRadius: BorderRadius.circular(20),
                             boxShadow: [BoxShadow(
                              color: const Color.fromARGB(255, 225, 194, 169),
                              blurRadius: 4,
                              offset: Offset(0, 2)
                             )]
                           ),
                           child: Row(
                             children: [
                               Text.rich(
                                 TextSpan(
                                   children: [
                                     TextSpan(
                                       text: 'All Valves : ',
                                       style: GoogleFonts.inter(
                                         color: Colors.white,
                                         fontSize: 13
                                       )
                                     ),
                                     TextSpan(
                                       text: 'OFF',
                                       style: GoogleFonts.inter(
                                         color: Color.fromARGB(255, 118, 15, 15),
                                         fontSize: 15,
                                         fontWeight: FontWeight.bold
                                       )
                                     )
                                   ],
                                 ),
                                 
                                 
                               )
                             ],
                           ),
                         ),),
                       ],
                     ),
                   )
                 ],
                 
               ),
             ),
           );
  }
}
  