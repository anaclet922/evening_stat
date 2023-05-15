import 'dart:async';

import 'package:evening_stat/components/position/position_main.dart';
import 'package:evening_stat/providers/main_api_provider.dart';
import 'package:evening_stat/providers/saved_data_provider.dart';
import 'package:evening_stat/providers/sound_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
// import 'package:evening_stat/utilis/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class WaitingScreen extends StatefulWidget {
  const WaitingScreen({Key? key}) : super(key: key);

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {

  bool isDay = true;

  countDown(){
    var duration = const Duration(seconds: 60); //change it to 60 seconds
    return Timer(duration, route);
  }

  route() {
    context.read<MySound>().apiFetchedSound();
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const PositionMain()
    )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    countDown();
  }

  @override
  Widget build(BuildContext context) {


    // if(!checkTimeRangeStatus('06:00AM', '12:00PM')){
    //   isDay = !isDay;
    // }

    //fetch api
    context.read<SaveData>().initSavedData();
    context.read<MainApi>().getLeaguePosition(context);
    context.read<MainApi>().getSchedules();
    context.read<MainApi>().getOvers();
    context.read<MainApi>().getInterests();
    // print('All functions run');

    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: Text(
          '',
          style: TextStyle(color: whiteColor),
        ),
      ),
      child: context.watch<SaveData>().isNight ? nightWidget() : dayWidget()
    );
  }

  Widget dayWidget(){
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: waitingDayColor
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 62),
            child: Image.asset('assets/sun.png', width: 192,),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/cloud.png', height: 131,),
                    ],
                  )
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/cloud_small.png', height: 73,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Image.asset('assets/cloud_medium.png', height: 119,),
                      )
                    ],
                  )
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Wait 1 minute, changes are happening',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 24.0,
                    decoration: TextDecoration.none
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget nightWidget(){
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
          color: waitingNightColor
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 62),
            child: Stack(
              children: [
                Positioned(
                    top: 0,
                    child: Image.asset('assets/stars.png', width: 360,)
                ),
                Positioned(
                   bottom: 0,
                    child: Image.asset('assets/stars_1.png', width: 360,)
                ),
                Center(child: Image.asset('assets/moon.png', width: 192,)),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset('assets/cloud_night.png', height: 131,),
                    ],
                  )
              ),
              Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/cloud_night_small.png', height: 73,),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Image.asset('assets/cloud_night_medium.png', height: 119,),
                      )
                    ],
                  )
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Text(
                'Wait 1 minute, changes are happening',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: whiteColor,
                    fontSize: 24.0,
                    decoration: TextDecoration.none
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
