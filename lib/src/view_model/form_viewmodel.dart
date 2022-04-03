import 'package:authenticator/src/core/constant/general_constants.dart';
import 'package:authenticator/src/data/local/data_base_handler.dart';
import 'package:authenticator/src/data/models/secure_otp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:base32/base32.dart';

class FormViewModel extends GetxController {

  late GlobalKey<FormState> _formKey;

  GlobalKey<FormState> get formKey => _formKey;
  late var dbHandler;

  @override
  void onInit() {
    _formKey = GlobalKey();
    dbHandler = DBHandler();
  }

  void addTotp(String secretKey, String accountName) {
    if (formKey.currentState!.validate()) {
      var result = checkSecret(secretKey);

      if (result != null) {
        SecureOtp secureOtp =
        SecureOtp(secret: result, accountName: accountName);

        dbHandler.saveTotp(secureOtp);
        Get.back(result: secureOtp);
      }
    }
  }

  String? checkSecret(String secretKey) {
    String secret = secretKey;
    if (!isBase32(secret)) {
      if (AlphaRegex.hasMatch(secret) || AlphaNumericRegex.hasMatch(secret))
        secret = base32.encodeString(secret);
    }
    return secret;
  }

  bool isBase32(String input) {
    if (input.toString().length > 0 &&
        input.toString().length % 8 == 0 &&
        Base32Regex.hasMatch(input)) {
      return true;
    } else {
      return false;
    }
  }
}
