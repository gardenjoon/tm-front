import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tm_front/components/textcomponents.dart/inform_texts.dart';
import 'package:tm_front/models/body_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:tm_front/services/shared_service.dart';

class RecommendMenuScreen extends StatefulWidget {
  const RecommendMenuScreen({super.key});

  @override
  State<RecommendMenuScreen> createState() => _RecommendMenuScreenState();
}

class _RecommendMenuScreenState extends State<RecommendMenuScreen> {
  late String userId;
  late final Future<BodyModel> bodyInfo;

  dynamic _fetchUserId() {
    final storeUserId = GetStorage();
    return storeUserId.read('userId');
  }

  var selectedMealTime = '아침';
  List<dynamic> menuData = [];

//   @override
//   void initState() {
//     if (DateTime.now().hour < 10) {
//       selectedMealTime = '아침';
//     } else if (DateTime.now().hour < 17) {
//       selectedMealTime = '점심';
//     } else if (DateTime.now().hour >= 17 || DateTime.now().hour < 4) {
//       selectedMealTime = '저녁';
//     }
//     userId = _fetchUserId();

//     bodyInfo = RcmdMenuService.getBodyInfo(userId);
//     changeMealTime(selectedMealTime);
//     SharedService.scheduleDailyTask();

//     super.initState();
//   }

  void changeMealTime(String time) async {
    setState(() {
      selectedMealTime = time;
      getMenuData(userId, selectedMealTime);
    });
  }

  Future<List<dynamic>> _fetchMenuData() async {
    var menuData = await SharedService.loadData(selectedMealTime);
    return menuData;
  }

  Future<void> getMenuData(String id, String menuType) async {
    if ((await SharedService.loadData(selectedMealTime)).isEmpty) {
      menuType = menuType == '아침'
          ? 'breakfast'
          : menuType == '점심'
              ? 'lunch'
              : 'dinner';
      final response = await http
          .get(Uri.parse('http://data.pknu.ac.kr:7443/api/menu/$menuType/$id'));
      if (response.statusCode == 200) {
        setState(() {
          menuData = json.decode(response.body)['data'];
          SharedService.saveData(selectedMealTime, menuData);
        });
      } else {
        throw Exception('Failed to retrieve menu data');
      }
    } else {
      menuData = await SharedService.loadData(selectedMealTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          '추천음식',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
              constraints: const BoxConstraints(maxWidth: 640),
              child: SizedBox()
              // Column(
              //   children: [
              //     _showInfo(),
              //     const SizedBox(height: 20),
              //     _mealTime(),
              //     const SizedBox(height: 20),
              //     // MenuTableWidget(meal),
              //     if (menuData.isNotEmpty)
              //       Column(
              //         children: [
              //           FutureBuilder(
              //             future: _fetchMenuData(),
              //             builder: (context, snapshot) {
              //               if (snapshot.hasData) {
              //                 return MenuTableWidget(menuData);
              //               }
              //               return const CircularProgressIndicator();
              //             },
              //           ),
              //           // if (menuData.isNotEmpty) MenuTableWidget(menuData),
              //           const Expanded(child: SizedBox()),
              //           FutureBuilder(
              //             future: _fetchMenuData(),
              //             builder: (context, snapshot) {
              //               if (snapshot.hasData) {
              //                 return _showTotalKcal(menuData.last['cal']);
              //               }
              //               return const CircularProgressIndicator();
              //             },
              //           ),
              //         ],
              //       )
              //     else
              //       const Center(
              //           child: Text(
              //         '메뉴정보를 불러올 수 없습니다. \n프로필에서 활동량을 입력해주세요.',
              //         textAlign: TextAlign.center,
              //         style: TextStyle(
              //           fontSize: 20,
              //         ),
              //       )),
              //   ],
              // ),
              ),
        ),
      ),
    );
  }

  FutureBuilder<BodyModel> _showInfo() {
    return FutureBuilder(
      future: bodyInfo,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 20,
            ),
            //   decoration: const BoxDecoration(color: Colors.lightBlue),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InformTexts(
                      title: '권장 열량',
                      text: '${snapshot.data!.avgCal} Kcal',
                    ),
                    InformTexts(
                      title: '섭취 열량',
                      text: '${snapshot.data!.mealCal} Kcal',
                    ),
                  ],
                ),
              ],
            ),
          );
        }
        return const CircularProgressIndicator();
      },
    );
  }

  Widget _mealTime() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ChooseMealWidget('아침', selectedMealTime, changeMealTime),
        ChooseMealWidget('점심', selectedMealTime, changeMealTime),
        ChooseMealWidget('저녁', selectedMealTime, changeMealTime),
      ],
    );
  }

  Widget _showTotalKcal(String totalCal) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            decoration: BoxDecoration(color: Colors.grey.shade100),
            child: Text(
              '식사 총 열량 : ${totalCal}Kcal',
              textAlign: TextAlign.end,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.indigo,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class MenuTableWidget extends StatelessWidget {
  final List<dynamic> menuData;
  const MenuTableWidget(
    this.menuData, {
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      width: double.infinity,
      child: DataTable(
        headingRowColor:
            MaterialStateColor.resolveWith((states) => Colors.indigo.shade50),
        headingRowHeight: 36,
        border: TableBorder.all(color: Colors.grey.shade100),
        columns: const [
          DataColumn(label: Text('음식이름')),
          DataColumn(label: Text('열량')),
          DataColumn(label: Text('중량')),
        ],
        rows: menuData
            .take(menuData.length - 1)
            .map(
              (item) => DataRow(
                cells: [
                  DataCell(Text(item['fi_nm'] ?? '-')),
                  DataCell(Text('${item['cal'] ?? '-'}Kcal')),
                  DataCell(Text('${item['totl_prtn'] ?? '-'}g'))
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}

class ChooseMealWidget extends StatelessWidget {
  final String mealTime;
  final String selectedMealTime;
  final Function changeMealTime;

  const ChooseMealWidget(
    this.mealTime,
    this.selectedMealTime,
    this.changeMealTime, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        changeMealTime(mealTime);
      },
      child: Container(
        decoration: BoxDecoration(
          color: selectedMealTime == mealTime
              ? Colors.indigo.shade400
              : Colors.grey,
          borderRadius: BorderRadius.only(
            topRight: mealTime == '저녁'
                ? const Radius.circular(5)
                : const Radius.circular(0),
            topLeft: mealTime == '아침'
                ? const Radius.circular(5)
                : const Radius.circular(0),
            bottomRight: mealTime == '저녁'
                ? const Radius.circular(5)
                : const Radius.circular(0),
            bottomLeft: mealTime == '아침'
                ? const Radius.circular(5)
                : const Radius.circular(0),
          ),
        ),
        margin: const EdgeInsets.only(right: 2),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        child: Text(
          mealTime,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
