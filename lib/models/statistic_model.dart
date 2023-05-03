class StatisticsModel {
  String teamHome;
  String teamAway;
  String teamHomeId;
  String teamAwayId;
  String teamHomePoints;
  String teamAwayPoints;
  String time;
  String date;
  List<String> goals1Period;
  List<String> goals2Period;
  List<String> goals3Period;
  List<String> goals4Period;
  List<String> p2Points;
  List<String> p3Points;
  List<String> biggestLead;
  List<String> fouls;
  List<String> freeThrows;
  List<String> freeThrowsRate;
  List<String> leadChanges;
  List<String> maxPointsInARow;
  List<String> possession;
  List<String> timeSpentInLead;
  List<String> timeOuts;

  StatisticsModel({
    required this.teamHome,
    required this.teamAway,
    required this.teamHomeId,
    required this.teamAwayId,
    required this.teamHomePoints,
    required this.teamAwayPoints,
    required this.time,
    required this.date,
    required this.goals1Period,
    required this.goals2Period,
    required this.goals3Period,
    required this.goals4Period,
    required this.p2Points,
    required this.p3Points,
    required this.biggestLead,
    required this.fouls,
    required this.freeThrows,
    required this.freeThrowsRate,
    required this.leadChanges,
    required this.maxPointsInARow,
    required this.possession,
    required this.timeSpentInLead,
    required this.timeOuts,
  });
}
