import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/components/rowlists/rowlist_shared.dart';
import 'package:tm_front/components/textcomponents.dart/picker_button.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/services/profile_service.dart';

class RowListChangable extends StatefulWidget {
  const RowListChangable({
    super.key,
    required this.fitnessList,
  });
  final List<String> fitnessList;

  @override
  State<RowListChangable> createState() => _RowListChangableState();
}

class _RowListChangableState extends State<RowListChangable> {
  final getStorage = GetStorage();

  final genderList = ['선택', '남자', '여자', '임산부'];

  final formNameList = ['birth', 'gender', 'tall', 'weight'];

  void setValues(userData, value, formName) {
    if (formName == 'gender') {
      userData[formName] = genderList[value];
    } else if (formName == 'tall' || formName == 'weight') {
      userData[formName] = value;
    } else if (formName == 'birth') {
      userData[formName] = formatDate(value, [yyyy, mm, dd]);
    }
    getStorage.write('userData', userData);
    final loginData = Get.put(LoginRequestData());
    loginData.data = userData;
    _sendToServer();
    setState(() {});
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

  String? setUnit(formName) {
    if (formName == 'tall') {
      return 'cm';
    } else if (formName == 'weight') {
      return 'kg';
    }
    return '';
  }

  int setInitValue(value) {
    if (value == null) {
      return 0;
    } else if (value is String) {
      if (int.tryParse(value) is int) {
        return genderList.indexOf(Login.genderCodeToString(value));
      } else {
        return genderList.indexOf(value);
      }
    } else {
      return value;
    }
  }

  _sendToServer() async {
    try {
      final result =
          await ProfileService.updateProfile(getStorage.read('userId'));
      if (result != true) {
        showSnackBar(context, 'server');
      }
    } catch (e) {
      showSnackBar(context, 'server');
    }
  }

  @override
  Widget build(BuildContext context) {
    final userData = getStorage.read('userData');
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RowListTitle(index: index, titleList: widget.fitnessList),
            Container(
              child: formNameList[index] != 'birth'
                  ? PickerButton(
                      onSelectedItemChanged: (value) =>
                          setValues(userData, value, formNameList[index]),
                      initValue: setInitValue(userData[formNameList[index]]),
                      genList: setGenList(formNameList[index]),
                      unit: setUnit(formNameList[index]),
                    )
                  : DatePickerButton(
                      onDateTimeChanged: (value) =>
                          setValues(userData, value, formNameList[index]),
                      initDateStr: userData[formNameList[index]],
                    ),
            )
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(thickness: 0.8);
      },
      itemCount: widget.fitnessList.length,
    );
  }
}
