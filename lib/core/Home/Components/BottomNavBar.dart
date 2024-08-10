import 'package:flutter/material.dart';
import 'package:quran_app/constants.dart';
import 'package:quran_app/core/Home/Home.dart';
import 'package:quran_app/core/Qiblah/Qiblah.dart';
import 'package:quran_app/core/quranPages/views/surah_list.dart';
import 'package:quran_app/enums.dart';

class BottomNavbar extends StatelessWidget {
  final MenuState selectedMenu;
  var  surahJsonData;
  // final Function(MenuState) onMenuSelected;

   BottomNavbar({super.key,required this.selectedMenu, required this.surahJsonData});

  @override
  Widget build(BuildContext context) {
    final Color inActiveIconColor = Color(0xFFB6B6B6);
    return Container(
      
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, -15),
            blurRadius: 20,
            color: Color(0xFFDADADA).withOpacity(0.15),
          ),
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: SafeArea(
        top: false,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              IconButton(
                icon: Icon(Icons.home,
                  color: MenuState.home == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,
                ),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen()))
    
              ),
              IconButton(
                icon: Icon(Icons.directions,
                color: MenuState.qiblah == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => Qiblah())),
                
              ),
              IconButton(
                icon: Icon(Icons.menu_book, 
                color: MenuState.quran == selectedMenu
                      ? kPrimaryColor
                      : inActiveIconColor,),
                onPressed: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SurahList(surahJsonData: surahJsonData,))),

              ),
              // IconButton(
              //   icon: SvgPicture.asset(
              //     "assets/icons/User Icon.svg",
              //     color: MenuState.profile == selectedMenu
              //         ? kPrimaryColor
              //         : inActiveIconColor,
              //   ),
              //   onPressed: () =>
              //       Navigator.pushNamed(context, ProfileScreen.routeName),
              // ),
            ],
          )
      ),
    );
  }
}