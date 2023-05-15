// import 'package:evening_stat/components/schedule/statistics.dart';
// import 'package:evening_stat/components/schedule/preview.dart';
import 'dart:async';

import 'package:evening_stat/models/league_model.dart';
import 'package:evening_stat/providers/main_api_provider.dart';
import 'package:evening_stat/providers/saved_data_provider.dart';
import 'package:evening_stat/providers/sound_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:evening_stat/utilis/notification.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key? key}) : super(key: key);

  @override
  State<Schedule> createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
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
  late LeagueModel selectedLeague;

  void initVars() {
    if (Provider.of<SaveData>(context, listen: false).leagueSaved > 14) {
      for (int i = 0; i < leagueItems.length; i++) {
        if (leagueItems[i].id ==
            Provider.of<SaveData>(context, listen: false).leagueSaved) {
          selectedLeague = leagueItems[i];
          break;
        }
      }
    } else {
      selectedLeague = leagueItems[
          Provider.of<SaveData>(context, listen: false).leagueSaved];
    }
  }


  late Timer balanceTimer2;

  @override
  void initState() {
    initVars();
    // if (Provider.of<SaveData>(context, listen: false).isNight) {
    //   Provider.of<MainApi>(context, listen: false).getInterests();
    // } else {
    //   Provider.of<MainApi>(context, listen: false).getSchedules();
    // }
    balanceTimer2 = Timer.periodic(const Duration(seconds: 120),
            (Timer t) {
          if(mounted){
            try {
              Provider.of<MainApi>(context, listen: false).getInterests();
            } on Exception {
              rethrow;
            }
          }
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<SaveData>().isNight
        ? interest(context)
        : schedule(context);
  }

  Widget schedule(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
            backgroundColor: primaryColor,
            title: Container(
              height: 30.0,
              width: double.infinity,
              margin: const EdgeInsets.only(
                  right: 20.0, left: 20, top: 10, bottom: 10),
              padding: const EdgeInsets.only(left: 20.0, right: 20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22.5),
                  color: primaryColor,
                  border: Border.all(width: 2, color: primaryLightColor)),
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  width: double.infinity,
                  child: DropdownButton(
                    isExpanded: true,
                    borderRadius: BorderRadius.circular(23),
                    // alignment: AlignmentDirectional.center,
                    dropdownColor: primaryColor,
                    icon: const Icon(
                      Icons.keyboard_arrow_down,
                      color: whiteColor,
                    ),
                    value: context.watch<SaveData>().selectedLeague,
                    items: context.read<SaveData>().leagueItems.map((LeagueModel value) {
                      return DropdownMenuItem(
                          // alignment: AlignmentDirectional.bottomCenter,
                          value: value,
                          child: Text(
                            value.leagueName,
                            style: const TextStyle(color: whiteColor),
                          ));
                    }).toList(),
                    onChanged: (LeagueModel? newValue) {
                      context.read<MySound>().btnPressedSound();
                      // setState(() {
                      //   selectedLeague = newValue!;
                      // });
                      context.read<SaveData>().changeSelectedLeague(newValue!);
                      EasyLoading.show(status: 'loading...');
                      context.read<MainApi>().getSchedules(newValue!.id);
                      context.read<MainApi>().getLeaguePosition(context, newValue!.id);
                    },
                    underline: const SizedBox(),
                  ),
                ),
              ),
            )),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                  child: ListView.builder(
                      itemCount: context.watch<MainApi>().schedules.length,
                      itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 24),
                            decoration: const BoxDecoration(
                                color: primaryLightColor,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, right: 20, top: 7, bottom: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        context
                                            .watch<MainApi>()
                                            .schedules[index]
                                            .date,
                                        style: const TextStyle(
                                            color: whiteColor,
                                            fontSize: 12.0,
                                            decoration: TextDecoration.none),
                                      ),
                                      Text(
                                        context
                                            .watch<MainApi>()
                                            .schedules[index]
                                            .time,
                                        style: const TextStyle(
                                            color: whiteColor,
                                            fontSize: 12.0,
                                            decoration: TextDecoration.none),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<MySound>()
                                              .btnPressedSound();
                                          context
                                              .read<MainApi>()
                                              .addRemoveInterests(
                                                context,
                                                index,
                                                Provider.of<MainApi>(context,
                                                        listen: false)
                                                    .schedules[index]
                                                    .gameId,
                                                Provider.of<MainApi>(context,
                                                        listen: false)
                                                    .schedules[index]
                                                    .isFavorite,
                                              );
                                          if (!(Provider.of<MainApi>(context,
                                                  listen: false)
                                              .schedules[index]
                                              .isFavorite)) {
                                            mySuccessSnackBar(context,
                                                Icons.check, "Interest Added!");
                                          } else {
                                            mySuccessSnackBar(
                                                context,
                                                Icons.check,
                                                "Interest removed!");
                                          }
                                        },
                                        child: Icon(
                                          Icons.star,
                                          size: 24,
                                          color: context
                                                  .watch<MainApi>()
                                                  .schedules[index]
                                                  .isFavorite
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    EasyLoading.show(status: 'loading...');
                                    context.read<MainApi>().getHeadTwoHeadData(
                                        context,
                                        Provider.of<MainApi>(context,
                                                listen: false)
                                            .schedules[index]
                                            .leagueId,
                                        Provider.of<MainApi>(context,
                                                listen: false)
                                            .schedules[index]
                                            .gameId);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 15,
                                        bottom: 15),
                                    decoration: const BoxDecoration(
                                        color: primaryLightLightColor,
                                        borderRadius: BorderRadius.only(
                                          bottomRight: Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                        )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.only(
                                              top: 11, bottom: 11),
                                          child: Text(
                                            '${context.watch<MainApi>().schedules[index].teamHome} - ${context.watch<MainApi>().schedules[index].teamAway}',
                                            style: const TextStyle(
                                                fontSize: 16.0,
                                                color: primaryColor,
                                                decoration:
                                                    TextDecoration.none),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Container(
                                                  width: 70,
                                                  decoration: const BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      5.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 2,
                                                          bottom: 2),
                                                  child: const Center(
                                                    child: Text(
                                                      'x1',
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 14.0,
                                                          decoration:
                                                              TextDecoration
                                                                  .none),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 70,
                                                  decoration: const BoxDecoration(
                                                      color: primaryLightColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 2,
                                                          bottom: 2),
                                                  child: Center(
                                                    child: Text(
                                                      context
                                                          .watch<MainApi>()
                                                          .schedules[index]
                                                          .oddHome,
                                                      style: const TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 14.0,
                                                          decoration:
                                                              TextDecoration
                                                                  .none),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 70,
                                                  decoration:
                                                      const BoxDecoration(
                                                          color: primaryColor,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          5.0))),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 2,
                                                          bottom: 2),
                                                  child: const Center(
                                                    child: Text(
                                                      'x',
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 14.0,
                                                          decoration:
                                                              TextDecoration
                                                                  .none),
                                                    ),
                                                  ),
                                                ),
                                                // Container(
                                                //   width: 70,
                                                //   decoration: const BoxDecoration(
                                                //       color: primaryLightColor,
                                                //       borderRadius:
                                                //           BorderRadius.only(
                                                //               bottomLeft: Radius
                                                //                   .circular(
                                                //                       5.0),
                                                //               bottomRight: Radius
                                                //                   .circular(
                                                //                       5.0))),
                                                //   padding:
                                                //       const EdgeInsets.only(
                                                //           left: 20,
                                                //           right: 20,
                                                //           top: 2,
                                                //           bottom: 2),
                                                //   child: Center(
                                                //     child: Text(
                                                //       context
                                                //           .watch<MainApi>()
                                                //           .schedules[index]
                                                //           .oddX,
                                                //       style: const TextStyle(
                                                //           color: whiteColor,
                                                //           fontSize: 14.0,
                                                //           decoration:
                                                //               TextDecoration
                                                //                   .none),
                                                //     ),
                                                //   ),
                                                // )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Container(
                                                  width: 70,
                                                  decoration: const BoxDecoration(
                                                      color: primaryColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              topRight: Radius
                                                                  .circular(
                                                                      5.0),
                                                              topLeft: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 2,
                                                          bottom: 2),
                                                  child: const Center(
                                                    child: Text(
                                                      'x2',
                                                      style: TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 14.0,
                                                          decoration:
                                                              TextDecoration
                                                                  .none),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: 70,
                                                  decoration: const BoxDecoration(
                                                      color: primaryLightColor,
                                                      borderRadius:
                                                          BorderRadius.only(
                                                              bottomLeft: Radius
                                                                  .circular(
                                                                      5.0),
                                                              bottomRight: Radius
                                                                  .circular(
                                                                      5.0))),
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20,
                                                          right: 20,
                                                          top: 2,
                                                          bottom: 2),
                                                  child: Center(
                                                    child: Text(
                                                      context
                                                          .watch<MainApi>()
                                                          .schedules[index]
                                                          .oddAway,
                                                      style: const TextStyle(
                                                          color: whiteColor,
                                                          fontSize: 14.0,
                                                          decoration:
                                                              TextDecoration
                                                                  .none),
                                                    ),
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )))
            ],
          ),
        ));
  }

  Widget interest(BuildContext context) {
    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
        centerTitle: true,
        backgroundColor: primaryColor,
        title: const Text(
        'Interests',
        style: TextStyle(color: whiteColor),
    )),
            // Container(
            //   height: 30.0,
            //   width: double.infinity,
            //   margin: const EdgeInsets.only(
            //       right: 20.0, left: 20, top: 10, bottom: 10),
            //   padding: const EdgeInsets.only(left: 20.0, right: 20),
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(22.5),
            //       color: primaryColor,
            //       border: Border.all(width: 2, color: primaryLightColor)),
            //   child: Material(
            //     color: Colors.transparent,
            //     child: Container(
            //       padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            //       width: double.infinity,
            //       child: DropdownButton(
            //         isExpanded: true,
            //         borderRadius: BorderRadius.circular(23),
            //         // alignment: AlignmentDirectional.center,
            //         dropdownColor: primaryColor,
            //         icon: const Icon(
            //           Icons.keyboard_arrow_down,
            //           color: whiteColor,
            //         ),
            //         value: context.watch<SaveData>().selectedLeague,
            //         items: context.read<SaveData>().leagueItems.map((LeagueModel value) {
            //           return DropdownMenuItem(
            //               // alignment: AlignmentDirectional.bottomCenter,
            //               value: value,
            //               child: Text(
            //                 value.leagueName,
            //                 style: const TextStyle(color: whiteColor),
            //               ));
            //         }).toList(),
            //         onChanged: (LeagueModel? newValue) {
            //           context.read<MySound>().btnPressedSound();
            //           // setState(() {
            //           //   selectedLeague = newValue!;
            //           // });
            //           // context.read<MainApi>().getOvers(selectedLeague.id);
            //         },
            //         underline: const SizedBox(),
            //       ),
            //     ),
            //   ),
            // )),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                  child: context.watch<MainApi>().apiState == ApiState.loading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryLightColor,
                          ),
                        )
                      : ListView.builder(
                          itemCount: context.watch<MainApi>().interests.length,
                          itemBuilder: (context, index) => Container(
                            margin: const EdgeInsets.only(
                                left: 24, right: 24, top: 24),
                            decoration: const BoxDecoration(
                                color: primaryDark,
                                borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(20.0),
                                  bottomLeft: Radius.circular(20.0),
                                )),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20,
                                      right: 20,
                                      top: 7,
                                      bottom: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        context
                                            .watch<MainApi>()
                                            .interests[index]
                                            .date,
                                        style: const TextStyle(
                                            color: whiteColor,
                                            fontSize: 12.0,
                                            decoration:
                                                TextDecoration.none),
                                      ),
                                      Text(
                                        context
                                            .watch<MainApi>()
                                            .interests[index]
                                            .time,
                                        style: const TextStyle(
                                            color: whiteColor,
                                            fontSize: 12.0,
                                            decoration:
                                                TextDecoration.none),
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          context
                                              .read<MySound>()
                                              .btnPressedSound();
                                          // addOrRemoveInterest(
                                          //   Provider.of<MainApi>(context, listen: false)
                                          //       .interests[index]
                                          //       .gameId,
                                          //   Provider.of<MainApi>(context, listen: false)
                                          //       .interests[index]
                                          //       .isFavorite,
                                          // );
                                          context
                                              .read<MainApi>()
                                              .removeInterests(
                                                  context,
                                                  Provider.of<MainApi>(
                                                          context,
                                                          listen: false)
                                                      .interests[index]
                                                      .gameId,
                                                  Provider.of<MainApi>(
                                                          context,
                                                          listen: false)
                                                      .interests[index]
                                                      .isFavorite);
                                          mySuccessSnackBar(
                                              context,
                                              Icons.check,
                                              "Interest Removed!");
                                        },
                                        child: const Icon(
                                          Icons.star,
                                          size: 24,
                                          color: Colors.white,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                GestureDetector(
                                  onTap: (){
                                    EasyLoading.show(status: 'loading...');

                                    context.read<MainApi>().getStatisticsData(
                                        context,
                                        Provider.of<MainApi>(context, listen: false)
                                            .interests[index]
                                            .leagueId,
                                        Provider.of<MainApi>(context, listen: false)
                                            .interests[index]
                                            .gameId);
                                    
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20,
                                        right: 20,
                                        top: 15,
                                        bottom: 15),
                                    decoration: const BoxDecoration(
                                        color: primaryLightColor,
                                        borderRadius: BorderRadius.only(
                                          bottomRight:
                                              Radius.circular(20.0),
                                          bottomLeft: Radius.circular(20.0),
                                        )),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                context
                                                    .watch<MainApi>()
                                                    .interests[index]
                                                    .teamHome,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration
                                                            .none),
                                              ),
                                              Text(
                                                context
                                                    .watch<MainApi>()
                                                    .interests[index]
                                                    .teamHomePoints,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration
                                                            .none),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Container(
                                              width: 40,
                                              height: 2,
                                              color: Colors.white,
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: [
                                              Text(
                                                context
                                                    .watch<MainApi>()
                                                    .interests[index]
                                                    .teamAway,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration
                                                            .none),
                                              ),
                                              Text(
                                                context
                                                    .watch<MainApi>()
                                                    .interests[index]
                                                    .teamAwayPoints,
                                                overflow:
                                                    TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration
                                                            .none),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )))
            ],
          ),
        ));
  }

  void addOrRemoveInterest(String gameId, bool isFavorite) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var interests = prefs.getStringList('interests');
    if (isFavorite) {
      //already exists, remove it
      interests?.remove(gameId);
    } else {
      interests?.add(gameId);
    }
    prefs.setStringList('interests', interests ?? ['']);
  }
}
