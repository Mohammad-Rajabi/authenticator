import 'package:authenticator/src/config/app_routes.dart';
import 'package:authenticator/src/data/local/data_base_handler.dart';
import 'package:authenticator/src/data/local/theme_service.dart';
import 'package:get/get.dart';
import 'package:otp/otp.dart';

import '../data/models/secure_otp.dart';

class TotpViewModel extends GetxController {
  RxList otpItems = [].obs;

  late var dbHandler;

  @override
  void onInit() {
    dbHandler = Get.find<DBHandler>();
    otpItems.value = dbHandler.totpBox.values.toList();
  }

  void navigateToFormPage() {
    Get.toNamed(AppRoutes.formRoute)?.then((value) {
      if (value != null) {
        otpItems.add(value);
      }
    });
  }

  void changeTheme() => Get.find<ThemeService>().switchTheme();


  String getOtp(SecureOtp secureOtp) {
    return OTP.generateTOTPCodeString(
      secureOtp.secret,
      DateTime.now().millisecondsSinceEpoch,
      algorithm: getAlgorithm(secureOtp.algorithm),
      isGoogle: true,
    );
  }

  Algorithm getAlgorithm(String algorithm) {
    switch (algorithm) {
      case 'SHA256':
        return Algorithm.SHA256;
      case 'SHA512':
        return Algorithm.SHA512;
      case 'SHA1':
        return Algorithm.SHA1;
      default:
        return Algorithm.SHA256;
    }
  }
}
