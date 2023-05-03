class ScheduleModel {
  String leagueId;
  String gameId;
  String time;
  String date;
  String teamHome;
  String teamHomeId;
  String teamHomeImage;
  String teamAway;
  String teamAwayId;
  String teamAwayImage;
  String oddHome;
  String oddX;
  String oddAway;
  bool isFavorite;

  ScheduleModel(
      {required this.leagueId,
        required this.gameId,
        required this.time,
        required this.date,
        required this.teamHome,
        required this.teamHomeId,
        required this.teamHomeImage,
        required this.teamAway,
        required this.teamAwayId,
        required this.teamAwayImage,
        required this.oddHome,
        required this.oddX,
        required this.oddAway,
        required this.isFavorite});

  Map<String, dynamic> toJson() => <String, dynamic>{
    'leagueId': leagueId,
    'gameId': gameId,
    'time': time,
    'date': date,
    'teamHome': teamHome,
    'teamHomeId': teamHomeId,
    'teamHomeImage': teamHomeImage,
    'teamAway': teamAway,
    'teamAwayId': teamAwayId,
    'teamAwayImage': teamAwayImage,
    'oddHome': oddHome,
    'oddX': oddX,
    'oddAway': oddAway,
    'isFavorite': isFavorite,
  };
}
