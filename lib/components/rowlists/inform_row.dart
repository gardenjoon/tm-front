import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/textcomponents.dart/picker_button.dart';
import 'package:tm_front/controller/user_controller.dart';

class InformRow extends StatelessWidget {
  InformRow({
    super.key,
    required this.title,
    required this.formName,
    this.unit = '',
  });

  final String title;
  final String formName;
  final String? unit;

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleField(title, nessasary: true),
          formName != 'birth'
              ? Obx(() => PickerButton(
                    onSelectedItemChanged: (value) => controller.setProfile(
                      value: value,
                      formName: formName,
                    ),
                    initValue: controller.setInitValue(formName),
                    genList: controller.setGenList(formName),
                    unit: unit,
                  ))
              : Obx(() => DatePickerButton(
                    onDateTimeChanged: (value) => controller.setProfile(
                      value: formatDate(value, [yyyy, mm, dd]),
                      formName: formName,
                    ),
                    initDateStr: controller.setInitValue(formName),
                  )),
        ],
      ),
    );
  }

  Row titleField(String title, {bool? nessasary}) {
    return Row(
      children: [
        Text(title, style: const TextStyle(fontSize: 22)),
        if (nessasary == true)
          Text(' *',
              style: TextStyle(fontSize: 20, color: Colors.red.shade300)),
      ],
    );
  }
}
