import 'package:app_ignitemanager/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Ignite Manager')),
      //body: controller.obx((state) => Text('Ok')),
      body: Text('Ok'),
    );
  }
}