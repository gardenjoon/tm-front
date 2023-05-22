import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/next_button.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/components/rowlists/inform_row.dart';
import 'package:tm_front/components/rowlists/rowlist_selectable.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/services/login_service.dart';

class BasicInformScreen extends StatefulWidget {
  const BasicInformScreen({super.key});

  @override
  State<BasicInformScreen> createState() => _BasicInformScreenState();
}

class _BasicInformScreenState extends State<BasicInformScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    LoginService.fetchFoodInform(isFirst: true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: const Text('기본 정보'),
          elevation: 0,
        ),
        backgroundColor: Palette.white,
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            constraints: const BoxConstraints(maxWidth: 640),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Form(
                    key: _key,
                    child: Column(
                      children: [
                        InformRow(title: '성별', formName: 'gender'),
                        InformRow(title: '생년월일', formName: 'birth'),
                        InformRow(title: '신장', formName: 'tall', unit: 'cm'),
                        InformRow(title: '체중', formName: 'weight', unit: 'kg'),
                        FutureBuilder(
                            future: LoginService.fetchFoodInform(),
                            builder: ((context, snapshot) {
                              if (snapshot.hasData) {
                                return RowListSelectable(
                                  loginData: snapshot.data.data,
                                  buttonTitle: '선택',
                                  isDivider: false,
                                );
                              }
                              return const CircularProgressIndicator();
                            })),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 20 / 100,
                        )
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 30,
                  child: NextButton(
                    title: '다음',
                    nextPageFunc: _goNextPage,
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  void _goNextPage() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      final loginData = Get.put(LoginRequestData());

      if (loginData.data['gender'] == '선택') {
        showSnackBar(context, '성별을 선택해주세요');
      } else {
        Get.toNamed('activities');
      }
    } else {
      showSnackBar(context, '필수정보를 반드시 입력해야 합니다.');
    }
  }
}


// Widget informRow(
//     {required String title, required String formName, String? unit = ''}) {
//   return SizedBox(
//     height: 72,
//     child: Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         titleField(title, nessasary: true),
//         formName != 'birth'
//             ? PickerButton(
//                 onSelectedItemChanged: (value) => setValues(value, formName),
//                 initValue: setInitValue(formName),
//                 genList: setGenList(formName),
//                 unit: unit,
//               )
//             : DatePickerButton(
//                 onDateTimeChanged: (value) => setValues(value, formName),
//                 initDateStr: setInitDate(),
//               ),
//       ],
//     ),
//   );
// }


