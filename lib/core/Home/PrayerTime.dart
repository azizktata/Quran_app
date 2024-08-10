// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:quran_app/constants.dart';
import 'package:intl/intl.dart';

class PrayerTime extends StatefulWidget {

   PrayerTime({super.key});

  @override
  State<PrayerTime> createState() => _PrayerTimeState();
}

 class _PrayerTimeState extends State<PrayerTime> {

//   /// Determine the current position of the device.
 Future<Position> _determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;

  // Test if location services are enabled.
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the 
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale 
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
  
  if (permission == LocationPermission.deniedForever) {
    // Permissions are denied forever, handle appropriately. 
    return Future.error(
      'Location permissions are permanently denied, we cannot request permissions.');
  } 

  // When we reach here, permissions are granted and we can
  // continue accessing the position of the device.
     return await Geolocator.getCurrentPosition();
}

  late PrayerTimes todayPrayerTime;
  //  Position? _currentPosition;
  late Coordinates? myCoordinates;
 
 void _getCurrentLocation() async {

    Position position = await _determinePosition();

    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;
    params.adjustments.isha = 7;
    params.adjustments.isha = 7;
    final date = DateComponents.from(DateTime.now());
      // print(position.latitude);
      // print(position.longitude);
      final myCoordinates = Coordinates(position.latitude, position.longitude, validate: true);
      if(myCoordinates!= null){
        final prayerTimes =  PrayerTimes.today(myCoordinates!, params);
        setState(() {
          todayPrayerTime = prayerTimes;
        }); 
    }
  }
  String fajrTime="";
 @override
  void initState()  {

      _getCurrentLocation();
    //  fajrTime = DateFormat('HH:mm').format(todayPrayerTime!.fajr.toLocal());
    
  }
  // DateTime? fajreTime = todayPrayerTime?.fajr.toLocal();
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Container(
      // width: screenSize.width,
      child: Padding(
        padding: const EdgeInsets.only(top:16.0, left: 16, right: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Next Prayer
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text(
                'Next prayer',
                style: TextStyle(
                  color: kSecondaryColor,
                  fontSize: 16
                ),
                ),
              ),
            
           Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                '05;12 min until ${todayPrayerTime.nextPrayer()}',
                style: GoogleFonts.poppins(
                  color: kTextColor,
                  fontSize: 20,
                ),
                ),
              ),
            
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                       Expanded(child: PrayerCard(prayerName: "Fajre", activePrayer: true, prayerTime: "${todayPrayerTime.fajr.hour}:${todayPrayerTime.fajr.minute} am")),
                       Expanded(child: PrayerCard(prayerName: "Sunrise", activePrayer: false, prayerTime: "${todayPrayerTime.sunrise.hour}:${todayPrayerTime.sunrise.minute} am")),
                       Expanded(child: PrayerCard(prayerName: "Dhuhr", activePrayer: false, prayerTime: "${todayPrayerTime.dhuhr.hour}:${todayPrayerTime.dhuhr.minute} pm")),
                    ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                       Expanded(child: PrayerCard(prayerName: "Asre", activePrayer: false, prayerTime: "${todayPrayerTime.asr.hour}:${todayPrayerTime.asr.minute} pm")),
                       Expanded(child: PrayerCard(prayerName: "Maghrib", activePrayer: false, prayerTime: "${todayPrayerTime.maghrib.hour}:${todayPrayerTime.maghrib.minute} pm")),
                       Expanded(child: PrayerCard(prayerName: "Isha", activePrayer: false, prayerTime: "${todayPrayerTime.isha.hour}:${todayPrayerTime.isha.minute} pm")),
                    ],
              ),
            ),
            ],
          ),
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

  bool _isIconPressed = false;

  @override
  Widget build(BuildContext context) {
    return 
Padding(
  padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
  child: Material(
    color: Colors.transparent,
    elevation: 3,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    
    child: Container(
      
      width: 110,
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
          padding: prayerName=="Maghrib" ? EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0) : EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                 Text(
                      prayerName,
                      style: GoogleFonts.poppins(
                            
                            color: activePrayer ? Colors.white : kSecondaryColor,
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                    ),
               
                  IconButton(
                  icon: Icon( _isIconPressed ? Icons.alarm : Icons.vibration),         
                  onPressed: () {
                    
                  }
                ),
                ],
              ),
              Text(
                  prayerTime,
                  style:  GoogleFonts.poppins(
                            color: activePrayer ? Colors.white : Colors.black,
                            fontSize: 15,
                            letterSpacing: 0,
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
