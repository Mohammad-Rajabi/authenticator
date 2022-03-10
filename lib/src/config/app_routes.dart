import 'package:authenticator/src/view/screens/form/form_page.dart';
import 'package:authenticator/src/view/screens/home/home_page.dart';
import 'package:get/get.dart';

class AppRoutes {
  static const String homeRoute = "/home";
  static const String formRoute = "/form";

  static List<GetPage> getPages() {
    return [
      GetPage(name: '/', page: () => HomePage()),
      GetPage(name: '/form', page: () => FormPage())
    ];
  }
}
