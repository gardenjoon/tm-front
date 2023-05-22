import 'dart:convert';

import 'package:dio/dio.dart';

class CheckService {
  static const String baseUrl = 'http://data.pknu.ac.kr:7443/api/check';

  static Future<dynamic> uploadImg(dynamic img) async {
    final dio = Dio();
    try {
      dio.options.contentType = 'multipart/form-data';

      final response = await dio.post(
        baseUrl + '/upload',
        data: img,
      );

      final predictResult = response.data['data']['prediction'];
      final imageData = response.data['data']['image'];
      final sum = response.data['data']['sum'];

      return [predictResult, base64Decode(imageData), sum];
    } catch (e) {
      rethrow;
    }
  }
}
