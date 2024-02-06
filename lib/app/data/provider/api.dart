import 'dart:convert';

import 'package:app_ignitemanager/app/data/models/client.dart';
import 'package:app_ignitemanager/app/data/models/client_tag.dart';
import 'package:app_ignitemanager/app/data/models/tag.dart';
import 'package:app_ignitemanager/app/data/models/user.dart';
import 'package:app_ignitemanager/app/data/models/user_login_request.dart';
import 'package:app_ignitemanager/app/data/models/user_login_response.dart';
import 'package:app_ignitemanager/app/data/models/user_profile_request.dart';
import 'package:app_ignitemanager/app/data/services/storage/service.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/request/request.dart';

class Api extends GetConnect {
  final _storageService = Get.find<StorageService>();

  @override
  void onInit() {
    httpClient.baseUrl = 'http://10.0.2.2:3333/';

    httpClient.addRequestModifier((Request request) {
      request.headers['Accept'] = 'application/json';
      request.headers['Content-Type'] = 'application/json';

      return request;
    });

    httpClient.addAuthenticator((Request request) {
      var token = _storageService.token;
      var headers = {'Authorization': "Bearer $token"};

      request.headers.addAll(headers);

      return request;
    });

    super.onInit();
  }

  Future<List<UserModel>> getUsers() async {
    var response = _errorHandler(await get('user/'));

    List<UserModel> data = [];
    for (var user in response.body) {
      data.add(UserModel.fromJson(user));
    }

    return data;
  }

  Future<List<ClientModel>> getClients() async {
    var response = _errorHandler(await get('client/'));

    List<ClientModel> data = [];
    for (var client in response.body) {
      data.add(ClientModel.fromJson(client));
    }

    return data;
  }

  Future<ClientModel> getClientById(int clientId) async {
    var response = _errorHandler(await get('client/$clientId'));

    if (response.statusCode == 200) {
      return ClientModel.fromJson(response.body);
    } else {
      throw Exception('Falha ao buscar o cliente por ID');
    }
  }

  Future<ClientModel> putClient(ClientModel client) async {
    int clientId = client.id!;
    try {
      Map<String, dynamic> clientData = {
        'name': client.name,
        'email': client.email,
        'last_update_by': client.lastUpdateBy,
      };

      var response = await put('client/$clientId', jsonEncode(clientData));

      return ClientModel.fromJson(response.body);
    } catch (e) {
      throw Exception('Erro durante a comunicação com o servidor: $e');
    }
  }

  Future<ClientModel> registerClient(ClientModel client) async {
    try {
      Map<String, dynamic> clientData = {
        'name': client.name,
        'email': client.email,
        'created_by': client.createdBy,
        'last_update_by': client.lastUpdateBy,
      };

      var response =
          _errorHandler(await post('client', jsonEncode(clientData)));

      return ClientModel.fromJson(response.body);
    } catch (e) {
      throw Exception('Erro durante a comunicação com o servidor: $e');
    }
  }

  Future<ClientTagModel> registerClientTag(ClientTagModel clientTag) async {
    try {
      Map<String, dynamic> clientTagData = {
        'client_id': clientTag.clientId,
        'tag_id': clientTag.tagId,
      };

      var response =
          _errorHandler(await post('client-tag/', jsonEncode(clientTagData)));

      return ClientTagModel.fromJson(response.body);
    } catch (e) {
      throw Exception('Erro durante a comunicação com o servidor: $e');
    }
  }

  Future<List<ClientTagModel>> getClientTags(int id) async {
    var response = _errorHandler(await get('client/$id/client-tags/'));

    List<ClientTagModel> data = [];
    for (var clientTag in response.body) {
      data.add(ClientTagModel.fromJson(clientTag));
    }

    return data;
  }

  Future<void> deleteClientTag(int id) async {
    _errorHandler(await delete('client-tag/$id/'));
  }

  Future<void> deleteClient(int id) async {
    _errorHandler(await delete('client/$id/'));
  }

  Future<List<TagModel>> getTags() async {
    var response = _errorHandler(await get('tag/'));

    List<TagModel> data = [];
    for (var client in response.body) {
      data.add(TagModel.fromJson(client));
    }

    return data;
  }

  Future<TagModel> getTagById(int tagId) async {
    var response = _errorHandler(await get('tag/$tagId'));

    if (response.statusCode == 200) {
      return TagModel.fromJson(response.body);
    } else {
      throw Exception('Falha ao buscar a tag por ID');
    }
  }

  Future<TagModel> putTag(TagModel tag) async {
    int tagId = tag.id!;
    try {
      Map<String, dynamic> tagData = {
        'name': tag.name,
        'active': tag.active,
      };

      var response = await put('tag/$tagId', jsonEncode(tagData));

      return TagModel.fromJson(response.body);
    } catch (e) {
      throw Exception('Erro durante a comunicação com o servidor: $e');
    }
  }

  Future<TagModel> registerTag(TagModel tag) async {
    try {
      Map<String, dynamic> tagData = {
        'name': tag.name,
        'active': tag.active,
      };

      var response = _errorHandler(await post('tag', jsonEncode(tagData)));

      return TagModel.fromJson(response.body);
    } catch (e) {
      throw Exception('Erro durante a comunicação com o servidor: $e');
    }
  }

  Future<UserLoginResponseModel> login(UserLoginRequestModel data) async {
    var response = _errorHandler(await post('login', jsonEncode(data)));

    return UserLoginResponseModel.fromJson(response.body);
  }

  Future<UserModel> register(UserProfileRequestModel data) async {
    var response = _errorHandler(await post('user', jsonEncode(data)));

    return UserModel.fromJson(response.body);
  }

  Future<UserModel> getUser() async {
    var response = _errorHandler(await get('auth/me'));

    return UserModel.fromJson(response.body);
  }

  Future<UserModel> getUserById(int userId) async {
    var response = _errorHandler(await get('user/$userId'));

    if (response.statusCode == 200) {
      return UserModel.fromJson(response.body);
    } else {
      throw Exception('Falha ao buscar o usuário por ID');
    }
  }

  Future<UserModel> putUser(UserModel user, int userId) async {
    var data = {
      'name': user.name,
      'email': user.email,
      'password': ' ',
    };
    var response = _errorHandler(await put('user/$userId/', jsonEncode(data)));

    print(response.body);
    return UserModel.fromJson(response.body);
  }

  Future<UserModel> putUserPassword(
      UserProfileRequestModel data, int userId) async {
    var response = _errorHandler(await put('user/$userId/', jsonEncode(data)));

    return UserModel.fromJson(response.body);
  }

  Response _errorHandler(Response response) {
    print(response.bodyString);

    switch (response.statusCode) {
      case 200:
      case 202:
      case 204:
        return response;
      default:
        throw 'Ocorreu um erro';
    }
  }
}
