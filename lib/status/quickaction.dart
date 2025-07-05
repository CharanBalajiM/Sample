import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Quickaction extends StatelessWidget {
  const Quickaction({super.key});

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
                          Container(
                            height: 25,
                            width: 120,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFA2CA6C),
                              borderRadius: BorderRadius.circular(20)
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
                                          color: Color(0xFF166119),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ],
                                  ),
                                  
                                  
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 25,
                            width: 120,
                            padding: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                              color: Color(0xFFE87D7D),
                              borderRadius: BorderRadius.circular(20)
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
                                          color: Color(0xFF960808),
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold
                                        )
                                      )
                                    ],
                                  ),
                                  
                                  
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                  
                ),
              ),
            );
  }
}
  