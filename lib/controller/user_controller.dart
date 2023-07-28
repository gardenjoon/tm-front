import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:tm_front/components/snackBar.dart';
import 'package:tm_front/models/allergy.dart';
import 'package:tm_front/models/exercise.dart';
import 'package:tm_front/models/profile.dart';
import 'package:tm_front/services/login_service.dart';
import 'package:tm_front/services/profile_service.dart';

class UserController extends GetxController {
  late LoginRepository _loginRepository;
  late ProfileRepository _profileRepository = ProfileRepository();

  late final FlutterSecureStorage storage;

  RxString userId = ''.obs;
  RxString userAccount = ''.obs;
  RxString userPassword = ''.obs;

  @override
  void onInit() async {
    super.onInit();
    _loginRepository = LoginRepository();
    _profileRepository = ProfileRepository();
    storage = FlutterSecureStorage();

    if (userId.value != '') {
      await getProfile();
    }
  }

  Future<void> signIn() async {
    try {
      final value = await _loginRepository.signIn();
      await storage.write(key: 'login', value: value);

      await getProfile();
    } on TimeoutException {
      print('signin error');
      showSnackBar(AlertType.error, text: '로그인에러');
    }
  }

  Future<void> signUp() async {
    try {
      final value =
          await _loginRepository.signUp().timeout(Duration(seconds: 3));
      await storage.write(key: 'login', value: value);
    } on TimeoutException {
      showSnackBar(AlertType.error);
    }
  }

  Future<void> getProfile() async {
    try {
      final storageData = await storage.read(key: 'login');
      final id = jsonDecode(storageData!)['user_id'];
      userId.value = id;
      await _profileRepository
          .getProfile(userId.value)
          .timeout(Duration(seconds: 1));
    } on TimeoutException {
      showSnackBar(AlertType.error);
    }
  }

  Future<void> updateProfile() async {
    print('called update');
    await _profileRepository
        .updateProfile(userId.value)
        .timeout(Duration(seconds: 1));
  }

  // profile
  Rx<Profile> userProfile = Profile().obs;
  RxString passwordConfirm = ''.obs;
  RxBool accountDuplicate = false.obs;

  Future<void> checkId(String account) async {
    try {
      accountDuplicate.value = await _profileRepository
          .checkId(account)
          .timeout(Duration(seconds: 2));
    } on TimeoutException {
      showSnackBar(AlertType.error);
    }
  }

  String securePassword(String password) {
    final key = utf8.encode(password);
    final bytes = utf8.encode(sha256.convert(key).toString());

    var hamcSha256 = Hmac(sha256, key);
    return hamcSha256.convert(bytes).toString();
  }

  void setProfile({required dynamic value, required String formName}) {
    userProfile.value =
        Profile.fromMap({...userProfile.toJson(), formName: value});
  }

  dynamic setInitValue(formName) {
    switch (formName) {
      case 'gender':
        return userProfile.value.gender ?? 0;
      case 'height':
        if (userProfile.value.gender == 1) {
          return userProfile.value.height ?? 170;
        }
        if (userProfile.value.gender == 2 || userProfile.value.gender == 3) {
          return userProfile.value.height ?? 160;
        }
        return 0;
      case 'weight':
        if (userProfile.value.gender == 1) {
          return userProfile.value.weight ?? 70;
        }
        if (userProfile.value.gender == 2 || userProfile.value.gender == 3) {
          return userProfile.value.weight ?? 50;
        }
        return 0;
      case 'birth':
        return userProfile.value.birth ?? '20000101';
    }
    return 0;
  }

  dynamic setGenList(formName) {
    switch (formName) {
      case 'gender':
        return ['선택', '남자', '여자', '임산부'];
      case 'height':
        return List.generate(251, (i) => i).toList();
      case 'weight':
        return List.generate(456, (i) => i).toList();
    }
    return [];
  }

  RxList<AllergySet> allergyList = <AllergySet>[].obs;
  RxList selectedAllergy = [].obs;

  Future<void> getAllergy() async {
    try {
      allergyList.value =
          await _profileRepository.getAllergy().timeout(Duration(seconds: 2));
    } on TimeoutException {
      showSnackBar(AlertType.error);
    }
  }

  bool checkAllergy(Allergy allergy_item) {
    for (var allergy in selectedAllergy) {
      if (allergy.allergy_id == allergy_item.allergy_id) {
        return true;
      }
    }
    return false;
  }

  void addAllergy(Allergy allergy_item) {
    selectedAllergy.add(allergy_item);
  }

  void removeAllergy(Allergy allergy_item) {
    var target_allergy;
    for (var allergy in selectedAllergy) {
      if (allergy.allergy_id == allergy_item.allergy_id) {
        target_allergy = allergy;
      }
    }
    selectedAllergy.remove(target_allergy);
  }

  Rx<Exercise> exerciseData = Exercise(
    hard: ExerciseDHM(days: 0, hours: 0, minutes: 0),
    middle: ExerciseDHM(days: 0, hours: 0, minutes: 0),
    walk: ExerciseDHM(days: 0, hours: 0, minutes: 0),
  ).obs;

  dynamic selectExercise(hardness) {
    exerciseData.value.hard.days;
    switch (hardness) {
      case 'hard':
        return exerciseData.value.hard;
      case 'middle':
        return exerciseData.value.middle;
      case 'walk':
        return exerciseData.value.walk;
    }
  }
}
