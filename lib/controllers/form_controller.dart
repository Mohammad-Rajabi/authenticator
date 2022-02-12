import 'package:authenticator/models/secure_otp.dart';
import 'package:authenticator/repositroy/data_base_handler.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:validated/validated.dart' as validate;
import 'package:base32/base32.dart';

class FormController extends GetxController {
  late GlobalKey<FormState> formKey;
  late var dbHandler;

  @override
  void onInit() {
    formKey = GlobalKey();
    dbHandler = DBHandler();
  }

  String? accountNameValidate(String? value) {
    if (value!.isEmpty) {
      return "required";
    } else {
      return null;
    }
  }

  String? secretKeyValidate(String? value) {
    if (value!.isEmpty) {
      return "required";
    }
    if (value.length < 12) {
      return "Cannot be less than 12 letters";
    } else {
      if(!RegExp(r'^[A-Za-z0-9]+$').hasMatch(value)) {
        return "Must contain letters and numbers";
      }
      return null;
    }
  }

  void addTotp(String secretKey, String accountName) {
    if (formKey.currentState!.validate()) {
      var result = isBase32Secret(secretKey);

      if (result != null) {
        SecureOtp secureOtp =
            SecureOtp(secret: result, accountName: accountName);

        dbHandler.saveTotp(secureOtp);
        Get.back(result: secureOtp);
      }
    }
  }

  String? isBase32Secret(String secretKey) {
    String? secret;
    if (validate.isAlphanumeric(secretKey)) {
      if (!validate.isBase32(secretKey)) {
        secret = base32.encodeString(secretKey);
      }
    }
    return secret;
  }
}
