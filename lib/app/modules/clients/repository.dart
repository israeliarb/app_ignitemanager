import 'package:app_ignitemanager/app/data/models/client.dart';
import 'package:app_ignitemanager/app/data/models/client_tag.dart';
import 'package:app_ignitemanager/app/data/models/tag.dart';
import 'package:app_ignitemanager/app/data/provider/api.dart';

class ClientsRepository {
  final Api _api;

  ClientsRepository(this._api);

  Future<List<ClientModel>> getClients() {
    return _api.getClients();
  }

  Future<ClientModel> getClientById(int clientId) {
    return _api.getClientById(clientId);
  }

  Future<List<TagModel>> getTags() {
    return _api.getTags();
  }

  Future<ClientModel> registerClient(ClientModel client) =>
      _api.registerClient(client);

  Future<ClientModel> updateClient(ClientModel client) =>
      _api.putClient(client);

  Future<ClientTagModel> registerClientTag(ClientTagModel clientTag) =>
      _api.registerClientTag(clientTag);

  Future<List<ClientTagModel>> getClientTags(int clientId) =>
      _api.getClientTags(clientId);

  Future<void> deleteClientTag(int id) => _api.deleteClientTag(id);

  Future<void> deleteClient(int id) => _api.deleteClient(id);
}
