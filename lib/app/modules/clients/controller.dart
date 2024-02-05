import 'package:app_ignitemanager/app/data/models/client.dart';
import 'package:app_ignitemanager/app/modules/clients/repository.dart';
import 'package:get/get.dart';

class ClientsController extends GetxController
    with StateMixin<List<ClientModel>> {
  ClientsRepository _repository;

  ClientsController(this._repository);

  var selectedItem = 0.obs;

  var clientId = 0.obs;

  Future<ClientModel> fetchClientDetails(int clientId) async {
    try {
      var data = await _repository.getClientById(clientId);

      return data;
    } catch (e) {
      throw Exception('Erro ao processar a resposta do servidor');
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
