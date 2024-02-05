import 'package:app_ignitemanager/app/data/models/user_login_request.dart';
import 'package:app_ignitemanager/app/data/services/auth/service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final _authService = Get.find<AuthService>();
  var emailController = TextEditingController(text: 'admin@email.com');
  var passwordController = TextEditingController(text: '123456');

  void login() {
    Get.focusScope!.unfocus();

    var userLoginRequestModel = UserLoginRequestModel(
      email: emailController.text,
      password: passwordController.text,
    );

    _authService.login(userLoginRequestModel).then((value) {
      Get.toNamed('/home');
    }, onError: (error) {
      Get.dialog(AlertDialog(
        title: Text(error.toString()),
      ));
    });
  }
}
