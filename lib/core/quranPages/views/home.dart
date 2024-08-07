import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran_app/core/quranPages/views/surah_list.dart';



class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var widgejsonData;
  var quarterjsonData;

   Future<void> loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/surahs.json');
    var data = jsonDecode(jsonString);
    setState(() {
      widgejsonData = data;
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
      body: Center(
        child: ElevatedButton(onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (builder)=> SurahList(surahJsonData: widgejsonData)));
        }, child: const Text("Go to Surah List")),
      ),
    );
  }
}