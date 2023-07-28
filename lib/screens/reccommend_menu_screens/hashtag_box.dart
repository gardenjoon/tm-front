import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/controller/rcmd_menu_controller.dart';

class HashTagBox extends StatelessWidget {
  final RcmdMenuController controller = Get.put(RcmdMenuController());
  HashTagBox({super.key});

  @override
  Widget build(BuildContext context) {
    final tags = controller.tags.keys.toList();
    return Wrap(
        direction: Axis.horizontal,
        children: List.generate(
            tags.length, (index) => tagWidget(text: tags[index])));
  }

  Widget tagWidget({required String text}) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
        child: GestureDetector(
          onTap: () => controller.toggleTag(text),
          child: Container(
            padding: EdgeInsets.symmetric(
              vertical: 2,
              horizontal: 10,
            ),
            height: 30,
            decoration: BoxDecoration(
              color: controller.tags[text] ? Palette.main : Palette.greySub,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '#$text',
                  style: TextStyle(
                      fontSize: 14,
                      color: controller.tags[text]
                          ? Palette.white
                          : Palette.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
