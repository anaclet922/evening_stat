class OverModel {
  String gameId;
  String leagueId;
  String date;
  String time;
  String teamHome;
  String teamHomeId;
  String teamHomePoints;
  String teamAway;
  String teamAwayId;
  String teamAwayPoints;
  bool isFavorite;

  OverModel(
      {required this.gameId,
        required this.leagueId,
        required this.date,
        required this.time,
        required this.teamHome,
        required this.teamHomeId,
        required this.teamHomePoints,
        required this.teamAway,
        required this.teamAwayId,
        required this.teamAwayPoints,
        required this.isFavorite});

}
