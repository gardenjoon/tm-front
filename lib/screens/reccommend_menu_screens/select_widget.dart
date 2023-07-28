import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/buttons/get_button.dart';
import 'package:tm_front/components/buttons/reset_button.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/components/textcomponents.dart/custom_text_form_field.dart';
import 'package:tm_front/screens/reccommend_menu_screens/hashtag_box.dart';
import 'package:tm_front/screens/reccommend_menu_screens/size_animation_widget.dart';
import 'package:tm_front/controller/rcmd_menu_controller.dart';

class SelectWidget extends StatelessWidget {
  final RcmdMenuController controller = Get.put(RcmdMenuController());

  SelectWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final menuStyles = controller.menuStyles.keys.toList();
    return Obx(() => Draggable(
        feedback: SizedBox(),
        onDragUpdate: (details) => details.delta.dy < 0
            ? controller.toggledGetMenu.value = false
            : controller.toggledGetMenu.value = true,
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30)),
            color: Palette.white,
            boxShadow: [BoxShadow(blurRadius: 6, color: Palette.greySub)],
          ),
          child: Column(
            children: [
              SizeAnimationWidget(
                expand: controller.toggledGetMenu.value,
                curve: Curves.fastOutSlowIn,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    titleStyle('한끼 총 섭취량'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: CustomTextFormField(
                          hint: '${controller.defaultCalorie} (권장 섭취량의 1/3)',
                          onChanged: (value) =>
                              controller.saveCalorie(int.tryParse(value) ?? 0),
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                          ],
                          suffixIcon: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('kcal'),
                              ])),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        titleStyle('식단 스타일 선택'),
                        ResetButton(func: controller.resetAll)
                      ],
                    ),
                    Row(
                      children: List.generate(menuStyles.length,
                          (index) => chooseStyle(title: menuStyles[index])),
                    ),
                    titleStyle('퍼스널 해시태그'),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 20),
                      child: HashTagBox(),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  getButton(func: controller.loadMenu, title: '식단 추천 받기'),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                          vertical: 10, horizontal: Get.width / 3.6),
                      width: Get.width / 3,
                      height: 5,
                      decoration: BoxDecoration(
                          color: Palette.greyMain,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                  ),
                ],
              )
            ],
          ),
        )));
  }

  Text titleStyle(String text) {
    return Text(
      text,
      style: TextStyle(fontSize: 20),
    );
  }
}

class chooseStyle extends StatelessWidget {
  chooseStyle({
    super.key,
    required this.title,
  });

  final String title;
  final RcmdMenuController controller = Get.put(RcmdMenuController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => Flexible(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 10, left: 8, right: 8, bottom: 20),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: GestureDetector(
                onTap: () => controller.toggleStyle(title),
                child: Container(
                    decoration: BoxDecoration(
                      color: controller.menuStyles[title]
                          ? Palette.main
                          : Palette.greySub,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Center(
                        child: Text(
                      title,
                      style: TextStyle(
                        fontSize: 20,
                        color: controller.menuStyles[title]
                            ? Palette.white
                            : Palette.black,
                      ),
                    ))),
              ),
            ),
          ),
        ));
  }
}
