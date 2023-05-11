// import 'package:audioplayers/audioplayers.dart';
import 'package:evening_stat/utilis/helpers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SaveData with ChangeNotifier{

  int leagueSaved = 0;
  bool soundSaved = true;
  int currentSliderValue = 1;
  List<String> timeRange = ['06:00PM', '06:00AM'];
  bool isNight = false;


  void initSavedData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    leagueSaved = prefs.getInt('defaultLeague') ?? 0;
    soundSaved = prefs.getBool('isSoundOn') ?? true;
    currentSliderValue = prefs.getInt('defaultTimer') ?? 1;
    timeRange = prefs.getStringList('timeRange') ?? ['06:00PM', '06:00AM'];
  }

  Future<void> saveTimeRange(int time) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String startTime = '06:00PM';
    if(time > 12){
      time = time - 12;
      startTime = time < 10 ? '0${time.toString()}:00PM' : '${time.toString()}:00PM';
    }else{
      startTime = time < 10 ? '0${time.toString()}:00AM' : '${time.toString()}:00AM';
    }
    List<String> timeRange = [startTime, '06:00AM'];
    prefs.setStringList('timeRange', timeRange);
    prefs.setInt('defaultTimer', time);
    // print(timeRange);
    checkTimeRange();
    notifyListeners();
  }

  Future<void> checkTimeRange() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    timeRange = prefs.getStringList('timeRange') ?? ['06:00PM', '06:00AM'];
    if(checkTimeRangeStatus(timeRange[0], timeRange[1])){
      isNight = true;
    }else{
      isNight = false;
    }
    // print('time change checked');
    notifyListeners();
  }



}