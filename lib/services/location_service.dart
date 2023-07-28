import 'package:custom_marker/marker_icon.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tm_front/controller/location_controller.dart';
import 'package:tm_front/models/marker.dart';

class LocationRepository {
  static final LocationRepository _instance = LocationRepository._internal();
  factory LocationRepository() {
    return _instance;
  }
  LocationRepository._internal();

  static const String baseUrl = 'https://data.pknu.ac.kr:7443/api/map';

  Future<void> getLocationByAddress({required String address}) async {
    final dio = Dio();
    try {
      var uri = '$baseUrl/search/getaddress/query/{query}?query=$address';

      final response = await dio.get(uri);

      if (response.statusCode == 200) {
        print(response);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> getAddressByLocation({
    required double x,
    required double y,
  }) async {
    final dio = Dio();
    try {
      final url = '$baseUrl/getregion/x/{x}/y/{y}?x=$x&y=$y';
      final response = await dio.get(url);
      print(response);

      if (response.statusCode == 200) {
        print(response);
      }
    } catch (e) {
      print(e);
    }
  }

  Future<void> searchStoresByLocation({
    required String query,
    double? x,
    double? y,
    int? radius,
    String? rect,
    int? size,
  }) async {
    final dio = Dio();
    try {
      var uri =
          '$baseUrl/search/query/{query}/x/{x}/y/{y}/radius/{radius}/rect/{rect}/size/{size}?query=$query';
      x != null ? uri += '&x=$x' : null;
      y != null ? uri += '&y=$y' : null;
      radius != null ? uri += '&radius=$radius' : null;
      rect != null ? uri += '&rect=$rect' : null;
      size != null ? uri += '&size=$size' : null;

      final response = await dio.get(uri);

      final controller = Get.put(LocationController());

      if (response.statusCode == 200) {
        if (controller.markers.isNotEmpty) controller.markers.clear();

        // final customIcon = await controller.getDefaultIcon();

        for (var i = 0; i < response.data['documents'].length; i++) {
          final globalKey = GlobalKey();
          final customIcon = await MarkerIcon.widgetToIcon(globalKey);
          var marker = response.data['documents'][i];
          if (marker['menus'] != null) {
            marker['menus'] = marker['menus']
                .map<RestMenu>((menu) => RestMenu.fromJson(menu))
                .toList();
          }
          controller.markers
              .add(CustomMarker.fromJson(marker, index: i, icon: customIcon));
        }
        controller.onTapMarker();
      }
    } catch (e) {
      print(e);
    }
  }
}
