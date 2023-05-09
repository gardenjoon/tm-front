import 'package:get/get.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

class LoginRequestData extends GetxController {
  RxMap<String, dynamic> data = {
    'name': '',
    'id': '',
    'email': '',
    'password': '',
    'birth': '20000101',
    'tall': 0,
    'weight': 0,
    'gender': '',
    'like': [],
    'hate': [],
    'allergy': [],
  }.obs;

  addData(formName, foodName) {
    data[formName].add(foodName);
  }

  removeData(formName, foodName) {
    data[formName].remove(foodName);
  }

  updateData(formName, updatedData) {
    data[formName] = updatedData;
  }
}

class ActivityData extends GetxController {
  RxMap<String, dynamic> data = {
    'hardTimes': {
      'days': 0,
      'hours': 0,
      'minutes': 0,
    },
    'softTimes': {
      'days': 0,
      'hours': 0,
      'minutes': 0,
    },
    'walkTimes': {
      'days': 0,
      'hours': 0,
      'minutes': 0,
    },
  }.obs;
}

class Login {
  static securePassword(String password) {
    final key = utf8.encode(password);
    final bytes = utf8.encode(sha256.convert(key).toString());

    var hamcSha256 = Hmac(sha256, key);
    return hamcSha256.convert(bytes).toString();
  }

  static genderCodeToString(String genderCode) {
    Map<String, String> genderMap = {'10': '남자', '20': '여자', '30': '임산부'};
    return genderMap[genderCode];
  }
}
