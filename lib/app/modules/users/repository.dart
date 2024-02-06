import 'package:app_ignitemanager/app/data/models/user.dart';
import 'package:app_ignitemanager/app/data/models/user_profile_request.dart';
import 'package:app_ignitemanager/app/data/provider/api.dart';

class UsersRepository {
  final Api _api;

  UsersRepository(this._api);

  Future<List<UserModel>> getUsers() {
    return _api.getUsers();
  }

  Future<UserModel> getUserById(int userId) {
    return _api.getUserById(userId);
  }

  Future<UserModel> register(UserProfileRequestModel user) =>
      _api.register(user);

  Future<UserModel> putUser(UserModel userModel, int userId) =>
      _api.putUser(userModel, userId);
}
