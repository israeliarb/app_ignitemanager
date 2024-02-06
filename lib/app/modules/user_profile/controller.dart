import 'package:app_ignitemanager/app/data/models/user.dart';
import 'package:app_ignitemanager/app/data/models/user_profile_request.dart';
import 'package:app_ignitemanager/app/data/services/auth/service.dart';
import 'package:app_ignitemanager/app/modules/user_profile/repository.dart';
import 'package:app_ignitemanager/app/routes/routes.dart';
import 'package:get/get.dart';

class UserProfileController extends GetxController {
  UserProfileRepository _repository;
  UserProfileController(this._repository);
  AuthService _authService = Get.find<AuthService>();

  var userName = ''.obs;
  var userEmail = ''.obs;
  var newPassword = ''.obs;
  var userId = Rx<int?>(null);

  @override
  void onInit() {
    super.onInit();
    // Fetch user data and update the variables
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    try {
      UserModel user = await _repository.getUser();
      userId.value = user.id;
      userName.value = user.name ?? '';
      userEmail.value = user.email ?? '';
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  Future<UserModel> updateUserPassword(UserProfileRequestModel user) async {
    try {
      var data = await _repository.putUserPassword(
        UserProfileRequestModel(
            name: user.name,
            type: user.type,
            email: user.email,
            password: user.password),
        userId.value as int,
      );

      return data;
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

  void logout() async {
    await _authService.logout();

    Get.offAllNamed(Routes.login);
  }
}
