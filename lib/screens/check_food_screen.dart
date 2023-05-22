import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/services/check_service.dart';

class CheckFood extends StatefulWidget {
  CheckFood({super.key});

  @override
  State<CheckFood> createState() => _CheckFoodState();
}

class _CheckFoodState extends State<CheckFood> {
  Uint8List? _image;

  RxList predictions = [].obs;
  RxInt sum = 0.obs;
  final RxBool _isLoading = false.obs;

  final picker = ImagePicker();

  Future getImage(ImageSource imageSource) async {
    _isLoading.value = true;
    final image = await picker.pickImage(source: imageSource);
    if (image != null) {
      var sendImg =
          FormData.fromMap({'image': MultipartFile.fromFileSync(image.path)});
      final result = await CheckService.uploadImg(sendImg);

      predictions.value = result[0] ?? [];
      _image = result[1] ?? [];
      sum.value = result[2] ?? 0;
    }
    _isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          '음식확인',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 640),
            child: showImage(horizontal: _image == Uint8List(0) ? false : true),
          ),
        ),
      ),
    );
  }

  Widget showImage({required bool horizontal}) {
    return Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Obx(
          () => _isLoading.isFalse
              ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      height: MediaQuery.of(context).size.height * 30 / 100,
                      decoration: BoxDecoration(
                        color: Palette.greySub,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: _image != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Image.memory(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            )
                          : Center(
                              child: Text(
                              '선택된 이미지가 없습니다',
                              style: TextStyle(
                                color: Palette.white,
                                fontSize: 16,
                              ),
                            )),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          buttonWidget(
                              function: () => getImage(ImageSource.camera),
                              isCamera: true),
                          buttonWidget(
                              function: () => getImage(ImageSource.gallery),
                              isCamera: false),
                        ],
                      ),
                    ),
                    predictions.isNotEmpty
                        ? Expanded(
                            child: Container(
                              color: Palette.greySub3,
                              child: ListView.builder(
                                itemCount: predictions.length + 1,
                                itemBuilder: (context, index) {
                                  if (index < predictions.length) {
                                    return foodInformCard(
                                      foodInform: predictions[index],
                                      isLast: index == predictions.length - 1
                                          ? true
                                          : false,
                                    );
                                  } else {
                                    return Container(
                                      margin: EdgeInsets.only(
                                          top: 12,
                                          left: 10,
                                          right: 10,
                                          bottom: 12),
                                      decoration: BoxDecoration(
                                          color: Palette.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: ListTile(
                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '총 칼로리',
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              '$sum kcal',
                                              style: TextStyle(
                                                fontSize: 20,
                                                //   fontWeight: FontWeight.bold,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          )
                        : Expanded(
                            child: Center(
                              child: Text(
                                '인식된 데이터가 없습니다.',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                  ],
                )
              : Container(
                  color: Palette.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/loading.gif',
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(height: 20),
                      Text('AI가 이미지를 인식하고 있습니다.'),
                      Text('잠시만 기다려 주세요.'),
                    ],
                  ),
                ),
        ));
  }

  Widget buttonWidget({
    required Function() function,
    required bool isCamera,
  }) {
    return SizedBox(
      height: 68,
      width: 200,
      child: CupertinoButton(
        padding: EdgeInsets.symmetric(horizontal: 36),
        onPressed: function,
        color: isCamera ? Colors.indigo.shade50 : Colors.indigo.shade400,
        child: Row(
          children: [
            Icon(
              isCamera ? Icons.photo_camera : Icons.photo_library,
              size: 40,
              color: isCamera ? Colors.black : Colors.white,
            ),
            SizedBox(width: 20),
            Text(
              isCamera ? '사진 촬영' : '사진 선택',
              style: TextStyle(
                color: isCamera ? Colors.indigo.shade400 : Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class foodInformCard extends StatelessWidget {
  const foodInformCard({
    super.key,
    required this.foodInform,
    required this.isLast,
  });

  final Map foodInform;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final percent = (double.parse(foodInform['percent']) * 100).floor();

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.only(
          top: 12, left: 10, right: 10, bottom: isLast ? 12 : 0),
      child: ListTile(
        horizontalTitleGap: -10,
        minVerticalPadding: 10,
        isThreeLine: true,
        // leading: Column(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   crossAxisAlignment: CrossAxisAlignment.center,
        //   children: [
        //     Text(
        //       '${index + 1}',
        //       style: TextStyle(fontSize: 18),
        //     )
        //   ],
        // ),
        title: Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    '${foodInform['name']} ',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 2, horizontal: 4),
                    decoration: BoxDecoration(
                        color: percent > 80 ? Palette.main : Colors.amber[700],
                        borderRadius: BorderRadius.circular(4)),
                    child: Text(
                      '$percent% 일치',
                      style: TextStyle(fontSize: 12, color: Palette.white),
                    ),
                  ),
                ],
              ),
              Text(
                '${foodInform['calorie']} kcal',
              ),
            ],
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '1회 제공량 : ${foodInform['total']} g',
                ),
                Text(
                  '탄수화물 : ${foodInform['carbohydrate']} g',
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '단백질 : ${foodInform['protein']} g',
                ),
                Text(
                  '지방 : ${foodInform['fat']} g',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
