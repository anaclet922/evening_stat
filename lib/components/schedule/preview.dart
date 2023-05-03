import 'package:evening_stat/providers/main_api_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// import 'package:transparent_image/transparent_image.dart';

class Preview extends StatefulWidget {
  final String leagueId, gameId;
  const Preview(this.leagueId, this.gameId, {Key? key}) : super(key: key);

  @override
  State<Preview> createState() => _PreviewState();
}

class _PreviewState extends State<Preview> {

  @override
  void initState() {
    super.initState();
    Provider.of<MainApi>(context, listen: false).getHeadTwoHeadData(widget.leagueId, widget.gameId);
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
         'Preview',
         style: TextStyle(
           color: whiteColor,
           fontSize: 20
         ),
            )
      ),
      body: Column(
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
                    context.watch<MainApi>().headTwoHead.date,
                    style: const TextStyle(
                      fontSize: 12,
                      decoration: TextDecoration.none,
                      color: whiteColor
                    ),
                  ),
                  Text(
                    context.watch<MainApi>().headTwoHead.time,
                    style:const  TextStyle(
                        fontSize: 12,
                        decoration: TextDecoration.none,
                      color: whiteColor
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.network(
                            'https://spoyer.com/api/team_img/basketball/${context.watch<MainApi>().headTwoHead.teamHomeId}.png',
                            width: 50,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Image.asset('assets/ball.png', width: 50,);
                            },
                          ),
                          Text(
                            context.watch<MainApi>().headTwoHead.teamHome,
                              style: const TextStyle(
                              fontSize: 15,
                              decoration: TextDecoration.none,
                                color: whiteColor
                          ),
                          )
                        ],
                      ),
                      Image.asset('assets/vs.png', width: 70,),
                      Column(
                        children: [
                          Image.network(
                            'https://spoyer.com/api/team_img/basketball/${context.watch<MainApi>().headTwoHead.teamAwayId}.png',
                            width: 50,
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                              return Image.asset('assets/ball.png', width: 50,);
                            },
                          ),
                          Text(
                            context.watch<MainApi>().headTwoHead.teamAway,
                            style: const TextStyle(
                                fontSize: 15,
                                decoration: TextDecoration.none,
                                color: whiteColor
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: primaryLightColor,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: primaryColor
                    ),
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Stadium:', style: TextStyle(color: primaryLightColor, fontSize: 16),),
                              Text(
                                context.watch<MainApi>().headTwoHead.stadium,
                                style: const TextStyle(
                                  color: whiteColor, fontSize: 16
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Capacity:', style: TextStyle(color: primaryLightColor, fontSize: 16),),
                              Text(
                                context.watch<MainApi>().headTwoHead.capacity,
                                style: const TextStyle(
                                    color: whiteColor, fontSize: 16
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('City:', style: TextStyle(color: primaryLightColor, fontSize: 16),),
                              Text(
                                context.watch<MainApi>().headTwoHead.city,
                                style: const TextStyle(
                                    color: whiteColor, fontSize: 16
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Country:', style: TextStyle(color: primaryLightColor, fontSize: 16),),
                              Text(
                                context.watch<MainApi>().headTwoHead.country,
                                style: const TextStyle(
                                    color: whiteColor, fontSize: 16
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding:const EdgeInsets.only(bottom: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Home Position:', style: TextStyle(color: primaryLightColor, fontSize: 16),),
                              Text(
                                context.watch<MainApi>().headTwoHead.stadium,
                                style: const TextStyle(
                                    color: whiteColor, fontSize: 16
                                ),
                              )
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Away Position:', style: TextStyle(color: primaryLightColor, fontSize: 16),),
                            Text(
                              context.watch<MainApi>().headTwoHead.stadium,
                              style: const TextStyle(
                                  color: whiteColor, fontSize: 16
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                  ),

                  Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            for(var head in context.watch<MainApi>().headTwoHead.headTwoHead)
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    color: primaryColor
                                ),
                                margin: const EdgeInsets.all(10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      children: [
                                        Image.network(
                                          'https://spoyer.com/api/team_img/basketball/${context.watch<MainApi>().headTwoHead.teamHomeId}.png',
                                          width: 50,
                                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            return Image.asset('assets/ball.png', width: 50,);
                                          },
                                        ),
                                        Text(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          context.watch<MainApi>().headTwoHead.teamHome,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              decoration: TextDecoration.none,
                                              color: whiteColor
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          head.homeGoals,
                                          style: TextStyle(
                                              fontSize: 32,
                                              color: (int.parse(head.homeGoals) > int.parse(head.awayGoals) ? Colors.green: Colors.redAccent)
                                          ),
                                        ),
                                        const Padding(
                                          padding:  EdgeInsets.only(left: 10.0,right: 10.0),
                                          child:  Text(
                                            ':',
                                            style: TextStyle(
                                                fontSize: 32,
                                                color: Colors.white
                                            ),
                                          ),
                                        ),
                                        Text(
                                          head.awayGoals,
                                          style: TextStyle(
                                              fontSize: 32,
                                              color: (int.parse(head.homeGoals) < int.parse(head.awayGoals) ? Colors.green: Colors.redAccent)
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Image.network(
                                          'https://spoyer.com/api/team_img/basketball/${context.watch<MainApi>().headTwoHead.teamAwayId}.png',
                                          width: 50,
                                          errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                            return Image.asset('assets/ball.png', width: 50,);
                                          },
                                        ),
                                        Text(
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          context.watch<MainApi>().headTwoHead.teamAway,
                                          style: const TextStyle(
                                              fontSize: 15,
                                              decoration: TextDecoration.none,
                                              color: whiteColor
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              )
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
