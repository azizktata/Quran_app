import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/models/surah.dart';

class SurahList extends StatefulWidget {

  final surahJsonData; 
  const SurahList({super.key, required this.surahJsonData});

  @override
  State<SurahList> createState() => _SurahListState();
}



class _SurahListState extends State<SurahList> {

  List<Surah> surahList = [];
  @override
  void initState() {
    // fetchSurahs();
    super.initState();
  }
  
  // void fetchSurahs() async {
  //   await Future.delayed(const Duration(milliseconds: 600));
  //   setState(() {
  //     surahList = widget.surahJsonData;
  //   });
  // }

TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Quran Surah Page"),),
      body: Column(
        children: [
          // TextField( //search text field
          //   textDirection: TextDirection.rtl,
          //   controller: textEditingController,
          //   onChanged: (value) {},
          //   style: const TextStyle(color: Color.fromARGB(190, 0, 0, 0)),
          //   decoration: const InputDecoration(),
          // ),

         
          //Surah list
          Expanded(
           child: ListView.separated(
            // shrinkWrap: true,
            // physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) => Padding
            (padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Divider(
              color: Colors.grey.withOpacity(.5),
              ),
            ),
            itemCount: widget.surahJsonData.length,
            itemBuilder: (context, index) {
              int id = index + 1;
              String surahName = widget.surahJsonData[index]["englishName"];
              String surahNameEnglishTranslated = widget.surahJsonData[index]["englishNameTranslation"];
              int surahNumber = widget.surahJsonData[index]["number"];
              int ayahCount = getVerseCount(id);

              return Padding(
                padding: const EdgeInsets.all(0.0),
               
                    child: ListTile(
                      leading: SizedBox(
                        width: 45,
                        height: 45,
                        
                        child: Center(
                          child: Text(
                            surahNumber.toString(),
                            style: const TextStyle(
                              color: Color.fromARGB(255, 241, 198, 58)
                            )
                          ),
                        ),
                      ),

                      minVerticalPadding: 0,
                      title: SizedBox(
                        width: 90,
                        child: Row(
                          children: [
                            Text(
                              surahName,
                              style: const TextStyle(
                                color: Colors.blue,
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      subtitle: Text(
                        "$surahNameEnglishTranslated ($ayahCount)",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.withOpacity(.8),
                          ),
                      ),
                      
                      onTap: () async {},
                    ),

                );
            },

          ),
          ),
        ],
        )
      );
  }
}