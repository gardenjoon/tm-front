import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/palette.dart';
import 'package:tm_front/models/login_model.dart';
import 'package:tm_front/services/form_validator.dart';

class SignInScreen extends StatefulWidget {
  static String tag = 'login-page';

  const SignInScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SignInScreenState();
  }
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> _key = GlobalKey();
  bool _validate = false;
  final LoginRequestData _loginData = LoginRequestData();
  final bool _obscureText = true;
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.mainBackgroud,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 640),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(height: 120),
                    Image.asset(
                      'assets/images/splash.png',
                      width: 200,
                    ),
                    const SizedBox(height: 100),
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
    return Column(
      children: [
        TextFormField(
          //아이디
          autovalidateMode: AutovalidateMode.disabled,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.next,
          autofocus: false,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: '아이디',
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
            errorStyle: const TextStyle(
              color: Color(0xff5c74dd),
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
            border: inputBorderDesign(Palette.greySub),
            enabledBorder: inputBorderDesign(Palette.greySub),
            focusedBorder: inputBorderDesign(Palette.main),
            errorBorder: inputBorderDesign(Palette.greySub),
            focusedErrorBorder: inputBorderDesign(Palette.main),
          ),
          validator: FormValidator().validateId,
          onSaved: (String? value) {
            // _loginData.email = value!;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
            //비밀번호
            autovalidateMode: AutovalidateMode.disabled,
            autofocus: false,
            controller: _passwordController,
            obscureText: _obscureText,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              hintText: '비밀번호',
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              errorStyle: const TextStyle(
                color: Color(0xff5c74dd),
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
              border: inputBorderDesign(Palette.greySub),
              enabledBorder: inputBorderDesign(Palette.greySub),
              focusedBorder: inputBorderDesign(Palette.main),
              errorBorder: inputBorderDesign(Palette.greySub),
              focusedErrorBorder: inputBorderDesign(Palette.main),
              suffixIconColor: Palette.greySub,
              suffixIcon: _validate
                  ? GestureDetector(
                      child: const Icon(
                        Icons.cancel,
                        size: 20,
                      ),
                      onTap: () => _passwordController.clear(),
                    )
                  : null,
            ),
            validator: FormValidator().validatePassword,
            onSaved: (String? value) {
            //   _loginData.password = value!;
            }),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: TextButton(
                    onPressed: _sendToServer,
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                      ),
                      backgroundColor: Palette.main,
                    ),
                    child: const Text('로그인',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 60,
                child: TextButton(
                    onPressed: () => Get.toNamed('/signup'),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28),
                        side: const BorderSide(
                          width: 1.6,
                          color: Palette.greySub,
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    child: const Text('회원가입',
                        style: TextStyle(
                          color: Color(0xff5c74dd),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ))),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 40,
              child: TextButton(
                onPressed: _showForgotPasswordDialog,
                child: Text(
                  '아이디 찾기',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 20),
            SizedBox(
              height: 40,
              child: TextButton(
                onPressed: _showForgotPasswordDialog,
                child: Text(
                  '비밀번호 찾기',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 40),
      ],
    );
  }

  OutlineInputBorder inputBorderDesign(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(25.0),
      borderSide: BorderSide(
        width: 1,
        color: color,
      ),
    );
  }

  _sendToServer() {
    if (_key.currentState!.validate()) {
      /// No any error in validation
      _key.currentState!.save();
    //   print("Email ${_loginData.email}");
    //   print("Password ${_loginData.password}");
    } else {
      ///validation error
      setState(() {
        _validate = true;
      });
    }
  }

  Future<void> _showForgotPasswordDialog() async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actionsAlignment: MainAxisAlignment.center,
            titlePadding: const EdgeInsets.symmetric(vertical: 20),
            title: const Text(
              '이메일을 입력해주세요',
              textAlign: TextAlign.center,
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
            content: TextField(
              autofocus: true,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Email',
                hintStyle: const TextStyle(),
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                errorStyle: const TextStyle(
                  color: Color(0xff5c74dd),
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
                border: inputBorderDesign(Colors.grey.shade300),
                enabledBorder: inputBorderDesign(Colors.grey.shade300),
                focusedBorder: inputBorderDesign(Palette.main),
              ),
              onChanged: (String value) {
                // _loginData.email = value;
              },
            ),
            actions: <Widget>[
              TextButton(
                  onPressed: () async {
                    // _loginData.email = "";
                    Navigator.pop(context);
                  },
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    fixedSize: const Size(120, 40),
                    backgroundColor: Palette.main,
                  ),
                  child: const Text('확인',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ))),
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                      side: BorderSide(
                        width: 1.6,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    fixedSize: const Size(120, 40),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text('취소',
                      style: TextStyle(
                        color: Color(0xff5c74dd),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ))),
            ],
          );
        });
  }
}
