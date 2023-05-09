import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:get/get.dart';
import 'package:tm_front/models/login_model.dart';

class LoginService {
  static const String baseUrl = 'http://data.pknu.ac.kr:7443/api/user';

  static Future<dynamic> checkId(String lgnId) async {
    try {
      final url = Uri.parse('$baseUrl/checkLgnId/$lgnId');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['data']['message'];
      } else {
        final result = jsonDecode(response.body);
        return result['error']['message'];
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> signUp() async {
    try {
      final url = Uri.parse('$baseUrl/signup');
      final loginData = Get.put(LoginRequestData());
      final activityData = Get.put(ActivityData());

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'loginData': loginData.data,
            'activityData': activityData.data,
          }));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['data'];
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<dynamic> signIn() async {
    try {
      final url = Uri.parse('$baseUrl/signIn');
      final loginData = Get.put(LoginRequestData());

      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'id': loginData.data['id'],
            'password': loginData.data['password'],
          }));

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['data'];
      } else {
        return false;
      }
    } catch (e) {
      rethrow;
    }
  }
}
