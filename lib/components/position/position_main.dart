import 'package:evening_stat/models/league_model.dart';
import 'package:evening_stat/providers/main_api_provider.dart';
import 'package:evening_stat/providers/saved_data_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
// import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../providers/sound_provider.dart';

class PositionMain extends StatefulWidget {
  const PositionMain({Key? key}) : super(key: key);

  @override
  State<PositionMain> createState() => _PositionMainState();
}

class _PositionMainState extends State<PositionMain> {
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

  bool miniInfo = true;

  void initVars(){
    if(Provider.of<SaveData>(context, listen: false).leagueSaved > 14){
      for(int i = 0; i < leagueItems.length; i++){
        if(leagueItems[i].id == Provider.of<SaveData>(context, listen: false).leagueSaved){
          selectedLeague = leagueItems[i];
          break;
        }
      }
    }else{
      selectedLeague = leagueItems[Provider.of<SaveData>(context, listen: false).leagueSaved];
    }
  }

  @override
  void initState() {
    initVars();
    super.initState();
  }

  @override
  Widget build(BuildContext context){

    return Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
            backgroundColor: primaryColor,
            title: Container(
              height: 30.0,
              width: double.infinity,
              margin: const EdgeInsets.only(right: 20.0, left: 20, top: 10, bottom: 10),
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
                    context.read<MainApi>().getLeaguePosition(selectedLeague.id);
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
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.only(left: 2, right: 2),
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                          ),
                          child: miniInfo ? Image.asset('assets/plus.png') : Image.asset('assets/minus.png'),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Table(
                      border: TableBorder.all(color: primaryLightColor, width: 2),
                      children: [
                         TableRow(
                          decoration: const BoxDecoration(
                            color: primaryColor
                          ),
                          children: [
                            const Center(child: Padding(
                              padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                              child: Text('Team', style: TextStyle(color: whiteColor, fontSize: 16)),
                            )),
                            const Center(child: Padding(
                              padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                              child: Text('P', style: TextStyle(color: whiteColor, fontSize: 12)),
                            )),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                                child: Text('W', style: TextStyle(color: whiteColor, fontSize: 12)),
                              ),
                            ),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                                child: Text('L', style: TextStyle(color: whiteColor, fontSize: 12)),
                              ),
                            ),
                            if(!miniInfo)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                                child: Text('G+', style: TextStyle(color: whiteColor, fontSize: 12)),
                              ),
                            ),
                            if(!miniInfo)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                                child: Text('G-', style: TextStyle(color: whiteColor, fontSize: 12)),
                              ),
                            ),
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                                child: Text('Score', style: TextStyle(color: whiteColor, fontSize: 12)),
                              ),
                            ),
                            if(!miniInfo)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                                child: Text('pct(%)', style: TextStyle(color: whiteColor, fontSize: 12)),
                              ),
                            ),
                            if(!miniInfo)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                                child: Text('G+/-', style: TextStyle(color: whiteColor, fontSize: 12)),
                              ),
                            ),
                            if(!miniInfo)
                            const Center(
                              child: Padding(
                                padding: EdgeInsets.only(top: 14.0, bottom: 14.0),
                                child: Text('%G+/-', style: TextStyle(color: whiteColor, fontSize: 12)),
                              ),
                            ),
                          ]
                        ),

                        for(var row in context.watch<MainApi>().positions)
                          TableRow(
                              children: [
                                Center(child: Padding(
                                  padding: const EdgeInsets.only(top: 4.0),
                                  child: FadeInImage.memoryNetwork(
                                  placeholder: kTransparentImage,
                                  image: row.teamImage, width: 30,
                                  ),
                                )),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                                    child: Text(row.position.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                                    child: Text(row.win.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                                  ),
                                ),
                                if(!miniInfo)
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                                      child: Text(row.loss.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                                    ),
                                  ),
                                if(!miniInfo)
                                  Center(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                                      child: Text(row.goalsPlus.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                                    ),
                                  ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                                    child: Text(row.goalsMinus.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                                    child: Text(row.score.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                                  ),
                                ),
                                if(!miniInfo)
                                  Center(child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                                    child: Text(row.pct.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                                  )),
                                if(!miniInfo)
                                  Center(child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                                    child: Text(row.goalDiffTotal.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                                  )),
                                if(!miniInfo)
                                  Center(child: Padding(
                                    padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
                                    child: Text(row.pctGoalsTotal.toString(), style: const TextStyle(color: whiteColor, fontSize: 12),),
                                  )),

                              ]
                          )

                      ],
                    ),
                  )
                ],
              ),
            )));
  }
}
