import 'package:app_ignitemanager/app/data/models/client.dart';
import 'package:app_ignitemanager/app/data/models/client_tag.dart';
import 'package:app_ignitemanager/app/data/models/tag.dart';
import 'package:app_ignitemanager/app/modules/clients/repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsController extends GetxController
    with StateMixin<List<ClientModel>> {
  ClientsRepository _repository;

  ClientsController(this._repository);

  var selectedItem = 0.obs;

  var clientId = 0.obs;

  var selectedTags = [].obs;

  final RxList<TagModel> tagsList = <TagModel>[].obs;
  final RxList<ClientTagModel> clientTagsList = <ClientTagModel>[].obs;

  Future<ClientModel> fetchClientDetails(int clientId) async {
    try {
      var data = await _repository.getClientById(clientId);

      return data;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<ClientModel> registerClient(ClientModel client) async {
    try {
      var data = await _repository.registerClient(client);
      return client;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<ClientModel> updateClient(ClientModel client) async {
    try {
      var data = await _repository.updateClient(client);
      return client;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<void> updateClientsList() async {
    _repository.getClients().then(
      (data) {
        change(data, status: RxStatus.success());
      },
    );
  }

  Future<void> updateTagList() async {
    try {
      final List<TagModel> tags = await _repository.getTags();
      tagsList.assignAll(tags);
    } catch (error) {
      print('Error fetching tags: $error');
    }
  }

  Future<ClientTagModel> registerClientTag(ClientTagModel clientTag) async {
    try {
      await _repository.registerClientTag(clientTag);
      return clientTag;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
    }
  }

  Future<void> getClientTags(int clientId) async {
    try {
      final List<ClientTagModel> clientTags =
          await _repository.getClientTags(clientId);
      clientTagsList.assignAll(clientTags);
    } catch (error) {
      print('Error fetching ClienTags: $error');
    }
  }

  Future<void> deleteClientTag(int clientTagId) async {
    try {
      await _repository.deleteClientTag(clientTagId);
    } catch (error) {
      print('Error deleting ClientTag: $error');
    }
  }

  Future<void> deleteClient(int clientId) async {
    try {
      await _repository.deleteClient(clientId);
      await updateClientsList();
    } catch (error) {
      print('Error deleting client: $error');
    }
  }

  @override
  void onInit() {
    _repository.getClients().then(
      (data) {
        change(data, status: RxStatus.success());
      },
    );
  }
}
