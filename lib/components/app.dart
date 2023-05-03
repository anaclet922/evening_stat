import 'package:evening_stat/components/night-options/home.dart';
import 'package:evening_stat/components/night-options/interest.dart';
import 'package:evening_stat/components/position/home.dart';
import 'package:evening_stat/components/schedule/home.dart';
import 'package:evening_stat/components/option/home.dart';
import 'package:evening_stat/components/info/home.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:evening_stat/utilis/helpers.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatefulWidget {


  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<Widget> tabs = [
    const Position(),
    const Schedule(),
    const Option(),
    const Info(),
  ];


  List<Widget> tabs2 = [
    const PositionNight(),
    const Interests(),
    const Option(),
    const Info(),
  ];
  final String title = '';

  int navBtn = 1;

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    if(checkTimeRangeStatus('06:00PM', '06:00AM')){
      navBtn = 2;
      // print('nijoro');
    }

    return CupertinoTabScaffold(
      backgroundColor: primaryColor,
      tabBar: CupertinoTabBar(
        backgroundColor: primaryColor,
        items: <BottomNavigationBarItem>[
          navBtn == 1 ?
          BottomNavigationBarItem(
              icon: Image.asset("assets/tournament.png", width: 24),
              label: 'Position',
              activeIcon:  Image.asset("assets/tournament_active.png", width: 24)
          ) :
          BottomNavigationBarItem(
              icon: Image.asset("assets/over.png", width: 24),
              label: 'Over',
              activeIcon:  Image.asset("assets/over_active.png", width: 24)
          ),
          navBtn == 1?
          BottomNavigationBarItem(
              icon:  Image.asset("assets/schedule.png", width: 24),
              label: 'Schedule',
              activeIcon:  Image.asset("assets/schedule_active.png", width: 24)
          ) :
          BottomNavigationBarItem(
              icon:  Image.asset("assets/interest.png", width: 24),
              label: 'Interest',
              activeIcon:  Image.asset("assets/interest_active.png", width: 24)
          ),
          BottomNavigationBarItem(
              icon:  Image.asset("assets/gear.png", width: 24),
              label: 'Option',
              activeIcon:  Image.asset("assets/gear_active.png", width: 24)
          ),
          BottomNavigationBarItem(
              icon:  Image.asset("assets/info.png", width: 24),
              label: 'Info',
              activeIcon:  Image.asset("assets/info_active.png", width: 24)
          ),
        ],
      ),
      tabBuilder: (BuildContext context, int index) {
        return CupertinoTabView(
          builder: (BuildContext context) {
            // if(navBtn == 2 && index == 0){
            //   return tabs[4];
            // }else if(navBtn == 2 && index == 1){
            //   return tabs[5];
            // }
            return navBtn == 1 ? tabs[index] : tabs2[index];
          },
        );
      },
    );
  }
}
