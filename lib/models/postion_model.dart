class PositionModel {
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

  PositionModel(
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

  Map<String, dynamic> toJson() => <String, dynamic>{
        'position': position,
        'win': win,
        'loss': loss,
        'goalsPlus': goalsPlus,
        'goalsMinus': goalsMinus,
        'score': score,
        'pct': pct,
        'goalDiffTotal': goalDiffTotal,
        'pctGoalsTotal': pctGoalsTotal,
        'teamId': teamId,
        'teamName': teamName,
        'teamImage': teamImage,
      };
}
