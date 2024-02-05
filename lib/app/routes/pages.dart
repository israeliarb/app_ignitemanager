import 'package:app_ignitemanager/app/modules/dashboard/binding.dart';
import 'package:app_ignitemanager/app/modules/dashboard/page.dart';
import 'package:app_ignitemanager/app/modules/login/binding.dart';
import 'package:app_ignitemanager/app/modules/login/page.dart';
import 'package:app_ignitemanager/app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.dashboard,
      page: () => DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: Routes.login,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
  ];
}

class RedirectMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    return null;
  }
}
