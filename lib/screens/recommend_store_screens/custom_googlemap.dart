import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:tm_front/controller/location_controller.dart';
import 'package:tm_front/screens/recommend_store_screens/marker_widget.dart';

class CustomGoogleMap extends StatelessWidget {
  CustomGoogleMap({
    super.key,
  });

  final LocationController controller = Get.put(LocationController());
  final globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
        height: Get.height * 42 / 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Stack(
          children: [
            // CustomMarkerWidget(onFinishRendering: (_setMarkerIcons)),
            GoogleMap(
              onMapCreated: controller.onMapCreated,
              initialCameraPosition: CameraPosition(
                target: controller.currentLocation.value,
                zoom: 15.0,
              ),
              gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>{
                Factory<OneSequenceGestureRecognizer>(
                  () => EagerGestureRecognizer(),
                ),
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              markers: controller.markers.toSet(),
            )
          ],
        )
        //   NaverMap(
        //     options: NaverMapViewOptions(
        //       initialCameraPosition: NCameraPosition(
        //         target: controller.currentLocation.value,
        //         zoom: 15,
        //         bearing: 0,
        //         tilt: 0,
        //       ),
        //       locationButtonEnable: true,
        //       logoClickEnable: false,
        //       scaleBarEnable: false,
        //     ),
        //     onMapReady: (NaverMapController naverMapController) {
        //       print('네이버 맵 로딩완료');
        //       controller.currentLocation.listen((p0) {
        //         controller.moveCameraFunc(
        //           naverMapController,
        //           controller.currentLocation.value,
        //         );
        //         controller.updateMap.value = true;
        //       });
        //       controller.updateMap.listen((p0) {
        //         controller.setMarkers(naverMapController);
        //         controller.updateMap.value = false;
        //       });
        //     },
        //     onCameraChange: (reason, animated) {
        //       controller.cameraChangeCount.value++;
        //       if (reason == NCameraUpdateReason.gesture &&
        //           controller.cameraChangeCount.value > 40) {
        //         controller.updateMap.value = true;
        //         controller.cameraChangeCount.value = 0;
        //       }
        //     },
        //     forceGesture: true,
        //   ),
        ));
  }
}
