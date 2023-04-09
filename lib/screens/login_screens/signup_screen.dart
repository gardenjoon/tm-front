import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/services/form_validator.dart';
import 'package:tm_front/services/login_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _loginData = Get.put(LoginRequestData());
  bool _obscureText = true;

  String? selectValidator(String name, String value) {
    if (name == '이름') {
      return FormValidator().validateName(value);
    } else if (name == '아이디') {
      return FormValidator().validateId(value);
    } else if (name.contains('비밀번호')) {
      return FormValidator().validatePassword(value);
    } else if (name.contains('확인')) {
      if (value != _passwordController.text) {
        return "비밀번호가 일치하지 않습니다.";
      }
    } else if (name == '이메일') {
      return FormValidator().validateEmail(value);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          backgroundColor: Colors.white,
          title: const Text("회원가입"),
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
                              titleWithForm("이름"),
                              titleWithForm("아이디"),
                              titleWithForm("비밀번호"),
                              titleWithForm("비밀번호 확인"),
                              titleWithForm("이메일"),
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
                                  onPressed: () => _goNextPage(),
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

  SizedBox titleWithForm(String name) {
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
          formField(name),
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
          " *",
          style: TextStyle(
            fontSize: 20,
            color: Colors.red.shade300,
          ),
        ),
      ],
    );
  }

  SizedBox formField(String name) {
    return SizedBox(
      height: 80,
      child: TextFormField(
        autofocus: name == '이름' ? true : false,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        obscureText: name.contains('비밀번호') ? _obscureText : false,
        textInputAction: TextInputAction.next,
        keyboardType:
            name == "이메일" ? TextInputType.emailAddress : TextInputType.text,
        controller: name == '비밀번호'
            ? _passwordController
            : name.contains('확인')
                ? confirmPasswordController
                : null,
        cursorColor: Colors.black87,
        cursorWidth: 0.8,
        style: const TextStyle(fontSize: 20),
        decoration: InputDecoration(
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
          suffixIconColor: Colors.grey,
          suffixIcon: name.contains('비밀번호')
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility : Icons.visibility_off,
                    semanticLabel:
                        _obscureText ? 'show password' : 'hide password',
                  ),
                )
              : null,
        ),
        validator: (value) {
          if (name == '이름') {
            return FormValidator().validateName(value);
          } else if (name == '아이디') {
            return FormValidator().validateId(value);
          } else if (name == "비밀번호") {
            return FormValidator().validatePassword(value);
          } else if (name.contains('확인')) {
            if (value != _passwordController.text) {
              return "비밀번호가 일치하지 않습니다.";
            } else {
              return FormValidator().validatePassword(value);
            }
          } else if (name == '이메일') {
            return FormValidator().validateEmail(value);
          }
          return null;
        },
        onSaved: (String? value) {
          if (name == '이름') {
            _loginData.data['name'] = value!;
          } else if (name == '아이디') {
            _loginData.data['id'] = value!;
          } else if (name == '비밀번호') {
            _loginData.data['password'] = value!;
          } else if (name == '이메일') {
            _loginData.data['email'] = value!;
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

  _goNextPage() {
    if (_key.currentState!.validate()) {
      _key.currentState!.save();
      LoginService.signUp();
      Get.toNamed('/basic_inform');
    } else {
      setState(() {
        _validate = true;
      });
    }
  }
}
