import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/controller/location_controller.dart';
import 'package:tm_front/components/textcomponents.dart/custom_text_form_field.dart';
import 'package:tm_front/components/palette.dart';

class SearchBar extends StatelessWidget {
  SearchBar({
    super.key,
  });

  final GlobalKey<FormState> _key = GlobalKey();

  final LocationController controller = Get.put(LocationController());

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: CustomTextFormField(
        hint: '검색',
        onSaved: (String? value) => controller.searchQuery.value = value!,
        suffixIcon: GestureDetector(
          child: Icon(
            Icons.search,
            color: Palette.greyMain,
            size: 26,
          ),
          onTap: () {
            _key.currentState!.save();
            if (controller.searchQuery.value != '') {
              controller.updateMap.value = true;
            }
          },
        ),
      ),
    );
  }
}
