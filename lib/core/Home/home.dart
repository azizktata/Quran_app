import 'dart:convert';

import 'package:adhan/adhan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:quran_app/constants.dart';
import 'package:quran_app/core/Home/Components/BottomNavBar.dart';
import 'package:quran_app/core/Home/prayerTime.dart';
import 'package:quran_app/core/Qiblah/Qiblah.dart';
import 'package:quran_app/core/quranPages/views/surah_list.dart';
import 'package:quran_app/enums.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var surahJsonData;
  var quarterjsonData;

   Future<void> loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/surahs.json');
    var data = jsonDecode(jsonString);
    setState(() {
      surahJsonData = data;
    });
    final String jsonString2 =
        await rootBundle.loadString('assets/json/quarters.json');
    var data2 = jsonDecode(jsonString2);
    setState(() {
      quarterjsonData = data2;
    });
 
   }

   
    @override
  void initState() {
    loadJsonAsset();
    super.initState();
  }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(AppBar().preferredSize.height),
      //   child: customBar(context),
      // ),
      body: SafeArea(
        child: Column(
          children: [
            PrayerTime()
          ],
          
          )
        ),
    
      
      bottomNavigationBar: BottomNavbar(
        selectedMenu: MenuState.home,
        surahJsonData: surahJsonData,
      ),
    );
  }
}