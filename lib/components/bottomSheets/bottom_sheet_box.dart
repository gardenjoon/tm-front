import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet {
  Future<int?> openCustomBottomSheet({required Widget widget}) async {
    return await Get.bottomSheet(
      widget,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
      ),
    );
  }
}
