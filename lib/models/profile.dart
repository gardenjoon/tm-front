import 'package:date_format/date_format.dart';

class Profile {
  String? userId;
  String? account;
  String user_name = '사용자';
  String? pwd;
  String? email;
  int? gender;
  String? birth;
  int? height;
  int? weight;

  Profile({
    this.userId,
    this.account,
    this.user_name = '사용자',
    this.pwd,
    this.email,
    this.gender,
    this.birth,
    this.height,
    this.weight,
  });

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['userId'] = userId;
    data['account'] = account;
    data['user_name'] = user_name;
    data['pwd'] = pwd;
    data['email'] = email;
    data['gender'] = gender;
    data['birth'] = birth;
    data['height'] = height;
    data['weight'] = weight;

    return data;
  }

  Profile.fromJson(Map<dynamic, dynamic> json)
      : userId = json['userId'],
        account = json['account'],
        user_name = json['userName'],
        pwd = json['pwd'],
        email = json['email'],
        gender = json['gender'],
        birth = formatDate(DateTime.parse(json['birth']), [yyyy, mm, dd]),
        height = json['height'],
        weight = json['weight'];

  Profile.fromMap(Map<String, dynamic> profile)
      : userId = profile['userId'],
        account = profile['account'],
        user_name = profile['user_name'],
        pwd = profile['pwd'],
        email = profile['email'],
        gender = profile['gender'],
        birth = profile['birth'],
        height = profile['height'],
        weight = profile['weight'];
}
