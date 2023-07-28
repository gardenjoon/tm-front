// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';
// import 'package:tm_front/components/palette.dart';
// import 'package:tm_front/screens/login_screens/choose_food.dart';
// import 'package:tm_front/services/shared_service.dart';

// Future<void> cupertinoPickerBottomsheet(
//     dynamic getXData, String formName, List genList, String genName) async {
//   List updatedData = await Get.bottomSheet(
//     SizedBox(
//       height: 240,
//       child: CupertinoPicker(
//           squeeze: 1.2,
//           useMagnifier: false,
//           itemExtent: 50,
//           onSelectedItemChanged: (int index) {
//             getXData.data[formName] = list[index];
//           },
//           children: [
//             ...genList.map((value) {
//               return Center(
//                 child: Text(
//                   '$value $genName',
//                 ),
//               );
//             })
//           ]),
//     ),
//     backgroundColor: Palette.white,
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(40),
//     ),
//   );
//   getXData.updateData(formName, updatedData);
//   SharedService.saveData(formName, updatedData);
// }
