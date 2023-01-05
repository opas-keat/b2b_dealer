import 'dart:developer';

import 'package:get/get.dart';
import 'package:nhost_sdk/nhost_sdk.dart';

import '../../../shared/constant.dart';

class SignupController extends GetxController {
  RxString signUpError = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<bool> signUpWithEmailPassword(
      {required String email, required String password}) async {
    try {
      final authResponse =
          await nhostClient.auth.signUp(email: email, password: password);
      return authResponse.user != null ? true : false;
    } on ApiException catch (e) {
      log('${e.responseBody['message']}');
      signUpError.value = '${e.responseBody['message']}';
      return false;
    }
  }
}
