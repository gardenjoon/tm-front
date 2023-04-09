import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:tm_front/models/profile_model.dart';

class ProfileService {
  static const String baseUrl = 'http://data.pknu.ac.kr:7443/api/user';

  static Future<ProfileModel> getProfile(String id) async {
    final url = Uri.parse('$baseUrl/profile/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final profile = jsonDecode(response.body);
      return ProfileModel.fromJson(profile["data"]);
    } else {
      throw Error();
    }
  }
}
