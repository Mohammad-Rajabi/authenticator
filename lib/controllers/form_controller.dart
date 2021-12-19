import 'package:authenticator/controllers/totp_controller.dart';
import 'package:authenticator/models/secure_otp.dart';
import 'package:authenticator/repositroy/data_base_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FormController extends GetxController {
  late GlobalKey<FormState> formKey;
  late var dbHandler;

  @override
  void onInit() {
    formKey = GlobalKey();
    dbHandler = DBHandler();
  }

  void addTotp(SecureOtp secureOtp) {
    if(formKey.currentState!.validate()){
      dbHandler.saveTotp(secureOtp);
      Get.back(result:secureOtp);
    }
  }

}
