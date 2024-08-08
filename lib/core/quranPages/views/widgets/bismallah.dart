import 'package:flutter/material.dart';

class Basmallah extends StatefulWidget {

   Basmallah({super.key});

  @override
  State<Basmallah> createState() => _BasmallahState();
}

class _BasmallahState extends State<Basmallah> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(width: screenSize.width,
      child: Padding(
        padding: EdgeInsets.only(
            left: (screenSize.width * .2),
            right: (screenSize.width * .2),
            top: 
            8,
            bottom: 2
            ),
        child:
    // Text("115",
    // textAlign: TextAlign.center,
    // style: TextStyle(
    //   color: primaryColors[widget.index],
    //   fontFamily: "arsura",fontSize: 40.sp
    // ),)     
      Image.asset(
          "assets/images/Basmala.png",
          color: Color(0xff443F42).withOpacity(.9),
          width: MediaQuery.of(context).size.width*.4,
        ),
      ),
    );
  }
}