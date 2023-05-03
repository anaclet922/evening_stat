class DefaultsModel {
  bool sound;
  int league;
  int timer;

  DefaultsModel(
      { required this.sound,
        required this.league,
        required this.timer});

  Map<String, dynamic> toJson() => <String, dynamic>{
    'sound': sound,
    'league': league,
    'timer': timer
  };
}