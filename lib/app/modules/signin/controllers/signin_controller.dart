import 'dart:developer';

import 'package:get/get.dart';
import 'package:nhost_sdk/nhost_sdk.dart';

import '../../../shared/constant.dart';

final title = "SigninController";

class SigninController extends GetxController {
  RxString signInError = ''.obs;
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

  Future<bool> signInWithEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await nhostClient.auth
          .signInEmailPassword(email: email, password: password);
      return authResponse.user != null ? true : false;
    } on ApiException catch (e) {
      log('${e.responseBody['message']}');
      signInError.value = '${e.responseBody['message']}';
      return false;
    }
  }
}
