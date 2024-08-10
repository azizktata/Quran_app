import 'package:flutter/material.dart';

class Qiblah extends StatefulWidget {
  const Qiblah({super.key});

  @override
  State<Qiblah> createState() => _QiblahState();
}

class _QiblahState extends State<Qiblah> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("Qiblah"),),
    );
  }
}