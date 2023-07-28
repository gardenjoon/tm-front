class Exercise {
  ExerciseDHM hard;
  ExerciseDHM middle;
  ExerciseDHM walk;

  Exercise({
    required this.hard,
    required this.middle,
    required this.walk,
  });

  Exercise.fromJson(Map<dynamic, dynamic> json)
      : hard = ExerciseDHM(
          days: json['wkHgAct'],
          hours: json['dyHgActHr'],
          minutes: json['dyHgActMn'],
        ),
        middle = ExerciseDHM(
          days: json['wkMdAct'],
          hours: json['dyMdActHr'],
          minutes: json['dyMdActMn'],
        ),
        walk = ExerciseDHM(
          days: json['wkWalk'],
          hours: json['dyWalkHr'],
          minutes: json['dyWalkMn'],
        );

  Map<String, dynamic> toJson() {
    final data = <String, Map<String, int>>{};
    data['hard'] = {
      'days': hard.days,
      'hours': hard.hours,
      'minutes': hard.minutes,
    };
    data['middle'] = {
      'days': middle.days,
      'hours': middle.hours,
      'minutes': middle.minutes,
    };
    data['walk'] = {
      'days': walk.days,
      'hours': walk.hours,
      'minutes': walk.minutes,
    };

    return data;
  }
}

class ExerciseDHM {
  int days;
  int hours;
  int minutes;

  ExerciseDHM({
    this.days = 0,
    this.hours = 0,
    this.minutes = 0,
  });
}
