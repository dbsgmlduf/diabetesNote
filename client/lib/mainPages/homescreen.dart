import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget{
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Homescreen>{
  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
      child: Text("홈스크린입니다."),
    );
  }
}