import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:tm_front/controller/user_controller.dart';
import 'package:tm_front/models/allergy.dart';
import 'package:tm_front/models/exercise.dart';
import 'package:tm_front/models/profile.dart';

class ProfileRepository {
  static final ProfileRepository _instance = ProfileRepository._internal();
  factory ProfileRepository() {
    return _instance;
  }
  ProfileRepository._internal();

  static const String baseUrl = 'https://data.pknu.ac.kr:7443/api/user';

  Future<bool> checkId(String account) async {
    try {
      final url = Uri.parse('$baseUrl/checkLgnId/$account');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final result = jsonDecode(response.body);
        return result['data']['message'];
      }
      return false;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> getProfile(String id) async {
    try {
      final controller = Get.put(UserController());
      final url = Uri.parse('$baseUrl/getProfile/$id');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final profile = jsonDecode(response.body);
        controller.userProfile.value = Profile.fromJson(profile['data']);

        controller.selectedAllergy.value = [];
        profile['data']['userAllergyInfos'].forEach((value) {
          controller.selectedAllergy.add(Allergy.fromJson(value));
        });

        controller.exerciseData.value =
            Exercise.fromJson(profile['data']['userExercise']);

      } else {
        throw Error();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> updateProfile(String userId) async {
    try {
      final controller = Get.put(UserController());
      final url = Uri.parse('$baseUrl/updateProfile');
      final response = await http.post(url,
          headers: {
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            'user_id': userId,
            'profile': controller.userProfile.value,
            'allergy': controller.selectedAllergy
                .map((element) => element.toJson())
                .toList(),
            'exercise': controller.exerciseData.value.toJson()
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

  Future<List<AllergySet>> getAllergy() async {
    try {
      final url = Uri.parse('$baseUrl/getAllergy');
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);

        return jsonResponse['data'].map<AllergySet>((json) {
          json['allergyInfos'] = json['allergyInfos']
              .map<Allergy>((allergy) => Allergy.fromJson(allergy))
              .toList();
          return AllergySet.fromJson(json);
        }).toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
