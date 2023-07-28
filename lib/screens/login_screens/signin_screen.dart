import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/components/snackBar.dart';
import 'package:tm_front/components/textcomponents.dart/custom_text_button.dart';
import 'package:tm_front/components/textcomponents.dart/custom_text_form_field.dart';
import 'package:tm_front/components/textcomponents.dart/expand_text_button.dart';
import 'package:tm_front/controller/user_controller.dart';
import 'package:tm_front/services/form_validator.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  final RxBool _validate = false.obs;
  final RxBool _obscureText = true.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainBackgroud,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SafeArea(
          child: SingleChildScrollView(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height - 100,
                constraints: const BoxConstraints(maxWidth: 640),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset(
                        'assets/images/splash.png',
                        width: 200,
                      ),
                    ),
                    Form(
                      key: _key,
                      child: getFormUI(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget getFormUI() {
    final controller = Get.put(UserController());
    return Obx(() => Column(
          children: [
            CustomTextFormField(
                hint: '아이디',
                textInputAction: TextInputAction.next,
                onSaved: (String? value) {
                  controller.userAccount.value = value!;
                }),
            const SizedBox(height: 10),
            CustomTextFormField(
              hint: '비밀번호',
              obscureText: _obscureText.value,
              validator: FormValidator().validatePassword,
              onSaved: (String? value) {
                controller.userPassword.value =
                    controller.securePassword(value!);
              },
              suffixIcon: visibleIcon(),
            ),
            const SizedBox(height: 40),
            ExpandedTextButton(
              text: '로그인',
              action: _sendToServer,
            ),
            const SizedBox(height: 16),
            ExpandedTextButton(
              action: () => Get.toNamed('/signup'),
              text: '회원가입',
              textColor: Color(0xff5c74dd),
              backgroundColor: Colors.white,
              useBorder: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomTextButton(
                  text: '아이디 찾기',
                  action: () {}, //TODO: 찾기 메서드 추가
                  color: Colors.grey.shade600,
                ),
                const SizedBox(width: 20),
                CustomTextButton(
                  text: '비밀번호 찾기',
                  action: () {},
                  color: Colors.grey.shade600,
                ),
              ],
            ),
          ],
        ));
  }

  IconButton visibleIcon() {
    return IconButton(
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(),
      visualDensity: VisualDensity.comfortable,
      onPressed: _validate.value
          ? () {
              _obscureText.value = true;
              _validate.value = false;
            }
          : () {
              _obscureText.value = !_obscureText.value;
              _validate.value = false;
            },
      splashColor: Colors.transparent,
      iconSize: 20,
      icon: Icon(
        _obscureText.value ? Icons.visibility : Icons.visibility_off,
      ),
    );
  }

  Future<void> _sendToServer() async {
    if (_key.currentState!.validate()) {
      try {
        _key.currentState!.save();
        final controller = Get.put(UserController());
        await controller.signIn().then((value) async {
          final storage = FlutterSecureStorage();
          final storageData = await storage.read(key: 'login');
          if (storageData != null) {
            await Get.offAllNamed('/home');
          } else {
            throw Exception();
          }
        });
      } catch (e) {
        showSnackBar(AlertType.error, text: '아이디 혹은 비밀번호 오류입니다.');
      }
    }
  }
}
