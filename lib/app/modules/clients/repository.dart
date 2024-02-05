import 'package:app_ignitemanager/app/data/models/client.dart';
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
}
