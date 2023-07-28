import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/controller/rcmd_menu_controller.dart';

import 'single_menu_card.dart';

class ChooseMenuBottomSheetWidget extends StatelessWidget {
  ChooseMenuBottomSheetWidget({super.key, required this.controller});

  final RcmdMenuController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '비슷한 메뉴 교체',
                style: TextStyle(
                  fontSize: 20,
                  color: Palette.main,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: controller.singleMenuList.length,
                itemBuilder: (context, index) {
                  return SingleMenuCard(
                      menu: controller.singleMenuList[index],
                      isClicked: RxBool(true),
                      onTapUp: () {
                        Get.back(result: index);
                      });
                },
              ),
            )
          ],
        ));
  }
}
