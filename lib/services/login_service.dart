import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:tm_front/controller/user_controller.dart';
import 'package:tm_front/models/login.dart';

class LoginRepository {
  static final LoginRepository _instance = LoginRepository._internal();
  factory LoginRepository() {
    return _instance;
  }
  LoginRepository._internal();

  static const String baseUrl = 'https://data.pknu.ac.kr:7443/api/user';

  Future<String> signIn() async {
    final dio = Dio(BaseOptions(baseUrl: baseUrl));
    try {
      final controller = Get.put(UserController());
      final response = await dio.post(
        '/signIn',
        data: jsonEncode(
          {
            'account': controller.userAccount.value,
            'password': controller.userPassword.value,
          },
        ),
      );
      if (response.statusCode == 200) {
        var token = response.data['data'];
        final payload = JwtDecoder.decode(token);
        controller.userId.value = payload['id'];
        final value = json.encode(Login(user_id: payload['id'], token: token));
        return value;
      }
      return '';
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<String> signUp() async {
    final dio = Dio();
    try {
      final controller = Get.put(UserController());
      final response = await dio.post(
        '$baseUrl/signUp',
        data: {
          'profile': controller.userProfile.value,
          'allergy': controller.selectedAllergy
              .map((element) => element.toJson())
              .toList(),
          'exercise': controller.exerciseData.value.toJson()
        },
        options: Options(contentType: Headers.jsonContentType),
      );

      if (response.statusCode == 200) {
        var token = response.data['data'];
        final payload = JwtDecoder.decode(token);
        final value = json.encode(Login(user_id: payload['id'], token: token));
        return value;
      }
      return '';
    } catch (e) {
      rethrow;
    }
  }
}
