import 'package:authenticator/src/config/app_routes.dart';
import 'package:authenticator/src/data/local/data_base_handler.dart';
import 'package:authenticator/src/data/local/theme_service.dart';
import 'package:get/get.dart';

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
}
