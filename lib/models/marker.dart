import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarker extends Marker {
  @override
  final MarkerId markerId;

  @override
  final LatLng position;

  @override
  BitmapDescriptor icon;

  @override
  var onTap;

  late final String address_name;
  late final String place_name;
  late final String? category_group_code;
  late final String? category_group_name;
  late final String? category_name;
  final double? distance;
  final String? phone;
  final String? place_url;
  final String? road_address_name;
  final int index;
  final List<RestMenu>? menus;

  CustomMarker({
    required this.markerId,
    required this.position,
    required this.icon,
    required this.address_name,
    required this.place_name,
    this.onTap,
    this.category_group_name,
    this.category_name,
    this.distance,
    this.phone,
    this.place_url,
    this.road_address_name,
    this.index = -1,
    this.menus,
  }) : super(
            markerId: markerId,
            position: position,
            icon: icon,
            onTap: onTap);

  CustomMarker.fromJson(Map<String, dynamic> json, {int index = -1, icon})
      : markerId = MarkerId(json['id'].toString()),
        position = LatLng(double.parse(json['y']), double.parse(json['x'])),
        icon = icon,
        address_name = json['address_name'],
        category_group_code = json['category_group_code'],
        category_group_name = json['category_group_name'],
        category_name = json['category_name'],
        distance = double.tryParse(json['distance']) ?? 0.0,
        phone = json['phone'],
        place_name = json['place_name'],
        place_url = json['place_url'],
        road_address_name = json['road_address_name'],
        index = index,
        menus = json['menus'],
        super(
          markerId: MarkerId(index.toString()),
          position: LatLng(double.parse(json['y']), double.parse(json['x'])),
          icon: icon,
        );
}

class RestMenu {
  final int id;
  final int rest_id;
  final String menu_name;
  final int menu_price;
  final String? description;

  RestMenu({
    required this.id,
    required this.rest_id,
    required this.menu_name,
    required this.menu_price,
    this.description,
  });

  RestMenu.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        rest_id = json['resId'],
        menu_name = json['menuName'],
        menu_price = json['menuPrice'],
        description = json['description'];

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['resId'] = rest_id;
    data['menuName'] = menu_name;
    data['menuPrice'] = menu_price;
    data['description'] = description;

    return data;
  }
}
