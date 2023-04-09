import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/screens/login_screens/choose_food.dart';

class BasicInformScreen extends StatefulWidget {
  const BasicInformScreen({super.key});

  @override
  State<BasicInformScreen> createState() => _BasicInformScreenState();
}

class _BasicInformScreenState extends State<BasicInformScreen> {
  final GlobalKey<FormState> _key = GlobalKey();

  final _loginData = Get.put(LoginRequestData());
  final RxString gender = "".obs;
  final TextEditingController hateFoodController = TextEditingController();
  final TextEditingController likeFoodController = TextEditingController();
  final TextEditingController allergyController = TextEditingController();

  void setGender(String value) {
    gender.value = value;
    _loginData.data["gender"] = value;
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
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Form(
                          key: _key,
                          child: Column(
                            children: [
                              titleWithForm("나이", nessasary: true),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                      child: titleWithForm("신장",
                                          hint: 'cm', nessasary: true)),
                                  const SizedBox(width: 10),
                                  Expanded(
                                      child: titleWithForm("체중",
                                          hint: 'kg', nessasary: true)),
                                ],
                              ),
                              genderMenu(),
                              chooseFoodField(
                                  '싫어하는 음식', 'hate', hateFoodController),
                              chooseFoodField(
                                  '좋아하는 음식', 'like', likeFoodController),
                              chooseFoodField(
                                  '알레르기', 'allergy', allergyController),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                      child: Row(
                        children: [
                          Expanded(
                            child: SizedBox(
                              height: 60,
                              child: TextButton(
                                  onPressed: () => Get.toNamed('activities'),
                                  style: TextButton.styleFrom(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    backgroundColor: Palette.main,
                                  ),
                                  child: const Text('다음',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ))),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  Widget chooseFoodField(String title, String formName, controller) {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          titleField(title),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: formField(
                  formName,
                  controller: controller,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: SizedBox(
                  width: 100,
                  height: 46,
                  child: TextButton(
                      onPressed: () => {
                            Get.bottomSheet(
                              ChooseFood(formName: formName),
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40),
                              ),
                            ),
                          },
                      style: TextButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Palette.main),
                      child: const Text('선택',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            // fontWeight: FontWeight.bold,
                          ))),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget genderMenu() {
    return SizedBox(
      height: 100,
      child: Column(
        children: [
          titleField("성별", nessasary: true),
          const SizedBox(height: 5),
          Row(
            children: [
              Obx(
                () => Expanded(
                  child: TextButton(
                      onPressed: () => setGender('10'),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: gender.value == '10'
                            ? Palette.main
                            : Palette.greySub,
                      ),
                      child: const Text('남자',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              ),
              const SizedBox(width: 10),
              Obx(
                () => Expanded(
                  child: TextButton(
                      onPressed: () => setGender('20'),
                      style: TextButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: gender.value == '20'
                            ? Palette.main
                            : Palette.greySub,
                      ),
                      child: const Text('여자',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ))),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

  SizedBox titleWithForm(String name, {String? hint, bool? nessasary}) {
    return SizedBox(
      height: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleField(name, nessasary: nessasary),
          const SizedBox(height: 5),
          formField(name, hint: hint),
        ],
      ),
    );
  }

  Row titleField(String title, {bool? nessasary}) {
    return Row(
      children: [
        const SizedBox(width: 8),
        Text(title, style: const TextStyle(fontSize: 20)),
        if (nessasary == true)
          Text(" *",
              style: TextStyle(fontSize: 20, color: Colors.red.shade300)),
      ],
    );
  }

  SizedBox formField(String name, {String? hint, controller}) {
    return SizedBox(
      child: TextFormField(
        controller: controller,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        textInputAction: TextInputAction.next,
        cursorColor: Colors.black87,
        readOnly: controller != null ? true : false,
        cursorWidth: 0.8,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Palette.greySub),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
          border: inputBorderDesign(Colors.grey.shade400),
          enabledBorder: inputBorderDesign(Colors.grey.shade400),
          focusedBorder: inputBorderDesign(Colors.grey.shade400),
          errorBorder: inputBorderDesign(Colors.grey.shade400),
          focusedErrorBorder: inputBorderDesign(Colors.grey.shade400),
          errorStyle: const TextStyle(
            color: Color(0xff5c74dd),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
        onSaved: (String? value) {
          if (name == '나이') {
            _loginData.data['age'] = value;
          } else if (name == '신장') {
            _loginData.data['tall'] = value;
          } else if (name == '체중') {
            _loginData.data['weight'] = value;
          }
        },
      ),
    );
  }

  OutlineInputBorder inputBorderDesign(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
    );
  }

//   _sendToServer() {
//     if (_key.currentState!.validate()) {
//       /// No any error in validation
//       _key.currentState!.save();
//       print("Email ${_loginData.email}");
//       print("Password ${_loginData.password}");
//     } else {
//       ///validation error
//     }
//   }
}
