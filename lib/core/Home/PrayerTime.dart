// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:typed_data';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:quran_app/constants.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/core/local_notification.dart';

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
 
late PrayerTimes todayPrayerTimes;

 Future<PrayerTimes> _getCurrentLocation() async {

    Position position = await _determinePosition();

    final params = CalculationMethod.muslim_world_league.getParameters();
    params.madhab = Madhab.shafi;
    params.adjustments.isha = 7;
    params.adjustments.isha = 7;

    final myCoordinates = Coordinates(position.latitude, position.longitude, validate: true); 
    final prayerTimes =  PrayerTimes.today(myCoordinates, params);
    setState(() {
      todayPrayerTimes = prayerTimes;
    });
 
    return prayerTimes;
    
  }

  Future<PrayerTimes>? _futurePrayerTimes;

PlayerState? _playerState;
final player = AudioPlayer();
bool get _isPlaying => _playerState == PlayerState.playing;

Future playAudio() async {
    // final date = DateComponents.from(DateTime.now());
    // if(DateTime.now().hour == todayPrayerTimes?.timeForPrayer(todayPrayerTimes!.nextPrayer())?.hour)
    await player.play(AssetSource('adhan/adhen-tounes-ali-barek.mp3'));
}
void handlePlayPause()  {
    player.pause();
}

void checkPrayerTimeNotification() {
  // bool isAllowed = true; // your condition variable
  DateTime targetTime = DateTime.now(); // your target time
  // todayPrayerTimes?.timeForPrayer(todayPrayerTimes!.nextPrayer())

    LocalNotification.showSimpleNotification(
      title: 'It is Time for Prayer',
      body: 'Do your prayer in the masjid',
      payload: 'aaa'
    );
  
}

 @override
  void initState()  {
    _futurePrayerTimes = _getCurrentLocation();
    checkPrayerTimeNotification();
  }
  // DateTime? fajreTime = todayPrayerTime?.fajr.toLocal();

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return FutureBuilder(
      future: _futurePrayerTimes,
      builder: (BuildContext context, AsyncSnapshot snapshot){
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
                    '05h:12min until ${snapshot.data?.nextPrayer()}',
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
                           Expanded(child: PrayerCard(prayerName: "Fajre", activePrayer: snapshot.data?.nextPrayer()==Prayer.fajr ? true : false, prayerTime: "${snapshot.data?.fajr.hour}:${snapshot.data?.fajr.minute} am", playAudio: () { playAudio(); },stopAudio: () { handlePlayPause(); })),
                           Expanded(child: PrayerCard(prayerName: "sunrise", activePrayer: snapshot.data?.nextPrayer()==Prayer.sunrise ? true : false, prayerTime: "${snapshot.data?.sunrise.hour}:${snapshot.data?.sunrise.minute} am",playAudio: () { playAudio(); },stopAudio: () { handlePlayPause();}),),
                           Expanded(child: PrayerCard(prayerName: "Dhuhr", activePrayer: snapshot.data?.nextPrayer()==Prayer.dhuhr ? true : false, prayerTime: "${snapshot.data?.dhuhr.hour}:${snapshot.data?.dhuhr.minute} pm",playAudio: () { playAudio(); },stopAudio: () { handlePlayPause();})),
                        ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                           Expanded(child: PrayerCard(prayerName: "Asre", activePrayer: snapshot.data?.nextPrayer()==Prayer.asr ? true : false, prayerTime: "${snapshot.data?.asr.hour}:${snapshot.data?.asr.minute} pm", playAudio: () { playAudio(); },stopAudio: () { handlePlayPause(); })),
                           Expanded(child: PrayerCard(prayerName: "Maghrib", activePrayer: snapshot.data?.nextPrayer()==Prayer.maghrib ? true : false, prayerTime: "${snapshot.data?.maghrib.hour}:${snapshot.data?.maghrib.minute} pm", playAudio: () { playAudio(); },stopAudio: () { handlePlayPause(); })),
                           Expanded(child: PrayerCard(prayerName: "Isha", activePrayer: snapshot.data?.nextPrayer()==Prayer.isha ? true : false, prayerTime: "${snapshot.data?.isha.hour}:${snapshot.data?.isha.minute} pm", playAudio: () { playAudio(); },stopAudio: () { handlePlayPause(); })),
                        ],
                  ),
                ),
                ],
              ),
          ),
        );
      }
    );
  }
 }


class PrayerCard extends StatefulWidget {
  String prayerName;
  bool activePrayer=false;
  var prayerTime;
  final Function() playAudio;
  final Function() stopAudio;
   PrayerCard({
    Key? key,
    required this.prayerName,
    required this.activePrayer,
    required this.prayerTime,
    required this.playAudio,
    required this.stopAudio
  }) : super(key: key);

  @override
  State<PrayerCard> createState() => _PrayerCardState();
}

class _PrayerCardState extends State<PrayerCard> {
  bool _isIconPressed = false;

  void _toggleIcon() {
    setState(() {
      _isIconPressed = !_isIconPressed;
    });
  }

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
      widget.activePrayer ? BoxDecoration(
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
          padding: widget.prayerName=="Maghrib" ? EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0) : EdgeInsetsDirectional.fromSTEB(8, 0, 0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                 Text(
                      widget.prayerName,
                      style: GoogleFonts.poppins(
                            
                            color: widget.activePrayer ? Colors.white : kSecondaryColor,
                            fontSize: 15,
                            letterSpacing: 0,
                          ),
                    ),
               
                  IconButton(
                  icon: widget.prayerName!= "sunrise" ? Icon( _isIconPressed ? Icons.alarm : Icons.vibration) : Icon(Icons.vibration),         
                  onPressed: () {
                    
                    if (widget.prayerName != "sunrise"){
                      _toggleIcon();
                      if( _isIconPressed)
                      {
                        widget.playAudio();
                      }
                      widget.stopAudio();
                    }
            
                  }
                ),
                ],
              ),
              Text(
                  widget.prayerTime,
                  style:  GoogleFonts.poppins(
                            color: widget.activePrayer ? Colors.white : Colors.black,
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
