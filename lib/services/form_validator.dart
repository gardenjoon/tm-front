class FormValidator {
  static FormValidator? _instance;

  factory FormValidator() => _instance ??= FormValidator._();

  FormValidator._();

  String? validateName(String? value) {
    if (value!.isEmpty) {
      return '이름을 입력해주세요';
    }
    return null;
  }

  String? validateId(String? value) {
    var patttern = r'^(?=.*[a-zA-Z])(?=.*\d).{5,}$';
    var regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return '아이디를 입력해주세요';
    } else if (!regExp.hasMatch(value)) {
      return '아이디는 영문, 숫자 포함 최소 5글자 이상이어야 합니다';
    }
    return null;
  }

  String? validatePassword(String? value) {
    var patttern = r'^(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d\S]{8,20}';
    var regExp = RegExp(patttern);
    if (value!.isEmpty) {
      return '비밀번호를 입력해주세요';
    } else if (value.length < 8 || value.length > 20) {
      return '비밀번호는 최소 8글자 이상 최대 20글자 이하여야 합니다';
    } else if (!regExp.hasMatch(value)) {
      return '비밀번호는 하나 이상의 영문, 숫자가 혼합되어야 합니다';
    }
    return null;
  }

  String? validateEmail(String? value) {
    var pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    var regExp = RegExp(pattern);
    if (value!.isEmpty) {
      return '이메일을 입력해주세요';
    } else if (!regExp.hasMatch(value)) {
      return '유효하지 않은 이메일입니다';
    } else {
      return null;
    }
  }

  String? validateBasicInform(String? value, name) {
    RegExp regExp;
    if (name == '신장') {
      regExp = RegExp(r'\d{1,3}');
    } else {
      regExp = RegExp(r'\d{1,2}');
    }

    if (value!.isEmpty) {
      return '$name을 입력해주세요';
    } else if (!regExp.hasMatch(value)) {
      return '$name이 형식에 맞지 않습니다.';
    }

    return null;
  }
}
