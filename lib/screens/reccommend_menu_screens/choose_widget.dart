import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/controller/rcmd_menu_controller.dart';
import 'package:tm_front/screens/reccommend_menu_screens/menu_card_animation.dart';

class ChooseWidget extends StatelessWidget {
  ChooseWidget({super.key});

  final RcmdMenuController controller = Get.put(RcmdMenuController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Container(
          constraints: BoxConstraints.expand(
              height: MediaQuery.of(context).size.height * 2 / 3),
          child: ListView.builder(
            itemCount: controller.menuSet.length,
            itemBuilder: ((context, index) {
              return MenuCardAnimation(
                menuSet: controller.menuSet[index],
                menuSetIndex: index,
              );
            }),
          ),
        ));
  }
}
