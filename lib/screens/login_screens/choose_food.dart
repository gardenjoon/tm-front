import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/controller/user_controller.dart';
import 'package:tm_front/models/allergy.dart';

class ChooseFood extends StatelessWidget {
  const ChooseFood({
    super.key,
    required this.dataList,
    required this.title,
  });
  final List dataList;

  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(0, 20, 0, 40),
      constraints: const BoxConstraints(maxWidth: 640),
      child: Column(
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Palette.main,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            flex: 5,
            child: ListView.builder(
              itemCount: dataList.length,
              itemBuilder: (BuildContext context, int index) {
                return categoryView(
                  dataList[index].allergy_set_name,
                  dataList[index].allergy_infos,
                );
              },
            ),
          ),
          nextButton(),
        ],
      ),
    );
  }

  Row nextButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            height: 70,
            child: TextButton(
                onPressed: () {
                  Get.back(result: dataList);
                },
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                  backgroundColor: Palette.main,
                ),
                child: const Text('완료',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ))),
          ),
        ),
      ],
    );
  }

  Widget categoryView(String title, List componentList) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        categoryTitle(title),
        const SizedBox(height: 5),
        SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: componentList.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: foodComponent(componentList[index]));
              }
              return foodComponent(componentList[index]);
            },
          ),
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Container categoryTitle(String title) {
    return Container(
      margin: const EdgeInsets.only(left: 25),
      child: Text(
        title,
        style: const TextStyle(
          color: Palette.main,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  Widget foodComponent(Allergy allergy_item) {
    final controller = Get.put(UserController());
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(right: 10),
        child: TextButton(
          onPressed: () {
            if (!controller.checkAllergy(allergy_item)) {
              controller.addAllergy(allergy_item);
            } else {
              controller.removeAllergy(allergy_item);
            }
          },
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25),
            ),
            backgroundColor: controller.checkAllergy(allergy_item)
                ? Palette.main
                : Palette.greySub,
          ),
          child: Text(
            allergy_item.allergy_name!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
