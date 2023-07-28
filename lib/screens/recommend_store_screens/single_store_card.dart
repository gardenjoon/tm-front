import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/controller/location_controller.dart';
import 'package:tm_front/models/marker.dart';

class SingleStoreCard extends StatelessWidget {
  SingleStoreCard({
    super.key,
    required this.marker,
  });

  final CustomMarker marker;

  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        marker.onTap!();
      },
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 18),
          title: Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    marker.place_name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    marker.distance! > 1000.0
                        ? '${(marker.distance! / 1000).toPrecision(2)}km'
                        : '${marker.distance!.toInt()}m',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              )),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (marker.menus != null)
                Text(
                  '${marker.menus![0].menu_name}',
                  style: TextStyle(color: Palette.black),
                ),
              Text(marker.road_address_name ?? '-'),
              Text(marker.category_name ?? '-'),
              Text(marker.phone!),
            ],
          ),
        ),
      ),
    );
  }
}
