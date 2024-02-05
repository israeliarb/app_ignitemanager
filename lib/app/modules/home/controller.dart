import 'package:app_ignitemanager/app/data/models/user.dart';
import 'package:app_ignitemanager/app/modules/home/repository.dart';
import 'package:get/get.dart';

class HomeController extends GetxController with StateMixin<List<UserModel>> {
  HomeRepository _repository;

  HomeController(this._repository);
}
