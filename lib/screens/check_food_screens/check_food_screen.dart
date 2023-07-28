import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import 'package:image_picker/image_picker.dart';
import 'package:tm_front/components/loading_indicator.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/components/snackBar.dart';
import 'package:tm_front/screens/check_food_screens/choose_pic_button.dart';
import 'package:tm_front/screens/check_food_screens/food_inform_box.dart';
import 'package:tm_front/services/check_service.dart';

class CheckFood extends StatefulWidget {
  CheckFood({super.key});

  @override
  State<CheckFood> createState() => _CheckFoodState();
}

class _CheckFoodState extends State<CheckFood> {
  Uint8List? _image;

  final RxList predictions = [].obs;

  final RxInt sum = 0.obs;

  final RxBool _isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        title: const Text(
          '식단정보',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Obx(
                () => _isLoading.isFalse
                    ? Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 10),
                            height:
                                MediaQuery.of(context).size.height * 30 / 100,
                            decoration: BoxDecoration(
                              color: Palette.greySub2,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: _image != null
                                ? showImageBox(image: _image)
                                : noDataInform(
                                    text: '선택된 이미지가 없습니다',
                                    color: Palette.white),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ChoosePicButton(
                                    function: () =>
                                        getImage(ImageSource.camera),
                                    isCamera: true),
                                ChoosePicButton(
                                    function: () =>
                                        getImage(ImageSource.gallery),
                                    isCamera: false),
                              ],
                            ),
                          ),
                          predictions.isNotEmpty
                              ? FoodInformBox(
                                  predictions: predictions, sum: sum)
                              : Expanded(
                                  child: noDataInform(text: '인식된 데이터가 없습니다.')),
                        ],
                      )
                    : LoadingIndicator(
                        loadingTextWidget: Column(
                          children: [
                            Text('AI가 이미지를 인식하고 있습니다.'),
                            Text('잠시만 기다려 주세요.'),
                          ],
                        ),
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showImageBox({required image}) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Image.memory(
        image,
        fit: BoxFit.contain,
      ),
    );
  }

  Widget noDataInform({required String text, Color color = Palette.black}) {
    return Center(
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(
          color: color,
          fontSize: 16,
        ),
      ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    try {
      _isLoading.value = true;
      final image = await ImagePicker().pickImage(source: imageSource);
      if (image != null) {
        var sendImg;
        if (kIsWeb) {
          final byteImg = await image.readAsBytes();
          sendImg = FormData.fromMap({
            'image': MultipartFile.fromBytes(byteImg, filename: 'checkFood.jpg')
          });
        } else {
          sendImg = FormData.fromMap(
              {'image': MultipartFile.fromFileSync(image.path)});
        }
        final result = await CheckService.uploadImg(sendImg);

        predictions.value = result[0] ?? [];
        _image = result[1] ?? [];
        sum.value = result[2] ?? 0;
      }
      _isLoading.value = false;
    } catch (e) {
      showSnackBar(AlertType.error);
      _isLoading.value = false;
    }
  }
}
