import 'package:evening_stat/components/night-options/statistics.dart';
import 'package:evening_stat/models/league_model.dart';
import 'package:evening_stat/providers/main_api_provider.dart';
import 'package:evening_stat/providers/saved_data_provider.dart';
import 'package:evening_stat/providers/sound_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Over extends StatefulWidget {
  const Over({Key? key}) : super(key: key);

  @override
  State<Over> createState() => _OverState();
}

class _OverState extends State<Over> {
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

  @override
  void initState() {
    initVars();
    Provider.of<MainApi>(context, listen: false).getOvers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                    value: selectedLeague,
                    items: leagueItems.map((LeagueModel value) {
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
                      setState(() {
                        selectedLeague = newValue!;
                      });
                      context.read<MainApi>().getOversAtDropdownChanged(selectedLeague.id);
                    },
                    underline: const SizedBox(),
                  ),
                ),
              ),
            )),
        body: context.read<MainApi>().apiState == ApiState.loading
            ? const Center(
                child: CircularProgressIndicator(
                  color: primaryLightColor,
                ),
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  children: [
                    Expanded(
                        child: context.watch<MainApi>().apiState ==
                                ApiState.loading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: primaryLightColor,
                                ),
                              )
                            : ListView.builder(
                                itemCount:
                                    context.watch<MainApi>().overs.length,
                                itemBuilder: (context, index) =>
                                    GestureDetector(
                                      onTap: () {
                                        // print('index');
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Statistics(
                                                        context
                                                            .watch<MainApi>()
                                                            .overs[index]
                                                            .leagueId,
                                                        context
                                                            .watch<MainApi>()
                                                            .overs[index]
                                                            .gameId)));
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 24, right: 24, top: 24),
                                        decoration: const BoxDecoration(
                                            color: primaryDark,
                                            borderRadius: BorderRadius.only(
                                              bottomRight:
                                                  Radius.circular(20.0),
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    context
                                                        .watch<MainApi>()
                                                        .overs[index]
                                                        .date,
                                                    style: const TextStyle(
                                                        color: whiteColor,
                                                        fontSize: 12.0,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                  Text(
                                                    context
                                                        .watch<MainApi>()
                                                        .overs[index]
                                                        .time,
                                                    style: const TextStyle(
                                                        color: whiteColor,
                                                        fontSize: 12.0,
                                                        decoration:
                                                            TextDecoration
                                                                .none),
                                                  ),
                                                  Icon(
                                                    Icons.star,
                                                    size: 24,
                                                    color: context
                                                            .watch<MainApi>()
                                                            .overs[index]
                                                            .isFavorite
                                                        ? Colors.white
                                                        : Colors.grey,
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 15,
                                                  bottom: 15),
                                              decoration: const BoxDecoration(
                                                  color: primaryLightColor,
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20.0),
                                                    bottomLeft:
                                                        Radius.circular(20.0),
                                                  )),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            bottom: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          context
                                                              .watch<MainApi>()
                                                              .overs[index]
                                                              .teamHome,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                        Text(
                                                          context
                                                              .watch<MainApi>()
                                                              .overs[index]
                                                              .teamHomePoints,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
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
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 5.0),
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          context
                                                              .watch<MainApi>()
                                                              .overs[index]
                                                              .teamAway,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                        Text(
                                                          context
                                                              .watch<MainApi>()
                                                              .overs[index]
                                                              .teamAwayPoints,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: const TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.white,
                                                              decoration:
                                                                  TextDecoration
                                                                      .none),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )))
                  ],
                ),
              ));
  }
}
