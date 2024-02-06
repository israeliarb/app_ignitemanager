import 'package:app_ignitemanager/app/data/models/user.dart';
import 'package:app_ignitemanager/app/data/models/user_profile_request.dart';
import 'package:app_ignitemanager/app/data/provider/api.dart';

class UserProfileRepository {
  final Api _api;

  UserProfileRepository(this._api);

  Future<UserModel> getUser() {
    return _api.getUser();
  }

  Future<UserModel> putUser(UserModel userModel, int userId) =>
      _api.putUser(userModel, userId);

  Future<UserModel> putUserPassword(
          UserProfileRequestModel userProfileRequest, int userId) =>
      _api.putUserPassword(userProfileRequest, userId);
}
