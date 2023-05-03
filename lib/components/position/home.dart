import 'dart:async';

import 'package:evening_stat/components/position/wating_screen.dart';
import 'package:evening_stat/providers/sound_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:evening_stat/utilis/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Position extends StatefulWidget {
  const Position({Key? key}) : super(key: key);

  @override
  State<Position> createState() => _PositionState();
}

class _PositionState extends State<Position> {

  String bgImage = '';

  countDown(){
    var duration = const Duration(seconds: 5);
    return Timer(duration, route);
  }

  route() {
    context.read<MySound>().apiFetchedSound();
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => const WaitingScreen()
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


    if(checkTimeRangeStatus('06:00AM', '12:00PM')){
      bgImage = 'hello-background-1.png';
    }else if(checkTimeRangeStatus('12:00PM', '06:00PM')){
      bgImage = 'hello-background-2.png';
    }else{
      bgImage = 'hello-background-3.png';
    }

    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle:  Text(
          'Position',
          style: TextStyle(
              color: whiteColor
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: Image.asset("assets/$bgImage").image,
              fit: BoxFit.cover,
            )),
        child: Container(
          decoration: const BoxDecoration(color: primaryHalfColor),
        ),
      )
    );
  }
}
