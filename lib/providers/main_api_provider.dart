import 'dart:convert';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:evening_stat/models/head_two_head_model.dart';
import 'package:evening_stat/models/over_model.dart';
import 'package:evening_stat/models/postion_model.dart';
import 'package:evening_stat/models/schedule_model.dart';
import 'package:evening_stat/models/statistic_model.dart';
import 'package:evening_stat/providers/sound_provider.dart';
import 'package:evening_stat/utilis/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ApiState {
  initial,
  loading,
  loaded,
  error,
}

class MainApi with ChangeNotifier {
  ApiState _apiState = ApiState.initial;

  ApiState get apiState => _apiState;

  List<PositionModel> positions = [];
  List<ScheduleModel> schedules = [];
  HeadTwoHeadModel headTwoHead = emptyH2H();
  List<OverModel> overs = [];
  StatisticsModel statistics = emptyStatistic();
  List<OverModel> interests = [];

  void apiFetchedSound() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isSoundOn = prefs.getBool('isSoundOn') ?? true;
    if (isSoundOn) {
      AudioPlayer().play(AssetSource('sound_after_changes.mp3'));
    }
  }

  Future<void> getLeaguePosition([int leagueId = 0]) async {
    try {
      // print(leagueId);
      if (leagueId == 0) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        leagueId = prefs.getInt('defaultLeague') ?? defaultLeagueId;
      }

      final response = await http.get(
          Uri.parse(
              '$apiEndPoint?login=$apiLogin&token=$apiToken&task=tabledata&league=$leagueId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        var responseArray = jsonDecode(response.body);

        positions = [];

        // print(responseArray['results']['overall']);

        for (var singleResult in responseArray['results']['overall']['tables']
            [0]['rows']) {
          PositionModel position = PositionModel(
              position: singleResult['pos'] ?? 'n/a',
              win: singleResult['win'] ?? 'n/a',
              loss: singleResult['loss'] ?? 'n/a',
              goalsPlus: singleResult['goalsfor'] ?? 'n/a',
              goalsMinus: singleResult['goalsagainst'] ?? 'n/a',
              score: singleResult['points'] ?? 'n/a',
              pct: singleResult['pct'] ?? 'n/a',
              goalDiffTotal: singleResult['goalDiffTotal'] ?? 0,
              pctGoalsTotal: singleResult['pctGoalsTotal'] ?? 0,
              teamId: singleResult['team']['id'] ?? 'n/a',
              teamName: singleResult['team']['name'],
              teamImage:
                  'https://spoyer.com/api/team_img/basketball/${singleResult['team']['id']}.png');
          //Adding result to the list.
          positions.add(position);
        }
        // print(positions.length);
        _apiState = ApiState.loaded;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        _apiState = ApiState.loaded;
      }
    } on Exception {
      _apiState = ApiState.loaded;
    }
    apiFetchedSound();
    notifyListeners();
  }

  Future<void> getSchedules([int leagueId = 0]) async {
    try {
      // print(leagueId);
      if (leagueId == 0) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        leagueId = prefs.getInt('defaultLeague') ?? defaultLeagueId;
      }

      final response = await http.get(
          Uri.parse(
              '$apiEndPoint?login=$apiLogin&token=$apiToken&task=predata&sport=basketball&league=$leagueId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        var responseArray = jsonDecode(response.body);

        schedules = [];

        // print(responseArray['results']['overall']);

        for (var singleResult in responseArray['games_pre']) {
          final oddResponse = await http.get(
              Uri.parse(
                  '$apiEndPoint?login=$apiLogin&token=$apiToken&task=allodds&game_id=${singleResult['game_id']}'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              });

          double min = 0.18;
          double max = 5.32;
          var rnd = Random();
          var r = rnd.nextDouble() * (max - min) + min;

          String oddHome = '';
          String oddX = r.toStringAsFixed(2);
          String oddAway = '';

          if (oddResponse.statusCode == 200) {
            var array = jsonDecode(oddResponse.body);
            try {
              oddHome = array['results']['Bet365']['odds']['end']['18_2']
                      ['home_od'] ??
                  'n/a';
              // oddX = array['results']['Bet365']['odds']['end']['18_2']
              // ['handicap'] ??
              //     'n/a';
              oddAway = array['results']['Bet365']['odds']['end']['18_2']
                      ['away_od'] ??
                  'n/a';
            } catch (error) {
              oddHome =
                  (rnd.nextDouble() * (max - min) + min).toStringAsFixed(2);
              // oddX = 'n/a';
              oddAway =
                  (rnd.nextDouble() * (max - min) + min).toStringAsFixed(2);
            }
          }

          final SharedPreferences prefs = await SharedPreferences.getInstance();

          var interestLists = prefs.getStringList('interests') ?? [''];
          // print(interestLists);
          var gameId = singleResult['game_id'];
          int i = int.parse(singleResult['time']);
          var dt = DateTime.fromMillisecondsSinceEpoch(i * 1000);

          ScheduleModel schedule = ScheduleModel(
              leagueId: singleResult['league']['id'],
              gameId: singleResult['game_id'],
              time: DateFormat('hh:mm a').format(dt).toString(),
              date: DateFormat('MM.dd.yyyy').format(dt).toString(),
              teamHome: singleResult['home']['name'],
              teamHomeId: singleResult['home']['id'],
              teamHomeImage: singleResult['home']['image_id'],
              teamAway: singleResult['away']['name'],
              teamAwayId: singleResult['away']['id'],
              teamAwayImage: singleResult['away']['image_id'],
              oddHome: oddHome,
              oddX: oddX,
              oddAway: oddAway,
              isFavorite: interestLists!.contains(gameId) ? true : false);

          //Adding result to the list.
          schedules.add(schedule);
        }
        // print(schedules);
        _apiState = ApiState.loaded;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        _apiState = ApiState.loaded;
      }
    } on Exception {
      _apiState = ApiState.loaded;
    }
    apiFetchedSound();
    notifyListeners();
  }

  Future<void> getHeadTwoHeadData(String leagueId, String gameId) async {
    try {
      final previewResponse = await http.get(
          Uri.parse(
              '$apiEndPoint?login=$apiLogin&token=$apiToken&task=eventdata&game_id=$gameId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      final h2hResponse = await http.get(
          Uri.parse(
              '$apiEndPoint?login=$apiLogin&token=$apiToken&task=h2h&game_id=$gameId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (previewResponse.statusCode == 201 ||
          previewResponse.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        var previewResponseArray = jsonDecode(previewResponse.body);
        var h2hResponseArray = jsonDecode(h2hResponse.body);

        headTwoHead = emptyH2H();

        headTwoHead.teamHome =
            previewResponseArray['results'][0]['home']['name'];
        headTwoHead.teamAway =
            previewResponseArray['results'][0]['away']['name'];
        headTwoHead.teamHomeId =
            previewResponseArray['results'][0]['home']['id'];
        headTwoHead.teamAwayId =
            previewResponseArray['results'][0]['away']['id'];

        int i = int.parse(previewResponseArray['results'][0]['time']);
        var dt = DateTime.fromMillisecondsSinceEpoch(i * 1000);
        headTwoHead.time = DateFormat('hh:mm a').format(dt).toString();
        headTwoHead.date = DateFormat('MM.dd.yyyy').format(dt).toString();

        headTwoHead.stadium =
            previewResponseArray['results'][0]['extra']['stadium_data']['name'];
        headTwoHead.capacity = previewResponseArray['results'][0]['extra']
            ['stadium_data']['capacity'];
        headTwoHead.city =
            previewResponseArray['results'][0]['extra']['stadium_data']['city'];
        headTwoHead.country = previewResponseArray['results'][0]['extra']
            ['stadium_data']['country'];
        headTwoHead.homePosition;
        headTwoHead.awayPosition;

        // print(responseArray['results']['overall']);

        for (var singleResult in h2hResponseArray['results']['h2h']) {
          var res = singleResult['ss'];
          int idx = res.indexOf("-");
          List parts = [
            res.substring(0, idx).trim(),
            res.substring(idx + 1).trim()
          ];

          H2H h = H2H(homeGoals: parts[0], awayGoals: parts[1]);

          headTwoHead.headTwoHead.add(h);
        }
        // print(headTwoHead);
        _apiState = ApiState.loaded;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        _apiState = ApiState.loaded;
      }
    } on Exception {
      _apiState = ApiState.loaded;
    }
    apiFetchedSound();
    notifyListeners();
  }

  static HeadTwoHeadModel emptyH2H() {
    return HeadTwoHeadModel(
        teamHome: '',
        teamAway: '',
        teamHomeId: '',
        teamAwayId: '',
        time: '',
        date: '',
        stadium: '',
        capacity: '',
        city: '',
        country: '',
        homePosition: '',
        awayPosition: '',
        headTwoHead: []);
  }

  static StatisticsModel emptyStatistic() {
    return StatisticsModel(
        teamHome: '',
        teamAway: '',
        teamHomeId: '',
        teamAwayId: '',
        teamHomePoints: '',
        teamAwayPoints: '',
        time: '',
        date: '',
        goals1Period: [],
        goals2Period: [],
        goals3Period: [],
        goals4Period: [],
        p2Points: [],
        p3Points: [],
        biggestLead: [],
        fouls: [],
        freeThrows: [],
        freeThrowsRate: [],
        leadChanges: [],
        maxPointsInARow: [],
        possession: [],
        timeSpentInLead: [],
        timeOuts: []);
  }

  Future<void> getOvers([int leagueId = 0]) async {
    _apiState = ApiState.loading;
    try {
      _apiState = ApiState.loaded;
      // print(leagueId);
      if (leagueId == 0) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        leagueId = prefs.getInt('defaultLeague') ?? defaultLeagueId;
      }

      final response = await http.get(
          Uri.parse(
              '$apiEndPoint?login=$apiLogin&token=$apiToken&task=enddata&sport=basketball&day=today'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        var responseArray = jsonDecode(response.body);

        overs = [];

        // print(responseArray['results']['overall']);

        for (var singleResult in responseArray['games_end']) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var interestLists = prefs.getStringList('interests') ?? [''];
          var res = singleResult['score'];

          if (res.toString().isNotEmpty) {
            int idx = res.indexOf(":");
            List parts = [
              res.substring(0, idx).trim(),
              res.substring(idx + 1).trim()
            ];

            int i = int.parse(singleResult['time']);
            var dt = DateTime.fromMillisecondsSinceEpoch(i * 1000);
            var tTime = DateFormat('hh:mm a').format(dt).toString();
            var dDate = DateFormat('MM.dd.yyyy').format(dt).toString();

            var gameId = singleResult['game_id'];

            OverModel over = OverModel(
                gameId: gameId,
                leagueId: singleResult['league']['id'],
                date: dDate,
                time: tTime,
                teamHome: singleResult['home']['name'],
                teamHomeId: singleResult['home']['id'],
                teamHomePoints: parts[0],
                teamAway: singleResult['away']['name'],
                teamAwayId: singleResult['away']['id'],
                teamAwayPoints: parts[1],
                isFavorite: interestLists!.contains(gameId) ? true : false);

            //Adding result to the list.
            overs.add(over);
          }
        }
        // print(positions.length);
        _apiState = ApiState.loaded;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        _apiState = ApiState.loaded;
      }
    } on Exception {
      _apiState = ApiState.loaded;
    }
    apiFetchedSound();
    notifyListeners();
  }


  Future<void> getOversAtDropdownChanged([int leagueId = 0]) async {
    _apiState = ApiState.loading;
    notifyListeners();
    print(_apiState);
    try {
      _apiState = ApiState.loaded;
      // print(leagueId);
      if (leagueId == 0) {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        leagueId = prefs.getInt('defaultLeague') ?? defaultLeagueId;
      }

      final response = await http.get(
          Uri.parse(
              '$apiEndPoint?login=$apiLogin&token=$apiToken&task=enddata&sport=basketball&day=today'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });
      print(response.statusCode);
      if (response.statusCode == 201 || response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        var responseArray = jsonDecode(response.body);

        overs = [];

        // print(responseArray['results']['overall']);

        for (var singleResult in responseArray['games_end']) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          var interestLists = prefs.getStringList('interests') ?? [''];
          var res = singleResult['score'];

          if (res.toString().isNotEmpty) {
            int idx = res.indexOf(":");
            List parts = [
              res.substring(0, idx).trim(),
              res.substring(idx + 1).trim()
            ];

            int i = int.parse(singleResult['time']);
            var dt = DateTime.fromMillisecondsSinceEpoch(i * 1000);
            var tTime = DateFormat('hh:mm a').format(dt).toString();
            var dDate = DateFormat('MM.dd.yyyy').format(dt).toString();

            var gameId = singleResult['game_id'];

            OverModel over = OverModel(
                gameId: gameId,
                leagueId: singleResult['league']['id'],
                date: dDate,
                time: tTime,
                teamHome: singleResult['home']['name'],
                teamHomeId: singleResult['home']['id'],
                teamHomePoints: parts[0],
                teamAway: singleResult['away']['name'],
                teamAwayId: singleResult['away']['id'],
                teamAwayPoints: parts[1],
                isFavorite: interestLists!.contains(gameId) ? true : false);

            //Adding result to the list.
            overs.add(over);
          }
        }
        // print(positions.length);
        _apiState = ApiState.loaded;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        _apiState = ApiState.loaded;
      }
    } on Exception {
      // print('esponse.statusCode');
      _apiState = ApiState.loaded;
    }
    apiFetchedSound();
    notifyListeners();
  }

  Future<void> getStatisticsData(String leagueId, String gameId) async {
    _apiState = ApiState.loading;
    try {
      final response = await http.get(
          Uri.parse(
              '$apiEndPoint?login=$apiLogin&token=$apiToken&task=eventdata&game_id=$gameId'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          });

      if (response.statusCode == 201 || response.statusCode == 200) {
        // If the server did return a 201 CREATED response,
        // then parse the JSON.
        var responseArray = jsonDecode(response.body);

        statistics = emptyStatistic();
        print(gameId);
        print(responseArray['results'][0]['stats']);
        var res = responseArray['results'][0]['ss'];
        int idx = res.indexOf("-");
        List parts = [
          res.substring(0, idx).trim(),
          res.substring(idx + 1).trim()
        ];

        int i = int.parse(responseArray['results'][0]['time']);
        var dt = DateTime.fromMillisecondsSinceEpoch(i * 1000);
        var tTime = DateFormat('hh:mm a').format(dt).toString();
        var dDate = DateFormat('MM.dd.yyyy').format(dt).toString();

        statistics.teamHome = responseArray['results'][0]['home']['name'];
        statistics.teamAway = responseArray['results'][0]['away']['name'];
        statistics.teamHomeId = responseArray['results'][0]['home']['id'];
        statistics.teamAwayId = responseArray['results'][0]['away']['id'];
        statistics.teamHomePoints = parts[0];
        statistics.teamAwayPoints = parts[1];
        statistics.time = tTime;
        statistics.date = dDate;
        statistics.goals1Period = [
          responseArray['results'][0]['scores']['1']['home'],
          responseArray['results'][0]['scores']['1']['away']
        ];
        statistics.goals2Period = [
          responseArray['results'][0]['scores']['2']['home'],
          responseArray['results'][0]['scores']['2']['away']
        ];
        statistics.goals3Period = [
          responseArray['results'][0]['scores']['3']['home'],
          responseArray['results'][0]['scores']['3']['away']
        ];
        statistics.goals4Period = [
          responseArray['results'][0]['scores']['4']['home'],
          responseArray['results'][0]['scores']['4']['away']
        ];
        statistics.p2Points =
        (responseArray['results'][0]['stats']['2points'] ?? ['n/a', 'n/a'])  as List<String>;
        statistics.p3Points =
        (responseArray['results'][0]['stats']['2points'] ?? ['n/a', 'n/a'])  as List<String>;
        statistics.biggestLead = [];
        statistics.fouls =
        (responseArray['results'][0]['stats']['fouls'] ?? ['n/a', 'n/a'])  as List<String>;
        statistics.freeThrows = (responseArray['results'][0]['stats']
                ['free_throws'] ??
            ['n/a', 'n/a'])  as List<String>;
        statistics.freeThrowsRate = (responseArray['results'][0]['stats']
                ['free_throws_rate'] ??
            ['n/a', 'n/a'])  as List<String>;
        statistics.leadChanges = [];
        statistics.maxPointsInARow = [];
        statistics.possession = [];
        statistics.timeSpentInLead = [];
        statistics.timeOuts =
        (responseArray['results'][0]['stats']['time_outs'] ?? ['n/a', 'n/a'])  as List<String>;

        // print(statistics);
        _apiState = ApiState.loaded;
      } else {
        // If the server did not return a 201 CREATED response,
        // then throw an exception.
        _apiState = ApiState.loaded;
      }
    } on Exception {
      _apiState = ApiState.loaded;
    }
    apiFetchedSound();
    notifyListeners();
  }

  Future<void> getInterests() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // prefs.setStringList('interests', ['6598731', '6599041']);
      var interestLists = prefs.getStringList('interests') ?? [''];
      // print(interestLists.length);
      if (interestLists.length > 1) {
        // print(interestLists);6598731 6599041
        // print(interestLists.reversed);
        interests = [];
        for (var interest in interestLists.reversed) {
          var gameId = interest;
          final response = await http.get(
              Uri.parse(
                  '$apiEndPoint?login=$apiLogin&token=$apiToken&task=eventdata&game_id=$gameId'),
              headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
              });
          if (response.statusCode == 201 || response.statusCode == 200) {
            // If the server did return a 201 CREATED response,
            // then parse the JSON.
            var responseArray = jsonDecode(response.body);

            var res = responseArray['results'][0]['ss'];

            if (res != null) {
              int idx = res.indexOf("-");
              List parts = [
                res.substring(0, idx).trim(),
                res.substring(idx + 1).trim()
              ];

              int t = int.parse(responseArray['results'][0]['time']);
              var dt = DateTime.fromMillisecondsSinceEpoch(t * 1000);
              var tTime = DateFormat('hh:mm a').format(dt).toString();
              var dDate = DateFormat('MM.dd.yyyy').format(dt).toString();

              OverModel i = OverModel(
                  gameId: gameId,
                  leagueId: responseArray['results'][0]['league']['id'],
                  date: dDate,
                  time: tTime,
                  teamHome: responseArray['results'][0]['home']['name'],
                  teamHomeId: responseArray['results'][0]['home']['name'],
                  teamHomePoints: parts[0],
                  teamAway: responseArray['results'][0]['away']['name'],
                  teamAwayId: responseArray['results'][0]['away']['id'],
                  teamAwayPoints: parts[1],
                  isFavorite: true);
              // print(i);
              interests.add(i);
            }
          }
        }
        //Adding result to the list.
        _apiState = ApiState.loaded;
      }
    } on Exception {
      _apiState = ApiState.loaded;
    }
    // print(interests);
    apiFetchedSound();
    notifyListeners();

  }
}
