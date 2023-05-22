import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/textcomponents.dart/picker_button.dart';
import 'package:tm_front/models/login_model.dart';

class InformRow extends StatefulWidget {
  InformRow({
    super.key,
    required this.title,
    required this.formName,
    this.unit = '',
  });

  final String title;
  final String formName;
  final String? unit;

  @override
  State<InformRow> createState() => _InformRowState();
}

class _InformRowState extends State<InformRow> {
  final loginData = Get.put(LoginRequestData());

  final RxInt gender = 0.obs;

  final genderList = ['선택', '남자', '여자', '임산부'];
  final List informTitles = ['성별', '생년월일', '신장', '체중'];
  final List formNames = ['gender', 'birth', 'tall', 'weight'];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleField(widget.title, nessasary: true),
          widget.formName != 'birth'
              ? PickerButton(
                  onSelectedItemChanged: (value) =>
                      setValues(value, widget.formName),
                  initValue: setInitValue(widget.formName),
                  genList: setGenList(widget.formName),
                  unit: widget.unit,
                )
              : DatePickerButton(
                  onDateTimeChanged: (value) =>
                      setValues(value, widget.formName),
                  initDateStr: setInitDate(),
                ),
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

  void setValues(value, formName) {
    if (formName == 'gender') {
      gender.value = value;
      loginData.data['gender'] = genderList[value];
    } else if (formName == 'tall') {
      loginData.data['tall'] = value;
    } else if (formName == 'weight') {
      loginData.data['weight'] = value;
    } else if (formName == 'birth') {
      loginData.data['birth'] = formatDate(value, [yyyy, mm, dd]);
    }
    setState(() {});
  }

  int setInitValue(formName) {
    if (formName == 'gender') {
      return gender.value;
    } else if (formName == 'tall') {
      if (loginData.data['tall'] == 0) {
        return 165;
      } else {
        return loginData.data['tall'];
      }
    } else if (formName == 'weight') {
      if (loginData.data['weight'] == 0) {
        return 65;
      } else {
        return loginData.data['weight'];
      }
    }
    return 0;
  }

  String setInitDate() {
    return loginData.data['birth'];
  }

  List setGenList(formName) {
    if (formName == 'gender') {
      return genderList;
    } else if (formName == 'tall') {
      return List.generate(250, (i) => i).toList();
    } else if (formName == 'weight') {
      return List.generate(454, (i) => i).toList();
    } else {
      return [];
    }
  }
}
