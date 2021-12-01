import 'package:authenticator/models/secure_otp.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';

class TotpController extends GetxController{

  var db = Hive.box('totp');

  RxList otpItems = [].obs;

  static TotpController get to => Get.find();


  @override
  void onInit() {
    otpItems.value = db.values.toList();
  }

  void saveTotp(SecureOtp totp){
    db.put(totp.secret, totp);
    otpItems.add(totp);
  }

  void deleteTotp(SecureOtp totp) {
    db.delete(totp);
    otpItems.remove(totp);
  }

}