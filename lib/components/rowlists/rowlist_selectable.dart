import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/rowlists/rowlist_shared.dart';
import 'package:tm_front/components/textcomponents.dart/custom_chip.dart';
import 'package:tm_front/components/textcomponents.dart/rectangle_button.dart';
import 'package:tm_front/controller/user_controller.dart';
import 'package:tm_front/screens/login_screens/choose_food.dart';

class RowListSelectable extends StatelessWidget {
  RowListSelectable({
    super.key,
    required this.buttonTitle,
    required this.title,
    required this.formName,
    required this.isDivider,
  });
  final String title;
  final String formName;
  final String buttonTitle;
  final bool isDivider;
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
    return Container(
      margin: EdgeInsets.only(
        top: 10,
        bottom: 20,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RowListTitle(
                title: title,
                isPad: true,
              ),
              RectangleButton(
                title: buttonTitle,
                callback: () => openBottomSheet(
                  ChooseFood(
                    dataList: controller.allergyList,
                    title: '$title $buttonTitle',
                  ),
                ),
              )
            ],
          ),
          //   선택된 아이템 표시
          Obx(
            () => Wrap(
              direction: Axis.horizontal,
              children: List.generate(
                controller.selectedAllergy.length,
                (cIndex) {
                  return CustomChip(
                    title: controller.selectedAllergy[cIndex].allergy_name!,
                  );
                },
              ),
            ),
          )
        ],
      ),
    );
  }
}

Future<void> openBottomSheet(Widget widget) async {
  await Get.bottomSheet(
    widget,
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
  );
}
