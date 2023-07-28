import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/controller/rcmd_menu_controller.dart';
import 'package:tm_front/models/menu.dart';
import 'package:tm_front/screens/reccommend_menu_screens/bounce_widget.dart';

class SingleMenuCard extends StatelessWidget {
  SingleMenuCard({
    super.key,
    required this.menu,
    required this.onTapUp,
    required this.isClicked,
  });

  final Menu menu;
  final Function onTapUp;
  final RxBool isClicked;

  final RxBool isSubCardClicked = false.obs;
  void changeSubCardClicked(bool bool) {
    isSubCardClicked.value = bool;
    isClicked.value = true;
  }

  final RcmdMenuController controller = RcmdMenuController();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Bounce(
          endState: isSubCardClicked.value,
          startAction: changeSubCardClicked,
          endAction: onTapUp,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0),
            child: Card(
              elevation: 0,
              color: isSubCardClicked.value == true ? Palette.greySub2 : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            menu.food_nm,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8),
                          showHashtagTexts(menu.tags),
                        ],
                      ),
                      Text(
                        '${menu.total_cal} kcal',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(top: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      infromTextColumn('1회 제공량', '${menu.total_amt} g'),
                      infromTextColumn('탄수화물', '${menu.total_carbo} g'),
                      infromTextColumn('단백질', '${menu.total_prot} g'),
                      infromTextColumn('지방', '${menu.total_fat} g'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ));
  }

  Widget infromTextColumn(text1, text2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          text1,
          style: TextStyle(fontSize: 12, color: Palette.greyMain),
        ),
        Text(
          text2,
          style: TextStyle(fontSize: 16, color: Palette.greyMain),
        )
      ],
    );
  }

  Widget showHashtagTexts(List tagList) {
    return Container(
      constraints: BoxConstraints(maxWidth: Get.width / 2),
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 6,
        children: List.generate(
          tagList.length,
          (index) => Text(
            '#${tagList[index]}',
            style: TextStyle(fontSize: 12, color: Palette.greyMain),
          ),
        ),
      ),
    );
  }
}
