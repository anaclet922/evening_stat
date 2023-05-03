class LeagueModel {
  int id;
  String leagueName;

  LeagueModel(
      { required this.id,
        required this.leagueName});

  Map<String, dynamic> toJson() => <String, dynamic>{
    'id': id,
    'leagueName': leagueName
  };
}