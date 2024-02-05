import 'package:app_ignitemanager/app/modules/dashboard/controller.dart';
import 'package:app_ignitemanager/app/modules/login/controller.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<DashboardController>(() => DashboardController());
  }
}
