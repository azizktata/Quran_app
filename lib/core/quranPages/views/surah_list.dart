import 'package:flutter/material.dart';
import 'package:quran/quran.dart';
import 'package:quran_app/core/quranPages/views/quran_page.dart';
import 'package:quran_app/models/surah.dart';

class SurahList extends StatefulWidget {

  final surahJsonData; 
  const SurahList({super.key, required this.surahJsonData});

  @override
  State<SurahList> createState() => _SurahListState();
}

class _SurahListState extends State<SurahList> {

  var surahList = [];
  List<Surah> filteredSurahList = [];
  @override
  void initState() {
    // fetchSurahs();
    setState(() {
      surahList = widget.surahJsonData;
    });
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child:TextField(
              controller: textEditingController,
              onChanged: (value) {
                if (value == ""){
                  setState(() {
                    surahList = widget.surahJsonData;
                  });
                } else {
                   setState(() {
                    surahList = widget.surahJsonData.where((surah){
                      final surahName = surah['englishName'].toLowerCase();
                      final surahNameArabic = getSurahNameArabic(surah['number']);
                      return surahName.contains(value.toLowerCase()) || surahNameArabic.contains(value.toLowerCase());
                    }).toList();
                     });
                }

              },
              decoration: InputDecoration(
              border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
              borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200], // Light grey background
              hintText: 'Seach surah',
              hintStyle: TextStyle(color: Colors.grey[600]),
              prefixIcon: Icon(Icons.search, color: Colors.grey[600]), // Optional icon
              contentPadding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        // Optionally, you can add a suffixIcon or a counter text
              ),
            ), 
          ),
        

         
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
            itemCount: surahList.length,
            itemBuilder: (context, index) {
              int id = index + 1;
              String surahName = surahList[index]["englishName"];
              String surahNameArabic = surahList[index]["name"];
              int surahNumber = surahList[index]["number"];
              int ayahCount = getVerseCount(surahNumber);
              String revelationType = surahList[index]["revelationType"];
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
                        "$revelationType - ($ayahCount) - $surahNameArabic",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.withOpacity(.8),
                          ),
                      ),
                      
                      onTap: () async {
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=> QuranPage(pageNumber: getPageNumber(surahNumber, 1), surahJsonData: widget.surahJsonData,surahNumber: surahNumber) ));
                      },
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