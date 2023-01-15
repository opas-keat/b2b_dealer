import 'dart:developer';

import 'package:get/get.dart';
import 'package:nhost_sdk/nhost_sdk.dart';

import '../../../api/services/dealer_service.dart';
import '../../../shared/constant.dart';

final logTitle = "SignupController";

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
      {required String email,
      required String password,
      required String dealerCode}) async {
    try {
      final result = await getDealerByCode(dealerCode);
      // Log.loga(title, 'signUpWithEmailPassword:: ${result!.statusCode == 200}');
      if (result) {
        final authResponse = await nhostClient.auth.signUp(
          email: email,
          password: password,
          metadata: {
            'dealerCode': dealerCode,
          },
        );
        if (authResponse.isBlank == false) {
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } on ApiException catch (e) {
      log('${e.responseBody['message']}');
      signUpError.value = '${e.responseBody['message']}';
      return false;
    }
  }

  Future<bool> getDealerByCode(String dealerCode) async {
    try {
      final result = await DealerService().getDealerByCode(dealerCode);
      if (result!.statusCode == 200) {
        return true;
      }
      signUpError.value = result.message!;
      return false;
    } on ApiException catch (e) {
      log('${e.responseBody['message']}');
      signUpError.value = '${e.responseBody['message']}';
      return false;
    }
  }
}
