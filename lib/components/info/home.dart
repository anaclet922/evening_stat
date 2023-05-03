import 'package:evening_stat/utilis/constants.dart';
import 'package:flutter/cupertino.dart';

class Info extends StatefulWidget {
  const Info({Key? key}) : super(key: key);

  @override
  State<Info> createState() => _InfoState();
}

class _InfoState extends State<Info> {
  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
      backgroundColor: primaryColor,
      navigationBar:  CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: Text(
          'Info',
          style: TextStyle(
              color: whiteColor
          ),
        ),
      ),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(30.0),
          child: Text(
            'This app will help distribute your viewing time for information on games in different basketball leagues, by making it appear at certain hours. There will be one information in the daytime and another in the evening. And you can change the time interval of the day and evening in the settings of the application.',
            style: TextStyle(
              color: whiteColor,
              fontSize: 20.0,
              decoration: TextDecoration.none
            ),
            textAlign: TextAlign.center,
          ),
        )
      ),
    );
  }
}

