import 'package:evening_stat/models/league_model.dart';
import 'package:evening_stat/providers/main_api_provider.dart';
import 'package:evening_stat/providers/saved_data_provider.dart';
import 'package:evening_stat/providers/sound_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:evening_stat/utilis/notification.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class PositionMain extends StatefulWidget {
  const PositionMain({Key? key}) : super(key: key);

  @override
  State<PositionMain> createState() => _PositionMainState();
}

class _PositionMainState extends State<PositionMain>
    with WidgetsBindingObserver {
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

  // late LeagueModel selectedLeague;

  bool miniInfo = true;

  // void initVars() {
  //   if (Provider.of<SaveData>(context, listen: false).leagueSaved > 14) {
  //     for (int i = 0; i < leagueItems.length; i++) {
  //       if (leagueItems[i].id ==
  //           Provider.of<SaveData>(context, listen: false).leagueSaved) {
  //         selectedLeague = leagueItems[i];
  //         break;
  //       }
  //     }
  //   } else {
  //     selectedLeague = leagueItems[
  //         Provider.of<SaveData>(context, listen: false).leagueSaved];
  //   }
  // }

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    // initVars();
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      context.read<MainApi>().getLeaguePosition(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return context.watch<SaveData>().isNight
        ? over(context)
        : position(context);
  }

  Widget position(BuildContext context) {

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
                    // print(selectedLeague.id);
                    EasyLoading.show(status: 'loading...');
                    context
                        .read<MainApi>()
                        .getLeaguePosition(context, newValue!.id);
                    context
                        .read<MainApi>()
                        .getSchedules(newValue!.id);
                    // print('position: league changed');
                  },
                  underline: const SizedBox(),
                ),
              ),
            )),
        body: Container(
            color: waitingDayColor,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        onTap: () {
                          setState(() {
                            miniInfo = !miniInfo;
                          });
                          context.read<MySound>().btnPressedSound();
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10, right: 20, top: 10),
                          padding: const EdgeInsets.only(left: 2, right: 2),
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          child: miniInfo
                              ? Image.asset('assets/plus.png')
                              : Image.asset('assets/minus.png'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Column(
                      children: [

                        for (var round in context.watch<MainApi>().positions)
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Text(
                                  round.groupName,
                                 style: const TextStyle(
                                   color: whiteColor,
                                   fontWeight: FontWeight.bold
                                 ),
                              ),
                            ),
                            Table(
                              border:
                                  TableBorder.all(color: primaryLightColor, width: 2),
                              children: [
                                TableRow(
                                    decoration:
                                        const BoxDecoration(color: primaryColor),
                                    children: [
                                      const Center(
                                          child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 14.0, bottom: 14.0),
                                        child: Text('Team',
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                                color: whiteColor, fontSize: 12)),
                                      )),
                                      const Center(
                                          child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 14.0, bottom: 14.0),
                                        child: Text('P',
                                            style: TextStyle(
                                                color: whiteColor, fontSize: 12)),
                                      )),
                                      const Center(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: 14.0, bottom: 14.0),
                                          child: Text('W',
                                              style: TextStyle(
                                                  color: whiteColor, fontSize: 12)),
                                        ),
                                      ),
                                      const Center(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: 14.0, bottom: 14.0),
                                          child: Text('L',
                                              style: TextStyle(
                                                  color: whiteColor, fontSize: 12)),
                                        ),
                                      ),
                                      if (!miniInfo)
                                        const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 14.0, bottom: 14.0),
                                            child: Text('G+',
                                                style: TextStyle(
                                                    color: whiteColor, fontSize: 12)),
                                          ),
                                        ),
                                      if (!miniInfo)
                                        const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 14.0, bottom: 14.0),
                                            child: Text('G-',
                                                style: TextStyle(
                                                    color: whiteColor, fontSize: 12)),
                                          ),
                                        ),
                                      const Center(
                                        child: Padding(
                                          padding:
                                              EdgeInsets.only(top: 14.0, bottom: 14.0),
                                          child: Text('Score',
                                              style: TextStyle(
                                                  color: whiteColor, fontSize: 12)),
                                        ),
                                      ),
                                      if (!miniInfo)
                                        const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 14.0, bottom: 14.0),
                                            child: Text('pct(%)',
                                                style: TextStyle(
                                                    color: whiteColor, fontSize: 12)),
                                          ),
                                        ),
                                      if (!miniInfo)
                                        const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 14.0, bottom: 14.0),
                                            child: Text('G+/-',
                                                style: TextStyle(
                                                    color: whiteColor, fontSize: 12)),
                                          ),
                                        ),
                                      if (!miniInfo)
                                        const Center(
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                                top: 14.0, bottom: 14.0),
                                            child: Text('%G+/-',
                                                style: TextStyle(
                                                    color: whiteColor, fontSize: 12)),
                                          ),
                                        ),
                                    ]),
                                for (var row in round.rows)
                                  TableRow(children: [
                                    Container(
                                      width: 120,
                                      padding: const EdgeInsets.all(7.0),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          Image.network(
                                            row.teamImage,
                                            width: 30,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace? stackTrace) {
                                              return Image.asset('assets/ball.png', width: 30,);
                                            },
                                          ),
                                          if (miniInfo)
                                            Text(
                                              row.teamName,
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white, fontSize: 10),
                                            )
                                        ],
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, bottom: 14.0),
                                        child: Text(
                                          row.position.toString(),
                                          style: const TextStyle(
                                              color: whiteColor, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, bottom: 14.0),
                                        child: Text(
                                          row.win.toString(),
                                          style: const TextStyle(
                                              color: whiteColor, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, bottom: 14.0),
                                        child: Text(
                                          row.loss.toString(),
                                          style: const TextStyle(
                                              color: whiteColor, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    if (!miniInfo)
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 14.0, bottom: 14.0),
                                          child: Text(
                                            row.goalsPlus.toString(),
                                            style: const TextStyle(
                                                color: whiteColor, fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    if (!miniInfo)
                                      Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 14.0, bottom: 14.0),
                                          child: Text(
                                            row.goalsMinus.toString(),
                                            style: const TextStyle(
                                                color: whiteColor, fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    Center(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, bottom: 14.0),
                                        child: Text(
                                          row.score.toString(),
                                          style: const TextStyle(
                                              color: whiteColor, fontSize: 12),
                                        ),
                                      ),
                                    ),
                                    if (!miniInfo)
                                      Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, bottom: 14.0),
                                        child: Text(
                                          row.pct.toString(),
                                          style: const TextStyle(
                                              color: whiteColor, fontSize: 12),
                                        ),
                                      )),
                                    if (!miniInfo)
                                      Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, bottom: 14.0),
                                        child: Text(
                                          row.goalDiffTotal.toString(),
                                          style: const TextStyle(
                                              color: whiteColor, fontSize: 12),
                                        ),
                                      )),
                                    if (!miniInfo)
                                      Center(
                                          child: Padding(
                                        padding: const EdgeInsets.only(
                                            top: 14.0, bottom: 14.0),
                                        child: Text(
                                          row.pctGoalsTotal.toString(),
                                          style: const TextStyle(
                                              color: whiteColor, fontSize: 12),
                                        ),
                                      )),
                                  ])
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )));
  }

  Widget over(BuildContext context) {

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
                    value:  context.watch<SaveData>().selectedLeague,
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
                      EasyLoading.show(status: 'loading...');
                      context.read<MainApi>().getOvers(newValue!.id);
                      // setState(() {
                      //   selectedLeague = newValue!;
                      // });
                      context.read<SaveData>().changeSelectedLeague(newValue!);
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
                      itemCount: context.watch<MainApi>().overs.length,
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
                                      left: 20, right: 20, top: 7, bottom: 7),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        context
                                            .watch<MainApi>()
                                            .overs[index]
                                            .date,
                                        style: const TextStyle(
                                            color: whiteColor,
                                            fontSize: 12.0,
                                            decoration: TextDecoration.none),
                                      ),
                                      Text(
                                        context
                                            .watch<MainApi>()
                                            .overs[index]
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
                                              .addRemoveInterestsOvers(
                                                context,
                                                index,
                                                Provider.of<MainApi>(context,
                                                        listen: false)
                                                    .overs[index]
                                                    .gameId,
                                                Provider.of<MainApi>(context,
                                                        listen: false)
                                                    .overs[index]
                                                    .isFavorite,
                                              );
                                          if (!(Provider.of<MainApi>(context,
                                                  listen: false)
                                              .overs[index]
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
                                                  .overs[index]
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
                                    Provider.of<MainApi>(context, listen: false)
                                        .getStatisticsData(
                                            context,
                                            Provider.of<MainApi>(context,
                                                    listen: false)
                                                .overs[index]
                                                .leagueId,
                                            Provider.of<MainApi>(context,
                                                    listen: false)
                                                .overs[index]
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
                                          bottomRight: Radius.circular(20.0),
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
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  context
                                                      .watch<MainApi>()
                                                      .overs[index]
                                                      .teamHome,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: const TextStyle(
                                                      fontSize: 16.0,
                                                      color: Colors.white,
                                                      decoration:
                                                          TextDecoration.none),
                                                ),
                                              ),
                                              Text(
                                                context
                                                    .watch<MainApi>()
                                                    .overs[index]
                                                    .teamHomePoints,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none),
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
                                              const EdgeInsets.only(top: 5.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                context
                                                    .watch<MainApi>()
                                                    .overs[index]
                                                    .teamAway,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none),
                                              ),
                                              Text(
                                                context
                                                    .watch<MainApi>()
                                                    .overs[index]
                                                    .teamAwayPoints,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontSize: 16.0,
                                                    color: Colors.white,
                                                    decoration:
                                                        TextDecoration.none),
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
}
