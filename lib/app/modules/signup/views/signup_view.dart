import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../../../shared/background.dart';
import '../../../shared/constant.dart';
import '../../../shared/custom_flat_button.dart';
import '../../../shared/responsive.dart';
import '../../../shared/validator.dart';
import '../controllers/signup_controller.dart';

class SignupView extends StatelessWidget {
  SignupView({Key? key}) : super(key: key);
  SignupController controller = Get.put(SignupController());
  final _formKey = GlobalKey<FormState>();
  final _textEmail = TextEditingController();
  final _textPassword = TextEditingController();
  final _textDealerCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textEmail.text = "ppsuperwheel.b2b@gmail.com";
    _textPassword.text = "P@ssw0rd";
    _textDealerCode.text = "CL1713";
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Container(
          alignment: Alignment.centerLeft,
          width: 120,
          child: Image.network(
            'assets/images/pp_white.png',
          ),
        ),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Responsive(
            mobile: Container(),
            desktop: Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Spacer(),
                          Expanded(
                            flex: 6,
                            child: SvgPicture.network(
                                "assets/icons/undraw_mobile_login_re_9ntv.svg"),
                          ),
                          const Spacer(),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 450,
                        child: Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                cursorColor: primaryColor,
                                controller: _textEmail,
                                decoration: const InputDecoration(
                                  hintText: 'Your Email',
                                  prefixIcon: Icon(Icons.email_outlined),
                                ),
                                validator: (value) =>
                                    validateNotEmpty(value!, 'Your Email'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  obscureText: true,
                                  cursorColor: primaryColor,
                                  controller: _textPassword,
                                  decoration: const InputDecoration(
                                    hintText: 'Your Password',
                                    prefixIcon: Icon(Icons.lock),
                                  ),
                                  validator: (value) =>
                                      validateNotEmpty(value!, 'Your Password'),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                child: TextFormField(
                                  textInputAction: TextInputAction.done,
                                  obscureText: false,
                                  cursorColor: primaryColor,
                                  controller: _textDealerCode,
                                  decoration: const InputDecoration(
                                    hintText: "Your Member Code",
                                    prefixIcon:
                                        Icon(Icons.card_membership_outlined),
                                  ),
                                  validator: (value) => validateNotEmpty(
                                      value!, 'Your Member Code'),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(
                                    vertical: defaultPadding),
                                child: CustomFlatButton(
                                  label: 'Sign Up'.toUpperCase(),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      final result = await controller
                                          .signUpWithEmailPassword(
                                        email: _textEmail.text,
                                        password: _textPassword.text,
                                        dealerCode: _textDealerCode.text,
                                      );
                                      if (result) {
                                        Get.defaultDialog(
                                          title: "Signup Finish.",
                                          middleText:
                                              "Please verify email and signin",
                                          backgroundColor: primaryColor,
                                          titleStyle: const TextStyle(
                                              color: Colors.white),
                                          middleTextStyle: const TextStyle(
                                              color: Colors.white),
                                          radius: 30,
                                          buttonColor: primaryColor,
                                          onConfirm: () =>
                                              Get.offAllNamed(Routes.SIGNIN),
                                        );
                                      } else {
                                        Get.snackbar(
                                          'Error',
                                          controller.signUpError.value,
                                          backgroundColor: accentColor,
                                          snackPosition: SnackPosition.BOTTOM,
                                          colorText: Colors.white,
                                          icon: const Icon(
                                            Icons.lock_person_outlined,
                                            color: Colors.white,
                                          ),
                                          isDismissible: true,
                                          margin: const EdgeInsets.all(
                                            defaultPadding,
                                          ),
                                        );
                                      }
                                    }
                                  },
                                ),
                              ),
                              const SizedBox(height: defaultPadding),
                              Text(
                                'มีบัญชีเรียบร้อยแล้ว',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              const SizedBox(height: defaultPadding),
                              TextButton(
                                onPressed: () => Get.offAllNamed(Routes.SIGNIN),
                                child: const Text(
                                  'เข้าสู่ระบบ',
                                  style: TextStyle(
                                    color: primaryLightColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
    );
  }
}
