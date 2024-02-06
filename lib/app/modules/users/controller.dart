import 'package:app_ignitemanager/app/data/models/user.dart';
import 'package:app_ignitemanager/app/data/models/user_profile_request.dart';
import 'package:app_ignitemanager/app/data/services/auth/service.dart';
import 'package:app_ignitemanager/app/modules/users/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersController extends GetxController with StateMixin<List<UserModel>> {
  UsersRepository _repository;

  UsersController(this._repository);

  var selectedItem = 0.obs;

  var userId = 0.obs;

  var currentUserType = ''.obs;

  Future<UserModel> fetchUserDetails(int userId) async {
    try {
      var data = await _repository.getUserById(userId);

      return data;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<UserProfileRequestModel> registerUser(
      UserProfileRequestModel user) async {
    try {
      var data = await _repository.register(user);
      return user;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<UserModel> updateUser(UserModel user) async {
    try {
      var data = await _repository.putUser(
        UserModel(
          id: userId.value as int,
          name: user.name,
          type: user.type,
          email: user.email,
        ),
        userId.value as int,
      );

      return data;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<void> updateUsersList() async {
    _repository.getUsers().then(
      (data) {
        change(data, status: RxStatus.success());
      },
    );
  }

  @override
  void onInit() {
    _repository.getUsers().then(
      (data) {
        change(data, status: RxStatus.success());
      },
    );
    AuthService authService = Get.find<AuthService>();

    UserModel? currentUser = authService.user.value;
    currentUserType.value = currentUser!.type!;
    super.onInit();
  }
}
