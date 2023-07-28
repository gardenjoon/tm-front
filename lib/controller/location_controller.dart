import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:scroll_to_index/scroll_to_index.dart';
import 'package:tm_front/models/marker.dart';
import 'package:tm_front/services/location_service.dart';
import 'dart:ui' as ui;

class LocationController extends GetxController {
  late LocationRepository _locationRepository;
  late AutoScrollController autoScrollController;
  late GoogleMapController mapController;

  @override
  void onInit() async {
    super.onInit();
    await getCurrentLocation();
    _locationRepository = LocationRepository();
    autoScrollController = AutoScrollController();
  }

  Future<void> onMapCreated(GoogleMapController controller) async {
    mapController = controller;
    var _mapStyle = await rootBundle.loadString('assets/map.json');
    await controller.setMapStyle(_mapStyle);
    await getCameraBounds(controller);
    print(currentBounds);
    await setMarkers();
  }

  Rx<LatLng> currentLocation = LatLng(35.1344215, 129.1031124).obs;
  Rx<LatLngBounds> currentBounds = LatLngBounds(
          southwest: LatLng(35.12655953907006, 129.09867066191168),
          northeast: LatLng(35.14228270184407, 129.10755413808693))
      .obs;
  RxBool updateMap = false.obs;
  RxInt cameraChangeCount = 0.obs;
  RxString searchQuery = '술'.obs; // TODO: 기본값 '' 로 변경
  GlobalKey globalKey = GlobalKey();

  RxSet<CustomMarker> markers = <CustomMarker>{}.obs;
  Future<void> getCurrentLocation() async {
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
    try {
      var position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
      currentLocation.value = LatLng(position.latitude, position.longitude);
    } catch (e) {
      print(e);
    }
  }

//   void addMarker(LatLng point) {
//     markers.add(Marker(
//       markerId: MarkerId(
//         point.toString(),
//       ),
//       position: point,
//       onTap: () {
//         markers.removeWhere(
//             (marker) => marker.markerId == MarkerId(point.toString()));
//         markers.add(Marker(
//           markerId: MarkerId(point.toString()),
//           position: point,
//           icon: BitmapDescriptor.defaultMarkerWithHue(
//             BitmapDescriptor.hueGreen,
//           ),
//         ));
//       },
//     ));
//   }

  Future<BitmapDescriptor> getDefaultIcon() async {
    final byteData = await rootBundle.load('assets/images/location_circle.png');
    var codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List(),
        targetWidth: 100);
    var fi = await codec.getNextFrame();
    final resizedImageData =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();

    return BitmapDescriptor.fromBytes(resizedImageData);
  }

  Future<BitmapDescriptor> getOnClickedIcon() async {
    final byteData = await rootBundle.load('assets/images/location_drop.png');
    var codec = await ui.instantiateImageCodec(byteData.buffer.asUint8List(),
        targetWidth: 100);
    var fi = await codec.getNextFrame();
    final resizedImageData =
        (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
            .buffer
            .asUint8List();

    return BitmapDescriptor.fromBytes(resizedImageData);
  }

//   void markerActive({
//     required Marker marker,
//     required bool active,
//   }) {
//     if (active == true) {
//       marker.setIcon(clickedLocationImage);
//       marker.setCaptionOffset(6);
//       marker.setSize(Size(48, 48));
//       marker.setAnchor(NPoint(0.5, 1.0));
//       marker.setGlobalZIndex(200001);
//     } else {
//       marker.setIcon(defaultLocationImage);
//       marker.setCaptionOffset(0);
//       marker.setSize(Size(36, 36));
//       marker.setAnchor(NPoint(0.5, 0.5));
//       marker.setGlobalZIndex(200000);
//     }
//   }

  void onTapMarker() async {
    markers.toList().asMap().entries.map((entry) async {
      entry.value.onTap = () async {
        entry.value.icon = await getOnClickedIcon();
        await mapController
            .moveCamera(CameraUpdate.newLatLng(entry.value.position));
        await autoScrollController.scrollToIndex(
          entry.key,
          preferPosition: AutoScrollPosition.middle,
        );
      };
    }).toSet();
  }

  Future<void> setMarkers() async {
    // if (searchQuery.value == '') return;
    print('called setMarkers');

    await _locationRepository.searchStoresByLocation(
      query: searchQuery.value,
      x: currentLocation.value.longitude,
      y: currentLocation.value.latitude,
      rect:
          '${currentBounds.value.southwest.longitude},${currentBounds.value.southwest.latitude},${currentBounds.value.northeast.longitude},${currentBounds.value.northeast.latitude}',
      size: 15,
    );

    // // 구글 마커
    final marker = Marker(
      markerId: MarkerId('1'),
      infoWindow: InfoWindow(title: '맛집'),
      position: LatLng(35.1344215, 129.1031124),
      onTap: () {},
    );

    // markers.add(marker);

    // // 네이버 마커
    // await controller.addOverlayAll(markerSets);

    // markerSets.forEach(
    //   (element) => element.setOnTapListener(
    //     (NMarker marker) async {
    //       print('clicked ${element.place_name}');
    //       markerSets.forEach((e) => markerActive(marker: e, active: false));
    //       markerActive(marker: element, active: true);
    //       moveCameraFunc(controller, marker.position);
    //       await autoScrollController.scrollToIndex(
    //         element.index,
    //         preferPosition: AutoScrollPosition.middle,
    //       );
    //     },
    //   ),
    // );
  }

//   void moveCameraFunc(NaverMapController controller, NLatLng latLng) async {
//     await controller.updateCamera(
//       NCameraUpdate.withParams(
//         target: latLng,
//       ),
//     );
//     print('Camera moved to $latLng');
//   }

  Future<void> getCameraBounds(GoogleMapController controller) async {
    currentBounds.value = await mapController.getVisibleRegion();

    // return LatLngBounds(southwest: LatLng(0, 0), northeast: LatLng(0, 0));
  }
}
