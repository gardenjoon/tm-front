class BodyModel {
  final String bdwg;
  final String bmi;
  final String avgKg;
  final String bodyActy;
  final String avgCal;
  final String mealCal;

  BodyModel.fromJson(Map<dynamic, dynamic> json)
      : bdwg = json['bdwg'],
        bmi = json['bmi'],
        avgKg = json['avg_kg'],
        bodyActy = json['body_acty'],
        avgCal = json['avg_cal'],
        mealCal = json['meal_cal'];
}
