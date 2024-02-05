import 'dart:ffi';

import 'package:app_ignitemanager/app/data/models/tag.dart';
import 'package:app_ignitemanager/app/data/services/utils/edit_modal_controller.dart';
import 'package:app_ignitemanager/app/modules/tags/repository.dart';
import 'package:get/get.dart';

class TagsController extends GetxController with StateMixin<List<TagModel>> {
  TagsRepository _repository;
  TagsController(this._repository);

  final EditModalController editModalController = EditModalController();

  var selectedItem = 0.obs;

  var tagId = 0.obs;

  var newName = ''.obs;

  Future<TagModel> fetchTagDetails(int tagId) async {
    try {
      var data = await _repository.getTagById(tagId);

      editModalController.isChecked.value = data.active;

      return data;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<TagModel> registerTag(TagModel tag) async {
    try {
      var data = await _repository.registerTag(tag);
      editModalController.isChecked.value = data.active;

      return tag;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<TagModel> updateTag(TagModel tag) async {
    try {
      var data = await _repository.updateTag(tag);
      editModalController.isChecked.value = data.active;

      return tag;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<void> updateTagList() async {
    _repository.getTags().then(
      (data) {
        change(data, status: RxStatus.success());
      },
    );
  }

  @override
  void onInit() {
    _repository.getTags().then(
      (data) {
        change(data, status: RxStatus.success());
      },
    );
  }
}
