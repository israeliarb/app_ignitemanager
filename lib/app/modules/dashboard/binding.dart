import 'package:app_ignitemanager/app/data/provider/api.dart';
import 'package:app_ignitemanager/app/modules/clients/controller.dart';
import 'package:app_ignitemanager/app/modules/clients/repository.dart';
import 'package:app_ignitemanager/app/modules/dashboard/controller.dart';
import 'package:app_ignitemanager/app/modules/home/controller.dart';
import 'package:app_ignitemanager/app/modules/home/repository.dart';
import 'package:app_ignitemanager/app/modules/tags/controller.dart';
import 'package:app_ignitemanager/app/modules/tags/repository.dart';
import 'package:get/get.dart';

class DashboardBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DashboardController>(() => DashboardController());
    Get.lazyPut<HomeController>(
        () => HomeController(HomeRepository(Get.find<Api>())));
    Get.lazyPut<ClientsController>(
        () => ClientsController(ClientsRepository(Get.find<Api>())));
    Get.lazyPut<TagsController>(
        () => TagsController(TagsRepository(Get.find<Api>())));
  }
}
