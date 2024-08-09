import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quran/quran.dart' as quran;
import 'package:quran_app/core/quranPages/views/widgets/bismallah.dart';

class QuranPage extends StatefulWidget {
  int pageNumber;
  var surahJsonData;
  final surahNumber;
   QuranPage({
    Key? key,
    required this.pageNumber,
    required this.surahJsonData,
    required this.surahNumber
  });

  
  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  late PageController _pageController;
  // late ScrollController _scrollController;
  int index = 0;
  String selectedSpan = "";
  List<GlobalKey> richTextKeys = List.generate(
    604, // Replace with the number of pages in your PageView
    (_) => GlobalKey(),
  );

   @override
  void initState() {
    // print(widget.pageNumber);
    setState(() {
      index = widget.pageNumber;
    });
    // _pageController = PageController(initialPage: index);
    // Wakelock.enable();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _pageController = PageController(initialPage: index);
    super.initState();
  }
@override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Wakelock.disable();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
        // body: Center(child: Text("sss"),)
      body: PageView.builder(
        reverse: true,
        scrollDirection: Axis.horizontal,
        // onPageChanged: (p) => {
        //   index = p
        // },
       controller: _pageController,
        // controller: _pageController,
        itemCount: quran.totalPagesCount+1,
        itemBuilder: (context, index) {
          return Container(
              child: Scaffold(
                resizeToAvoidBottomInset: false,
                backgroundColor: Colors.transparent,
                body: SafeArea(
                  child: Padding(
                    padding: EdgeInsets.only(right: 12, left: 12),
                    child: SingleChildScrollView(
                      // controller: _scrollController,
                      child: Column(
                        children: [
                          SizedBox(
                            width: screenSize.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: (screenSize.width * .27),
                                  child: Row(
                                    children: [
                                      IconButton(
                                        onPressed: (){
                                          Navigator.pop(context);
                                        },
                                        icon: const Icon(
                                          Icons.arrow_back_ios,
                                          size: 24,
                                        ), 
                                      ),
                                      Text(
                                         widget.surahJsonData[quran.getPageData(index)[0]["surah"]-1]['name'],
                                        // pageIndex.toString(),
                                         style: const TextStyle(
                                          fontFamily: "Taha", fontSize: 18
                                         ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  color: Colors.orange.withOpacity(.5),
                                  height: 20,
                                  width: 120,
                                  child: Center(
                                    child: Text(
                                      "pages $index",
                                      style: const TextStyle(
                                        fontSize: 12
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),

                        if ((index == 1 || index == 2))
                          SizedBox(
                            height: (screenSize.height * .15),
                          ),
                          const SizedBox(
                            height: 8,
                          ),

                          // Verses widget
                          Directionality(
                            textDirection: TextDirection.rtl,
                             child: Padding(
                              padding: const EdgeInsets.all(0.0),
                              child: SizedBox(

                                width: double.infinity,
                                
                                child: RichText(

                                  key: richTextKeys[index-1],
                                  textDirection: TextDirection.rtl,
                                  textAlign: TextAlign.center,
                                  softWrap: true,
                                  locale: const Locale("ar"), 
                                  text: TextSpan(
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 26,
                                    ),
                                    children: quran.getPageData(index).expand((e) {
                                      List<InlineSpan> spans = [];
                                      for (var i = e["start"]; i <= e["end"]; i++){
                                        
                                        if(i == 1){
                                          spans.add(
                                            
                                            WidgetSpan(
                                            child: SizedBox(
                                              height: 50,
                                              child: Stack(
                                                children: [
                                                  Center(
                                                    child: Image.asset(
                                                      "assets/images/888-02.png",
                                                      width: MediaQuery.of(context).size.width,
                                                      height: 50,
                                                    ),
                                                    
                                                  ),
                                                  Center(
                                                    child: Text(
                                                      "${widget.surahJsonData[e['surah']-1]['name']}",
                                                      style: TextStyle(
                                                        fontSize: 20
                                                      ),
                                                      ),
                                                  )
                                                ],
                                              ),
                                            )
                                            
                                           
                                            ));
                                        
                                          if (index != 187 && index != 1 ) {
                                            spans.add(WidgetSpan(
                                            child: Basmallah(),
                                          ));
                                          }
                                          // Surah tawbah without Basmalah
                                          if (index == 187 ) {
                                            spans.add(WidgetSpan(
                                            child: SizedBox(
                                              height: 5,
                                            ),
                                          ));
                                          }                   
                                      }
                                    
                                        
                                        // Verses
                                        spans.add(TextSpan(
                                          text: i == e["start"]
                                          ? "${quran.getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(0, 1)}\u200A${quran.getVerseQCF(e["surah"], i).replaceAll(" ", "").substring(1)}"
                                          : quran.getVerseQCF(e["surah"], i).replaceAll(' ', ''),
                                      // quran.getVerseQCF(e["surah"], i, verseEndSymbol: true)
                                          style: TextStyle(
                                            color: Colors.black,
                                            height: (index == 1 || index == 2) ? 2 : 1.80,
                                            letterSpacing: 0,
                                            wordSpacing: 0,
                                            fontFamily:
                                              "QCF_P${index.toString().padLeft(3, "0")}",
                                            fontSize: index == 1 || index ==2 ? 28.5 : 24.3,
                                          )
                                        ));
                                      }
                             
                                    return spans;
                                    }).toList()
                                  ),
                                ),
                              ),
                             ),
                          ),

                     
                        ],
                      ),
                    )
                    )
                  ),
              ),
          );
        },
      ),
    );
  }
}