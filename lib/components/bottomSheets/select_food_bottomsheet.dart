import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/screens/login_screens/choose_food.dart';
import 'package:tm_front/services/shared_service.dart';

Future<void> selectFoodBottomSheet(List formList, String formName) async {
  List updatedData = await Get.bottomSheet(
    ChooseFood(dataList: formList, formName: formName),
    backgroundColor: Palette.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
  );
  final loginData = Get.put(LoginRequestData());
  loginData.updateData(formName, updatedData);
  SharedService.saveData(formName, updatedData);
}
