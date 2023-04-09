import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tm_front/models/body_model.dart';
import 'package:tm_front/models/menu_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RcmdMenuService {
  static const String baseUrl = 'http://data.pknu.ac.kr:7443/api/menu';

  static Future<BodyModel> getBodyInfo(String id) async {
    final url = Uri.parse('$baseUrl/bodyInfo/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body)["data"][0];
      return BodyModel.fromJson(body);
    } else {
      throw Error();
    }
  }

  static Future<List<dynamic>> getMeal(String id, String meal) async {
    meal = meal == '아침'
        ? 'breakfast'
        : meal == '점심'
            ? 'lunch'
            : 'dinner';
    final url = Uri.parse('$baseUrl/$meal/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return json.decode(response.body)["data"];
    } else {
      throw Error();
    }
  }

  static Future<List<MenuModel>> getBreakfast(String id) async {
    final url = Uri.parse('$baseUrl/lunch/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List menus = jsonDecode(response.body)["data"];
      return menus.map((e) {
        e["food_grop_cd"] ??= "total";
        e["fi_nm"] ??= "total";
        return MenuModel.fromJson(e);
      }).toList();
    } else {
      throw Error();
    }
  }

  static Future<List<MenuModel>> getLunch(String id) async {
    final url = Uri.parse('$baseUrl/lunch/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List menus = jsonDecode(response.body)["data"];
      return menus.map((e) {
        e["food_grop_cd"] ??= "total";
        e["fi_nm"] ??= "total";
        return MenuModel.fromJson(e);
      }).toList();
    } else {
      throw Error();
    }
  }

  static Future<List<MenuModel>> getDinner(String id) async {
    final url = Uri.parse('$baseUrl/dinner/$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final List<dynamic> menus = jsonDecode(response.body)["data"];
      return menus.map((e) {
        e["food_grop_cd"] ??= "total";
        e["fi_nm"] ??= "total";
        return MenuModel.fromJson(e);
      }).toList();
    } else {
      throw Error();
    }
  }

  
}
