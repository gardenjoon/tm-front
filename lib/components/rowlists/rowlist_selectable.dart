import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/rowlists/rowlist_shared.dart';
import 'package:tm_front/components/textcomponents.dart/custom_chip.dart';
import 'package:tm_front/components/textcomponents.dart/rectangle_button.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/screens/login_screens/choose_food.dart';
import 'package:tm_front/services/shared_service.dart';

class RowListSelectable extends StatelessWidget {
  RowListSelectable({
    super.key,
    required this.buttonTitle,
    required this.loginData,
    required this.isDivider,
  });
  final String buttonTitle;
  final RxMap loginData;
  final bool isDivider;

  final titleList = ['좋아하는 음식', '싫어하는 음식', '알레르기'];

  final formList = ['like', 'hate', 'allergy'];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (BuildContext context, int index) {
        return isDivider ? const Divider(thickness: 0.8) : const SizedBox();
      },
      itemCount: titleList.length,
      itemBuilder: (BuildContext context, int index) {
        final formName = formList[index];
        return Container(
          margin: EdgeInsets.only(
              top: 10, bottom: index == titleList.length - 1 ? 20 : 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RowListTitle(
                    index: index,
                    titleList: titleList,
                    isPad: true,
                  ),
                  RectangleButton(
                    title: buttonTitle,
                    callback: () =>
                        openBottomSheet(loginData[formName], formName),
                  )
                ],
              ),
              Obx(
                () => Wrap(
                  direction: Axis.horizontal,
                  children: List.generate(
                    loginData[formName].length,
                    (cIndex) {
                      return CustomChip(
                        title: loginData[formName][cIndex],
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}

Future<void> openBottomSheet(List formList, String formName) async {
  List updatedData = await Get.bottomSheet(
    ChooseFood(dataList: formList, formName: formName),
    backgroundColor: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(40),
    ),
  );
  final loginData = Get.put(LoginRequestData());
  loginData.updateData(formName, updatedData);
  SharedService.saveData(formName, updatedData);
}
