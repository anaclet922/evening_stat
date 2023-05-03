import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class MySound with ChangeNotifier{

  bool? isSoundOn = true;
  String? defaultLeagueId;
  final bgPlayer = AudioPlayer();

  void btnPressedSound() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isSoundOn = prefs.getBool('isSoundOn') ?? true;
    if(isSoundOn as bool) {
      AudioPlayer().play(AssetSource('sound_button.mp3'));
    }
  }

  void playBackgroundSound() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isSoundOn = prefs.getBool('isSoundOn') ?? true;
    if(isSoundOn as bool) {
      bgPlayer.play(AssetSource('sound_background.mp3'));
      bgPlayer.setReleaseMode(ReleaseMode.loop);
    }
  }

  void stopBackgroundSound() async{
    bgPlayer.stop();
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSoundOn', false);
  }

  void apiFetchedSound() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isSoundOn = prefs.getBool('isSoundOn') ?? true;
    if(isSoundOn as bool) {
      AudioPlayer().play(AssetSource('sound_after_changes.mp3'));
    }
  }

}