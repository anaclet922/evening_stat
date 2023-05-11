class HeadTwoHeadModel {

  String teamHome;
  String teamAway;
  String teamHomeId;
  String teamAwayId;
  String time;
  String date;
  String stadium;
  String capacity;
  String city;
  String country;
  String homePosition;
  String awayPosition;
  List<H2H> headTwoHead;

  HeadTwoHeadModel(
      {required this.teamHome,
        required this.teamAway,
        required this.teamHomeId,
        required this.teamAwayId,
        required this.time,
        required this.date,
        required this.stadium,
        required this.capacity,
        required this.city,
        required this.country,
        required this.homePosition,
        required this.awayPosition,
        required this.headTwoHead});

}

class H2H{
  String homeId;
  String awayId;
  String homeName;
  String awayName;
  String homeGoals;
  String awayGoals;


  H2H({
    required this.homeId,
    required this.awayId,
    required this.homeName,
    required this.awayName,
    required this.homeGoals,
    required this.awayGoals
});

}
