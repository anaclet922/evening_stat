import 'package:evening_stat/providers/main_api_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:transparent_image/transparent_image.dart';

class Statistics extends StatefulWidget {
  final String leagueId, gameId;
  const Statistics(this.leagueId, this.gameId, {Key? key}) : super(key: key);

  @override
  State<Statistics> createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  @override
  void initState() {
    super.initState();
    Provider.of<MainApi>(context, listen: false).getStatisticsData(widget.leagueId, widget.gameId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
          leading: GestureDetector(
              onTap: (){
                Navigator.of(context).pop();
              },
              child: const Icon(Icons.chevron_left_outlined)
          ),
          title: const Text(
            'Statistics',
            style: TextStyle(
                color: whiteColor,
                fontSize: 20
            ),
          )
      ),
      body: context.watch<MainApi>().apiState == ApiState.loading
          ? const Center(
        child: CircularProgressIndicator(
          color: primaryLightColor,
        ),
      )
          : Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              image:  DecorationImage(
                image:
                Image.asset("assets/preview_background.png").image,
                fit: BoxFit.fitWidth,
              ),
            ),
            width: double.infinity,
            child: Container(
              decoration: const BoxDecoration(color: primaryHalfColor),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    context.watch<MainApi>().statistics.date,
                    style: const TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.none,
                        color: whiteColor
                    ),
                  ),
                  Text(
                    context.watch<MainApi>().statistics.time,
                    style:const  TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.none,
                        color: whiteColor
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            Image.network(
                              'https://spoyer.com/api/team_img/basketball/${context.watch<MainApi>().statistics.teamHomeId}.png',
                              width: 50,
                              errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                return Image.asset('assets/ball.png', width: 50,);
                              },
                            ),
                            Text(
                              context.watch<MainApi>().statistics.teamHome,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                  fontSize: 15,
                                  decoration: TextDecoration.none,
                                  color: whiteColor
                              ),
                            )
                          ],
                        ),
                      ),
                      Image.asset('assets/vs.png', width: 70,),
                     Expanded(
                         child:  Column(
                       children: [
                         Image.network(
                           'https://spoyer.com/api/team_img/basketball/${context.watch<MainApi>().statistics.teamAwayId}.png',
                           width: 50,
                           errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                             return Image.asset('assets/ball.png', width: 50,);
                           },
                         ),
                         Text(
                           context.watch<MainApi>().statistics.teamAway,
                           overflow: TextOverflow.ellipsis,
                           style: const TextStyle(
                               fontSize: 15,
                               decoration: TextDecoration.none,
                               color: whiteColor
                           ),
                         )
                       ],
                     )
                     )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: primaryColor,
              child: Column(
                children: [
                  Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.goals1Period.asMap().containsKey(0) ? context.watch<MainApi>().statistics.goals1Period[0] : '0',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('Goals 1 period', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.goals1Period.asMap().containsKey(1) ? context.watch<MainApi>().statistics.goals1Period[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.goals2Period.asMap().containsKey(0) ? context.watch<MainApi>().statistics.goals2Period[0] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('Goals 2 period', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.goals2Period.asMap().containsKey(1) ? context.watch<MainApi>().statistics.goals2Period[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.goals3Period.asMap().containsKey(0) ? context.watch<MainApi>().statistics.goals3Period[0] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('Goals 3 period', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.goals3Period.asMap().containsKey(1) ? context.watch<MainApi>().statistics.goals3Period[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.goals4Period.asMap().containsKey(0) ? context.watch<MainApi>().statistics.goals4Period[0] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('Goals 4 period', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.goals4Period.asMap().containsKey(1) ? context.watch<MainApi>().statistics.goals4Period[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.p2Points.asMap().containsKey(0) ? context.watch<MainApi>().statistics.p2Points[0] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('2 points', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.p2Points.asMap().containsKey(1) ? context.watch<MainApi>().statistics.p2Points[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.p3Points.asMap().containsKey(0) ? context.watch<MainApi>().statistics.p3Points[0] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('3 points', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.p3Points.asMap().containsKey(1) ? context.watch<MainApi>().statistics.p3Points[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.fouls.asMap().containsKey(0) ? context.watch<MainApi>().statistics.fouls[0] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('Fouls', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.fouls.asMap().containsKey(1) ? context.watch<MainApi>().statistics.fouls[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),

                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.freeThrows.asMap().containsKey(0) ? context.watch<MainApi>().statistics.freeThrows[0] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('Free throws', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.freeThrows.asMap().containsKey(1) ? context.watch<MainApi>().statistics.freeThrows[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),

                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.freeThrowsRate.asMap().containsKey(0) ? context.watch<MainApi>().statistics.freeThrowsRate[0] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('Free throws rate', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.freeThrowsRate.asMap().containsKey(1) ? context.watch<MainApi>().statistics.freeThrowsRate[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),
                            ),

                            Padding(
                              padding: const EdgeInsets.only(left: 50.0, right: 50, top: 10.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    context.watch<MainApi>().statistics.timeOuts.asMap().containsKey(0) ? context.watch<MainApi>().statistics.timeOuts[0] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                  Container(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    decoration: const BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                color: primaryLightColor, width: 2
                                            )
                                        )
                                    ),
                                    child: const Text('Time outs', style: TextStyle(fontSize: 16, color: whiteColor)),
                                  ),
                                  Text(
                                    context.watch<MainApi>().statistics.timeOuts.asMap().containsKey(1) ? context.watch<MainApi>().statistics.timeOuts[1] : '',
                                    style: const TextStyle(fontSize: 16, color: whiteColor),),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                  )

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
