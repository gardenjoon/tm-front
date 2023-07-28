import 'package:dio/dio.dart';
import 'package:tm_front/models/menu.dart';

class MenuRepository {
  static final MenuRepository _instance = MenuRepository._internal();
  factory MenuRepository() {
    return _instance;
  }
  MenuRepository._internal();

  static const String baseUrl = 'https://data.pknu.ac.kr:7443/api/menu';

  Future<List<MenuSet>> getMenu({
    required String id,
    required String styles,
    required String tags,
    required int calorie,
  }) async {
    final dio = Dio();
    try {
      final uri =
          '$baseUrl/getMenu/id/{id}/style/{styles}/tags/{tags}/calorie/{calorie}?id=$id&styles=$styles&tags=$tags&calorie=$calorie';
      final response = await dio.get(uri);

      if (response.statusCode == 200) {
        if (response.data['data'] == []) {
          return [];
        }
        return response.data['data']
            .map<MenuSet>((json) => MenuSet.fromJson(json))
            .toList();
      }
    } catch (e) {
      print(e);
    }
    return [];
  }
}
