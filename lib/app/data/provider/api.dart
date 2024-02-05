import 'dart:convert';

import 'package:app_ignitemanager/app/data/models/client.dart';
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

  Future<UserModel> putUser(UserProfileRequestModel data) async {
    var response = _errorHandler(await put('cliente', jsonEncode(data)));

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
