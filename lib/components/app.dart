import 'dart:async';
import 'package:evening_stat/components/position/home.dart';
import 'package:evening_stat/components/schedule/home.dart';
import 'package:evening_stat/components/option/home.dart';
import 'package:evening_stat/components/info/home.dart';
import 'package:evening_stat/providers/saved_data_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {


  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home>  with WidgetsBindingObserver {

  List<Widget> tabs = [
    const Position(),
    const Schedule(),
    const Option(),
    const Info(),
  ];

  //
  // List<Widget> tabs2 = [
  //   const PositionNight(),
  //   const Interests(),
  //   const Option(),
  //   const Info(),
  // ];
  //

  final String title = '';

  int navBtn = 1;

  late Timer balanceTimer;

  @override
  void initState() {
    balanceTimer = Timer.periodic(const Duration(seconds: 5),
            (Timer t) {
          if(mounted){
            try {
              Provider.of<SaveData>(context, listen: false).checkTimeRange();
            } on Exception {
              rethrow;
            }
          }
        }
    );
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }


  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // if(checkTimeRangeStatus('06:00PM', '06:00AM')){
      //   navBtn = 2;
      // }
      Provider.of<SaveData>(context, listen: false).checkTimeRange();
    }
  }

  @override
  Widget build(BuildContext context) {

    // if(checkTimeRangeStatus('06:00PM', '06:00AM')){
    //   navBtn = 2;
    // }

    return CupertinoTabScaffold(
      backgroundColor: primaryColor,
      tabBar: CupertinoTabBar(
        backgroundColor: primaryColor,
        items: <BottomNavigationBarItem>[

          BottomNavigationBarItem(
              icon: context.watch<SaveData>().isNight ? Image.asset("assets/over.png", width: 24) : Image.asset("assets/tournament.png", width: 24),
              label: context.watch<SaveData>().isNight ? 'Over' : 'Position',
              activeIcon:  context.watch<SaveData>().isNight ? Image.asset("assets/over_active.png", width: 24) : Image.asset("assets/tournament_active.png", width: 24)
          ),

          BottomNavigationBarItem(
              icon:  context.watch<SaveData>().isNight ? Image.asset("assets/interest.png", width: 24) : Image.asset("assets/schedule.png", width: 24),
              label: context.watch<SaveData>().isNight ? 'Interest' : 'Schedule',
              activeIcon:  context.watch<SaveData>().isNight ? Image.asset("assets/interest_active.png", width: 24) : Image.asset("assets/schedule_active.png", width: 24)
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
            return tabs[index];
          },
        );
      },
    );
  }
}
