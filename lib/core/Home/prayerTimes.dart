// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/constants.dart';

class PrayerTimes extends StatefulWidget {
  const PrayerTimes({super.key});

  @override
  State<PrayerTimes> createState() => _PrayerTimesState();
}

class _PrayerTimesState extends State<PrayerTimes> {
 
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      width: screenSize.width,
      padding: EdgeInsetsDirectional.fromSTEB(16, 48, 16, 0),
      child: Column(
        children: [
          //Next Prayer
          const Align(
          alignment: AlignmentDirectional(-1, 0),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
            child: Text(
              'Next prayer',
              style: TextStyle(
                color: kSecondaryColor,
                fontSize: 16
              ),
              ),
            ),
          ),
          Align(
          alignment: const AlignmentDirectional(-1, 0),
          child: Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
            child: Text(
              '05h 48m 55s until Dhur',
              style: GoogleFonts.poppins(
                color: kTextColor,
                fontSize: 20,
              ),
              ),
            ),
          ),
          
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 8),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                PrayerCard(prayerName: "Fajre", activePrayer: true, prayerTime: "04:19 am"),
                PrayerCard(prayerName: "Sunrise", activePrayer: false, prayerTime: "05:37 am"),
                PrayerCard(prayerName: "Dhuhre", activePrayer: false, prayerTime: "12:25 am")
              ],
           ),
          )

          ],
        ),
    );
  }
}

class PrayerCard extends StatelessWidget {
  String prayerName;
  bool activePrayer=false;
  var prayerTime;
   PrayerCard({
    Key? key,
    required this.prayerName,
    required this.activePrayer,
    required this.prayerTime
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return // Generated code for this Container Widget...
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 16, 0),
  child: Material(
    color: Colors.transparent,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    
    child: Container(
      
      width: 107,
      height: 92,
      decoration: 
      activePrayer ? BoxDecoration(
        color: kPrimaryColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: kPrimaryColor,
        ),
      ) 
      : BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: kPrimaryLightColor,
        ),
      ) 
      ,
      child: Align(
        alignment: AlignmentDirectional(0, 0),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                    child: Text(
                      prayerName,
                      style: GoogleFonts.poppins(
                            
                            color: activePrayer ? Colors.white : kSecondaryColor,
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                    ),
                  ),
                  IconButton(
                  icon: Icon(Icons.phonelink_ring),         
                  onPressed: () => {}
                ),
                ],
              ),
              Align(
                alignment: AlignmentDirectional(0, 0),
                child: Text(
                  prayerTime,
                  style:  GoogleFonts.poppins(
                            color: activePrayer ? Colors.white : Colors.black,
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  ),
);

  }
}
