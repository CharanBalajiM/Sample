import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Schedulestatus extends StatelessWidget {
  const Schedulestatus({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
            child: Container(
              height: 95,
              width: 325,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFfD7D7D7)
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 40,top: 15),
                    child: Row(
                      children: [
                        Text(
                          'Schedule status',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w400
                          ),),
                          Icon(Icons.chevron_right_sharp),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Row(
                              children: [
                                Text('Motor : ',
                                style: GoogleFonts.inriaSans(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w400,
                                  fontSize:16
                                ),),
                                Text('On',
                                style: GoogleFonts.inriaSans(
                                  color: Color(0xFF81C784),
                                  fontSize:16

                                ),)
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('Valve : ',
                            style: GoogleFonts.inriaSans(
                                  color: Color(0xFF666666),
                                  fontWeight: FontWeight.w400,
                                  fontSize:16

                                ),),
                            Text('On',
                                style: GoogleFonts.inriaSans(
                                  color: Color(0xFF81C784),
                                  fontSize:16
                                ),)
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
              
            ),
          );
  }
}
