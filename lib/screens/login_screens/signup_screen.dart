import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/buttons/next_button.dart';
import 'package:tm_front/components/buttons/visible_icon_button.dart';
import 'package:tm_front/components/textcomponents.dart/custom_text_form_field.dart';
import 'package:tm_front/controller/user_controller.dart';
import 'package:tm_front/services/form_validator.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> _key = GlobalKey();

  bool hasLgnId = false;

  final RxBool _isObscure = true.obs;

  final UserController controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: const Text('회원가입'),
          elevation: 0,
        ),
        backgroundColor: Colors.white,
        body: Obx(() => GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Center(
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
                              titleWithForm(
                                name: '이름',
                                validator: FormValidator().validateName,
                                onChanged: (value) => controller
                                    .userProfile.value.user_name = value,
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              titleWithForm(
                                name: '아이디',
                                validator: FormValidator().validateId,
                                onChanged: (value) async {
                                  controller.userProfile.value.account = value;
                                  await controller.checkId(value);
                                },
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              titleWithForm(
                                name: '비밀번호',
                                validator: FormValidator().validatePassword,
                                obscureText: _isObscure.value,
                                suffixIcon: VisibleIcon(isObscure: _isObscure),
                                onChanged: (value) {
                                  controller.userProfile.value.pwd =
                                      controller.securePassword(value);
                                },
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              titleWithForm(
                                name: '비밀번호 확인',
                                validator: (value) {
                                  FormValidator().validatePassword(value);
                                  if (controller.passwordConfirm.value !=
                                      controller.userProfile.value.pwd) {
                                    return '비밀번호가 일치하지 않습니다';
                                  }
                                  return null;
                                },
                                obscureText: _isObscure.value,
                                suffixIcon: VisibleIcon(isObscure: _isObscure),
                                onChanged: (value) => controller.passwordConfirm
                                    .value = controller.securePassword(value),
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              titleWithForm(
                                name: '이메일',
                                validator: FormValidator().validateEmail,
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (value) =>
                                    controller.userProfile.value.email = value,
                                validateMode:
                                    AutovalidateMode.onUserInteraction,
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height *
                                    20 /
                                    100,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        bottom: 0,
                        right: 0,
                        child: NextButton(
                          title: '다음',
                          nextPageFunc: _goNextPage,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )));
  }

  SizedBox titleWithForm({
    required String name,
    validator,
    keyboardType,
    validateMode,
    onChanged,
    obscureText,
    suffixIcon,
    onSaved,
  }) {
    return SizedBox(
      height: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SizedBox(width: 8),
              titleField(name),
            ],
          ),
          const SizedBox(height: 5),
          CustomTextFormField(
            validator: validator,
            onChanged: onChanged,
            obscureText: obscureText ?? false,
            suffixIcon: suffixIcon ?? SizedBox(),
            onSaved: onSaved,
          ),
        ],
      ),
    );
  }

  Row titleField(String title) {
    return Row(
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        Text(
          ' *',
          style: TextStyle(
            fontSize: 20,
            color: Colors.red.shade300,
          ),
        ),
      ],
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

  void _goNextPage() {
    try {
      if (_key.currentState!.validate()) {
        Get.toNamed('/basic_inform');
      }
    } catch (e) {
      print(e);
    }
  }
}
