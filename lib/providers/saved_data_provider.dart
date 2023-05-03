// import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SaveData with ChangeNotifier{

  int leagueSaved = 0;
  bool soundSaved = true;
  int currentSliderValue = 1;

  void initSavedData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    leagueSaved = prefs.getInt('defaultLeague') ?? 0;
    soundSaved = prefs.getBool('isSoundOn') ?? true;
    currentSliderValue = prefs.getInt('defaultTimer') ?? 1;
  }


}