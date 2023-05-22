import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/models/profile_model.dart';

class ProfileService {
  static const String baseUrl = 'http://data.pknu.ac.kr:7443/api/user';

  static Future<ProfileModel> getProfile(String id) async {
    try {
      final url = Uri.parse('$baseUrl/getProfile/$id');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final profile = jsonDecode(response.body);
        return ProfileModel.fromJson(profile['data']);
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  static Future<bool> updateProfile(String userId) async {
    try {
      final url = Uri.parse('$baseUrl/updateProfile');
      final loginData = Get.put(LoginRequestData());
      final activityData = Get.put(ActivityData());
      print(userId);
      print(loginData.data);
      print(activityData.data);
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'userId': userId,
            'loginData': loginData.data,
            'activityData': activityData.data,
          }));

      if (response.statusCode == 200) {
        return true;
      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }
}
