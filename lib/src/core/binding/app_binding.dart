import 'package:authenticator/src/data/local/data_base_handler.dart';
import 'package:authenticator/src/data/local/theme_service.dart';
import 'package:authenticator/src/view_model/form_viewmodel.dart';
import 'package:authenticator/src/view_model/totp_viewmodel.dart';
import 'package:get/get.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TotpViewModel());
    Get.put(FormViewModel());
    Get.lazyPut(() => DBHandler());
    Get.lazyPut(() => ThemeService());
  }
}
