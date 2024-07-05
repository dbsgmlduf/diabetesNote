import 'package:flutter/material.dart';

class Settingscreen extends StatefulWidget{
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<Settingscreen>{
  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
      child: Text("설정 페이지."),
    );
  }
}