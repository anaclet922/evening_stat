
import 'package:evening_stat/models/league_model.dart';
import 'package:evening_stat/providers/saved_data_provider.dart';
import 'package:evening_stat/providers/sound_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Option extends StatefulWidget {
  const Option({Key? key}) : super(key: key);

  @override
  State<Option> createState() => _OptionState();
}

class _OptionState extends State<Option> {

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
  late bool soundOn;
  late double currentSliderValue;
  // ignore: unused_field
  String? _sliderStatus;


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
    soundOn = Provider.of<SaveData>(context, listen: false).soundSaved;
    currentSliderValue = Provider.of<SaveData>(context, listen: false).currentSliderValue.toDouble();
  }

  @override
  void initState() {
    initVars();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      backgroundColor: primaryColor,
      navigationBar: const CupertinoNavigationBar(
        backgroundColor: primaryColor,
        middle: Text(
          'Option',
          style: TextStyle(color: whiteColor),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
          image: Image.asset("assets/option-background-1.png").image,
          fit: BoxFit.cover,
        )),
        child: Container(
          padding: const EdgeInsets.all(30),
          decoration: const BoxDecoration(color: primaryHalfColor),
          child: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Sound",
                          style: TextStyle(
                              color: whiteColor,
                              decoration: TextDecoration.none,
                              fontSize: 16.0),
                        ),
                        Container(
                          width: 126,
                          margin: const EdgeInsets.only(right: 20.0),
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 57,
                                child: GestureDetector(
                                    onTap: () {
                                      context.read<MySound>().btnPressedSound();
                                      setState(() {
                                        soundOn = !soundOn;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 2,
                                          bottom: 2.0),
                                      decoration: BoxDecoration(
                                        gradient: soundOn
                                            ? primaryGradient
                                            : secondaryGradient,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(80.0)),
                                      ),
                                      child:const Center(
                                        child:  Text(
                                          'On',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: whiteColor,
                                            decoration: TextDecoration.none
                                          ),
                                        ),
                                      ),
                                    )
                                    // ,
                                    ),
                              ),
                              SizedBox(
                                width: 57,
                                child: GestureDetector(
                                    onTap: () {
                                      context.read<MySound>().btnPressedSound();
                                      setState(() {
                                        soundOn = !soundOn;
                                      });
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.only(
                                          top: 2, bottom: 2.0),
                                      decoration: BoxDecoration(
                                        gradient: soundOn
                                            ? secondaryGradient
                                            : primaryGradient,
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(80.0)),
                                      ),
                                      child: const Center(
                                        child:  Text(
                                          'Off',
                                          style: TextStyle(
                                              fontSize: 12, color: whiteColor, decoration: TextDecoration.none),
                                        ),
                                      ),
                                    )
                                    // ,
                                    ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Choose League',
                            style: TextStyle(
                                color: whiteColor,
                                decoration: TextDecoration.none,
                                fontSize: 16.0),
                          ),
                          Expanded(
                            child: Container(
                              height: 19.0,
                              margin: const EdgeInsets.only(right: 20.0, left: 20.0),
                              padding: const EdgeInsets.only(bottom: 2.0),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22.5),
                                  gradient: primaryGradient
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Center(
                                    child: DropdownButton(
                                      borderRadius: BorderRadius.circular(23),
                                      alignment: AlignmentDirectional.center,
                                      dropdownColor: primaryColor,
                                      icon: const SizedBox.shrink(),
                                      value: selectedLeague,
                                      items: leagueItems.map((LeagueModel value) {
                                        return DropdownMenuItem(
                                           alignment: AlignmentDirectional.bottomCenter,
                                            value: value,
                                            child: Text(
                                              value.leagueName,
                                              overflow: TextOverflow.ellipsis,
                                              style:
                                                  const TextStyle(
                                                      color: whiteColor,
                                                    fontSize: 12.0,
                                                    fontWeight: FontWeight.bold
                                                  ),
                                            ));
                                      }).toList(),
                                      onChanged: (LeagueModel? newValue) {
                                        context.read<MySound>().btnPressedSound();
                                        setState(() {
                                          selectedLeague = newValue!;
                                        });
                                      },
                                      underline: const SizedBox(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 32.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text(
                            'Timer',
                            style: TextStyle(
                                color: whiteColor,
                                decoration: TextDecoration.none,
                                fontSize: 16.0),
                          ),
                           Text(
                            currentSliderValue.toInt().toString(),
                            style: const TextStyle(
                                color: whiteColor,
                                decoration: TextDecoration.none,
                                fontSize: 16.0),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: CupertinoSlider(
                              key: const Key('slider'),
                              value: currentSliderValue,
                              // This allows the slider to jump between divisions.
                              // If null, the slide movement is continuous.
                              divisions: 24,
                              // The maximum slider value
                              max: 24,
                              activeColor: primaryColor,
                              thumbColor: primaryColor,
                              // This is called when sliding is started.
                              onChangeStart: (double value) {
                                setState(() {
                                  _sliderStatus = 'Sliding';
                                });
                              },
                              // This is called when sliding has ended.
                              onChangeEnd: (double value) {
                                setState(() {
                                  _sliderStatus = 'Finished sliding';
                                });
                              },
                              // This is called when slider value is changed.
                              onChanged: (double value) {
                                setState(() {
                                  currentSliderValue = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(30),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        CupertinoButton(
                            onPressed: () {
                              context.read<MySound>().btnPressedSound();
                              _saveChangeAlertDialog(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3.0, left: 31, right: 31),
                              decoration: const BoxDecoration(
                                gradient: primaryGradient,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80.0)),
                              ),
                              child: const Text(
                                'Save',
                                style:
                                    TextStyle(fontSize: 12, color: whiteColor),
                              ),
                            )
                            // ,
                            ),
                        CupertinoButton(
                            onPressed: () {
                              context.read<MySound>().btnPressedSound();
                              _changeToDefaultAlertDialog(context);
                            },
                            child: Container(
                              padding: const EdgeInsets.only(
                                  top: 3, bottom: 3.0, left: 31, right: 31),
                              decoration: const BoxDecoration(
                                gradient: primaryGradient,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(80.0)),
                              ),
                              child: const Text(
                                'Default',
                                style:
                                    TextStyle(fontSize: 12, color: whiteColor),
                              ),
                            )
                            // ,
                            )
                      ],
                    ),
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveChangeAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: primaryColor, width: 4.0),
                      image: DecorationImage(
                        image:
                            Image.asset("assets/option-background-1.png").image,
                        fit: BoxFit.fitWidth,
                      )),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Sure?',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        padding: const EdgeInsets.all(7.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 4.0, color: primaryColor))),
                        child: const Padding(
                          padding: EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Text(
                            'Do you want to save your changes?',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                                color: whiteColor),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                context.read<MySound>().btnPressedSound();
                                setPersonalizedSettings();
                                Navigator.of(context).pop();
                                if(!soundOn){
                                  context.read<MySound>().stopBackgroundSound();
                                }else{
                                  context.read<MySound>().playBackgroundSound();
                                }
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                    color: whiteColor),
                              )),
                          Container(
                            width: 4.0,
                            height: 40.0,
                            decoration: const BoxDecoration(color: whiteColor),
                          ),
                          TextButton(
                              onPressed: () {
                                context.read<MySound>().btnPressedSound();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                    color: whiteColor),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  Future<void> _changeToDefaultAlertDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
            contentPadding: EdgeInsets.zero,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      border: Border.all(color: primaryColor, width: 4.0),
                      image: DecorationImage(
                        image:
                            Image.asset("assets/option-background-1.png").image,
                        fit: BoxFit.fitWidth,
                      )),
                  child: Column(
                    children: <Widget>[
                      const Text(
                        'Sure?',
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.bold,
                            color: whiteColor),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 5.0),
                        padding: const EdgeInsets.all(7.0),
                        decoration: const BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 4.0, color: primaryColor))),
                        child: const Padding(
                            padding: EdgeInsets.only(left: 30.0, right: 30.0)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                              onPressed: () {
                                context.read<MySound>().btnPressedSound();
                                setDefaultSettings();
                                Navigator.of(context).pop();
                                setState(() {
                                  soundOn = true;
                                });
                                context.read<MySound>().playBackgroundSound();
                              },
                              child: const Text(
                                'Yes',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                    color: whiteColor),
                              )),
                          Container(
                            width: 4.0,
                            height: 40.0,
                            decoration: const BoxDecoration(color: whiteColor),
                          ),
                          TextButton(
                              onPressed: () {
                                context.read<MySound>().btnPressedSound();
                                Navigator.of(context).pop();
                              },
                              child: const Text(
                                'No',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 24.0,
                                    color: whiteColor),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ));
      },
    );
  }

  void setDefaultSettings() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSoundOn', true);
    prefs.setInt('defaultLeague', 1328);
    prefs.setInt('defaultTimer', 1);
  }

  void setPersonalizedSettings() async{
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isSoundOn', soundOn);
    prefs.setInt('defaultLeague', selectedLeague.id);
    prefs.setInt('defaultTimer', currentSliderValue.toInt());
  }
}
