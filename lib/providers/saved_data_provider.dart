// import 'package:audioplayers/audioplayers.dart';
import 'package:evening_stat/models/league_model.dart';
import 'package:evening_stat/utilis/helpers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SaveData with ChangeNotifier{

  final List<LeagueModel> leagueItems = [
    LeagueModel(id: 1328, leagueName: 'British Basketball League'),
    LeagueModel(id: 1923, leagueName: 'Euroleague'),
    LeagueModel(id: 1583, leagueName: 'Italy Lega 1'),
    LeagueModel(id: 1942, leagueName: 'Mexico LNBP'),
    LeagueModel(id: 1915, leagueName: 'Portugal LBP'),
    LeagueModel(id: 262, leagueName: 'El Salvador Liga Mayor'),
    LeagueModel(id: 1780, leagueName: 'Serbia KLS'),
    LeagueModel(id: 1525, leagueName: 'Spain ACB League'),
    LeagueModel(id: 1529, leagueName: 'Spain LEB Oro'),
    LeagueModel(id: 578, leagueName: 'Australia Big V Women'),
    LeagueModel(id: 2005, leagueName: 'China WCBA'),
    LeagueModel(id: 1286, leagueName: 'Czech Republic ZBL Women'),
    LeagueModel(id: 1560, leagueName: 'France LFB Women'),
    LeagueModel(id: 1565, leagueName: 'Italy A1 Women'),
    LeagueModel(id: 1542, leagueName: 'Russia Premier League Women'),
  ];

  int leagueSaved = 0;
  bool soundSaved = true;
  int currentSliderValue = 1;
  List<String> timeRange = ['06:00PM', '06:00AM'];
  bool isNight = false;
  LeagueModel selectedLeague = LeagueModel(id: 1328, leagueName: 'British Basketball League');


  void initSavedData() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    leagueSaved = prefs.getInt('defaultLeague') ?? 0;
    soundSaved = prefs.getBool('isSoundOn') ?? true;
    currentSliderValue = prefs.getInt('defaultTimer') ?? 1;
    timeRange = prefs.getStringList('timeRange') ?? ['06:00PM', '06:00AM'];

    if (leagueSaved > 14) {
      for (int i = 0; i < leagueItems.length; i++) {
        if (leagueItems[i].id == leagueSaved) {
          selectedLeague = leagueItems[i];
          break;
        }
      }
    } else {
      selectedLeague = leagueItems[0];
    }
  }

  Future<void> saveTimeRange(int tTime) async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String startTime = '06:00PM';
    var time = tTime;
    if(time > 12){
      time = time - 12;
      startTime = time < 10 ? '0${time.toString()}:00PM' : '${time.toString()}:00PM';
    }else{
      startTime = time < 10 ? '0${time.toString()}:00AM' : '${time.toString()}:00AM';
    }
    List<String> timeRange = [startTime, '06:00AM'];
    prefs.setStringList('timeRange', timeRange);
    prefs.setInt('defaultTimer', tTime);
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


  Future<void> saveDefaultSettings() async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSoundOn', true);
    prefs.setInt('defaultLeague', 1328);
    prefs.setInt('defaultTimer', 1);

    leagueSaved = 1328;
    currentSliderValue = 1;
    soundSaved = true;

    if (leagueSaved > 14) {
      for (int i = 0; i < leagueItems.length; i++) {
        if (leagueItems[i].id == leagueSaved) {
          selectedLeague = leagueItems[i];
          break;
        }
      }
    } else {
      selectedLeague = leagueItems[0];
    }

    notifyListeners();

  }



  Future<void> setPersonalizedSettings(bool soundOn, int selectedLeagueId, int newSliderValue) async{

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSoundOn', soundOn);
    prefs.setInt('defaultLeague', selectedLeagueId);
    prefs.setInt('defaultTimer', newSliderValue);

    leagueSaved = selectedLeagueId;
    currentSliderValue = newSliderValue;
    soundSaved = soundOn;

    if (leagueSaved > 14) {
      for (int i = 0; i < leagueItems.length; i++) {
        if (leagueItems[i].id == leagueSaved) {
          selectedLeague = leagueItems[i];
          break;
        }
      }
    } else {
      selectedLeague = leagueItems[0];
    }

    notifyListeners();

  }

  Future<void> changeSelectedLeague(LeagueModel newValue) async{
    selectedLeague = newValue;
    notifyListeners();
  }

}