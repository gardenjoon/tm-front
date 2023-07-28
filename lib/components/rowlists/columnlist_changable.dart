import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tm_front/components/snackBar.dart';
import 'package:tm_front/components/textcomponents.dart/picker_button.dart';
import 'package:tm_front/models/login.dart';

class ColumnListChangable extends StatefulWidget {
  const ColumnListChangable({
    super.key,
    required this.activityList,
  });
  final List<String> activityList;

  @override
  State<ColumnListChangable> createState() => _ColumnListChangableState();
}

class _ColumnListChangableState extends State<ColumnListChangable> {
  final getStorage = GetStorage();

  final List timeNameList = ['days', 'hours', 'minutes'];

  void setValues(userData, value, formName, timeName) {
    userData[formName][timeName] = value;
    getStorage.write('userData', userData);
    final loginData = Get.put(ActivityData());
    loginData.data = userData;
    _sendToServer();
    setState(() {});
  }

  List setGenList(formName) {
    if (formName == 'days') {
      return List.generate(8, (i) => i).toList();
    } else if (formName == 'hours') {
      return List.generate(25, (i) => i).toList();
    } else if (formName == 'minutes') {
      return [0, 10, 20, 30, 40, 50];
    }
    return [];
  }

  String setUnit(formName) {
    if (formName == 'days') {
      return '일';
    } else if (formName == 'hours') {
      return '시간';
    } else if (formName == 'minutes') {
      return '분';
    }
    return '';
  }

  _sendToServer() async {
    try {
      //   final result =
      //       await UserRepository.updateProfile(getStorage.read('userId'));
      //   if (result != true) {
      //     showSnackBar(AlertType.error);
      //   }
    } catch (e) {
      showSnackBar(AlertType.error);
    }
  }

  String convertTime(times) {
    if (times == 'days') {
      return '일주일에';
    } else if (times == 'hours') {
      return '하루에';
    } else if (times == 'hardTimes') {
      return '고강도 운동';
    } else if (times == 'softTimes') {
      return '중강도 운동';
    } else if (times == 'walkTimes') {
      return '걷기 운동';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    final userData = getStorage.read('activityData');
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // RowListTitle(
            //     index: index,
            //     titleList:
            //         widget.activityList.map((e) => convertTime(e)).toList()),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  convertTime('days'),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                PickerButton(
                  onSelectedItemChanged: (value) => setValues(
                      userData, value, widget.activityList[index], 'days'),
                  initValue: userData[widget.activityList[index]]['days'],
                  genList: setGenList('days'),
                  unit: setUnit('days'),
                ),
                Text(
                  convertTime('hours'),
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
                PickerButtonMany(
                  onSelectedItemChanged: [
                    (value) => setValues(
                        userData, value, widget.activityList[index], 'hours'),
                    (value) => setValues(
                        userData, value, widget.activityList[index], 'minutes'),
                  ],
                  initValue: [
                    userData[widget.activityList[index]]['hours'],
                    userData[widget.activityList[index]]['minutes']
                  ],
                  genList: [
                    setGenList('hours'),
                    setGenList('minutes'),
                  ],
                  unit: [
                    setUnit('hours'),
                    setUnit('minutes'),
                  ],
                )
              ],
            ),
          ],
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(thickness: 0.8);
      },
      itemCount: widget.activityList.length,
    );
  }
}
