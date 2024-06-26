class PositionModel {
  String groupName;
  List<RowsModel> rows;

  PositionModel(
      {required this.groupName,
        required this.rows});

}

class RowsModel {
  String position;
  String win;
  String loss;
  String goalsPlus;
  String goalsMinus;
  String score;
  String pct;
  int goalDiffTotal;
  double pctGoalsTotal;
  String teamId;
  String teamName;
  String teamImage;

  RowsModel(
      {required this.position,
      required this.win,
      required this.loss,
      required this.goalsPlus,
      required this.goalsMinus,
      required this.score,
      required this.pct,
      required this.goalDiffTotal,
      required this.pctGoalsTotal,
      required this.teamId,
      required this.teamName,
      required this.teamImage});

}
