import 'package:authenticator/models/secure_otp.dart';
import 'package:authenticator/pages/form_page.dart';
import 'package:authenticator/repositroy/data_base_handler.dart';
import 'package:authenticator/utility/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TotpController extends GetxController {
  RxList otpItems = [].obs;

  static TotpController get to => Get.find();

  late var dbHandler;

  @override
  void onInit() {

    dbHandler = DBHandler();
    otpItems.value = dbHandler.totpBox.values.toList();
  }

  void deleteTotp(SecureOtp totp) {
    dbHandler.delete(totp);
    otpItems.remove(totp);
  }

  void navigateToFormPage() {
    Get.to(FormPage())?.then((value) {
      if(value!= null)otpItems.add(value);
    });
  }

  void changeTheme() => ThemeService().switchTheme();
}
