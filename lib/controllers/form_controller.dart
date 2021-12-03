import 'package:authenticator/controllers/totp_controller.dart';
import 'package:authenticator/models/secure_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  late GlobalKey<FormState> formKey;

  @override
  void onInit() {
    formKey = GlobalKey();
  }

  void addTotp(SecureOtp secureOtp) {
    if(formKey.currentState!.validate()){
      TotpController.to.saveTotp(secureOtp);
      Get.back();
    }
  }
}
