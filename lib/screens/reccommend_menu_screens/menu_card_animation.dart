import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/bottomSheets/bottom_sheet_box.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/controller/rcmd_menu_controller.dart';
import 'package:tm_front/models/menu.dart';
import 'package:tm_front/screens/reccommend_menu_screens/choose_menu_bottom_sheet_widget.dart';
import 'package:tm_front/screens/reccommend_menu_screens/single_menu_card.dart';
import 'package:tm_front/screens/reccommend_menu_screens/size_animation_widget.dart';

import 'size_animation_button.dart';

class MenuCardAnimation extends StatelessWidget {
  MenuCardAnimation({
    super.key,
    required this.menuSet,
    required this.menuSetIndex,
  });

  final MenuSet menuSet;
  final int menuSetIndex;

  final RcmdMenuController controller = Get.put(RcmdMenuController());

  final RxBool menuSelected = false.obs;

  final RxBool isChildClicked = false.obs;

  void onClickedMenu() {
    if (isChildClicked.value == false) {
      menuSelected.value = !menuSelected.value;
    }
    isChildClicked.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RcmdMenuController>(
        builder: (controller) => Obx(
              () => GestureDetector(
                onTap: onClickedMenu,
                child: Card(
                  color: Palette.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin:
                      EdgeInsets.only(top: 12, left: 14, right: 14, bottom: 12),
                  child: ListTile(
                    contentPadding: EdgeInsets.only(top: 10, left: 8, right: 8),
                    minVerticalPadding: 10,
                    isThreeLine: true,
                    title: Container(
                      color: Colors.white,
                      padding: const EdgeInsets.only(
                          bottom: 10, left: 14, right: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(menuSet.style,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(
                            '${menuSet.total_calorie} kcal',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 14, right: 14),
                          child: showHashtagTexts(menuSet.tags),
                        ),
                        SizeAnimationWidget(
                          expand: menuSelected.value,
                          child: Column(
                            children: List.generate(
                              menuSet.menus.length,
                              (index) {
                                return SingleMenuCard(
                                  menu: menuSet.menus[index],
                                  isClicked: isChildClicked,
                                  onTapUp: () {
                                    CustomBottomSheet()
                                        .openCustomBottomSheet(
                                      widget: GetBuilder<RcmdMenuController>(
                                        init: controller,
                                        builder: (controller) =>
                                            ChooseMenuBottomSheetWidget(
                                          controller: controller,
                                        ),
                                      ),
                                    )
                                        .then(
                                      (newIndex) {
                                        if (newIndex != null) {
                                          controller.changeMenu(
                                            menuSetIndex: menuSetIndex,
                                            oldMenuIndex: index,
                                            newMenuIndex: newIndex,
                                          );
                                        }
                                      },
                                    );
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                        SizeAnimationButton(
                          onTurn: menuSelected.value,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ));
  }

  Row showHashtagTexts(List tagList) {
    return Row(
      children: List.generate(
        tagList.length,
        (index) => Row(
          children: [
            Text(
              '#${tagList[index]}',
              style: TextStyle(fontSize: 12, color: Palette.greyMain),
            ),
            SizedBox(width: 4)
          ],
        ),
      ),
    );
  }
}
