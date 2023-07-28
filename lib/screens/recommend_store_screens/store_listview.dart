import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tm_front/controller/location_controller.dart';
import 'package:tm_front/screens/recommend_store_screens/single_store_card.dart';

class StoreListView extends StatelessWidget {
  StoreListView({
    super.key,
  });

  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.markers.isNotEmpty
        ? Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: controller.autoScrollController,
              itemCount: controller.markers.length,
              itemBuilder: (context, index) {
                return AutoScrollTag(
                  key: ValueKey(index),
                  controller: controller.autoScrollController,
                  index: index,
                  child: Container(
                    width: Get.width * 60 / 100,
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 6),
                    child: SingleStoreCard(
                      marker: (controller.markers.toList())[index],
                    ),
                  ),
                );
              },
            ),
          )
        : SizedBox());
  }
}
