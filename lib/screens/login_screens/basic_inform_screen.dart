import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/next_button.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/components/rowlists/rowlist_selectable.dart';
import 'package:tm_front/components/textcomponents.dart/picker_button.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/services/shared_service.dart';

class BasicInformScreen extends StatefulWidget {
  const BasicInformScreen({super.key});

  @override
  State<BasicInformScreen> createState() => _BasicInformScreenState();
}

class _BasicInformScreenState extends State<BasicInformScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  final loginData = Get.put(LoginRequestData());
  final RxInt gender = 0.obs;

  final TextEditingController birthController = TextEditingController();
  final genderList = ['선택', '남자', '여자', '임산부'];
  final List informTitles = ['성별', '생년월일', '신장', '체중'];
  final List formNames = ['gender', 'birth', 'tall', 'weight'];

  @override
  void initState() {
    _fetchFoodInform();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: const Text("기본 정보"),
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
                        informRow(title: '성별', formName: 'gender'),
                        informRow(title: '생년월일', formName: 'birth'),
                        informRow(title: '신장', formName: 'tall', unit: 'cm'),
                        informRow(title: '체중', formName: 'weight', unit: 'kg'),
                        FutureBuilder(
                            future: _fetchFoodInform(),
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

  Widget informRow(
      {String title = '', String formName = '', String? unit = ''}) {
    return SizedBox(
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          titleField(title, nessasary: true),
          formName != 'birth'
              ? PickerButton(
                  onSelectedItemChanged: (value) => setValues(value, formName),
                  initValue: setInitValue(formName),
                  genList: setGenList(formName),
                  unit: unit,
                )
              : DatePickerButton(
                  onDateTimeChanged: (value) => setValues(value, formName),
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
          Text(" *",
              style: TextStyle(fontSize: 20, color: Colors.red.shade300)),
      ],
    );
  }

  _goNextPage() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      if (gender.value == 0) {
        showSnackBar(context, '성별을 선택해주세요');
      } else {
        Get.toNamed('activities');
      }
    } else {
      showSnackBar(context, '필수정보를 반드시 입력해야 합니다.');
    }
  }

  void setValues(value, formName) {
    if (formName == 'gender') {
      gender.value = value;
      loginData.data["gender"] = genderList[value];
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
      if (loginData.data["gender"] != '') {
        if (loginData.data["gender"] == '남자') {
          return 170;
        } else {
          return 150;
        }
      } else {
        return 160;
      }
    } else if (formName == 'weight') {
      if (loginData.data["gender"] != '') {
        if (loginData.data["gender"] == '남자') {
          return 80;
        } else if (loginData.data["gender"] == '여자') {
          return 50;
        } else if (loginData.data["gender"] == '임산부') {
          return 70;
        }
      } else {
        return 60;
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

//   late var componentLists = [];

  Future<dynamic> _fetchFoodInform() async {
    final componentLists = [
      await SharedService.loadData('like'),
      await SharedService.loadData('hate'),
      await SharedService.loadData('allergy'),
    ];
    loginData.data['like'] = componentLists[0];
    loginData.data['hate'] = componentLists[1];
    loginData.data['allergy'] = componentLists[2];
    return loginData;
  }
}
