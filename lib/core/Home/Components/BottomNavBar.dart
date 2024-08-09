import 'package:flutter/material.dart';
import 'package:quran_app/constants.dart';
import 'package:quran_app/core/Home/Home.dart';
import 'package:quran_app/core/quranPages/views/surah_list.dart';
import 'package:quran_app/enums.dart';

class BottomNavbar extends StatelessWidget {
  final MenuState selectedMenu;
  final Function(MenuState) onMenuSelected;
  const BottomNavbar({super.key,required this.selectedMenu, required this.onMenuSelected});

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
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: inActiveIconColor,
          currentIndex: MenuState.values.indexOf(selectedMenu),
          onTap: (index) {
            onMenuSelected(MenuState.values[index]);
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.menu_book),
              label: 'Quran',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions),
              label: 'Qiblah',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.mosque_rounded),
              label: 'Prayer Times',
            ),
          ],
        ),
      ),
    );
  }
}