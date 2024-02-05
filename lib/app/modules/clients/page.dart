import 'package:app_ignitemanager/app/core/theme/app_theme.dart';
import 'package:app_ignitemanager/app/data/models/client.dart';
import 'package:app_ignitemanager/app/modules/clients/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ClientsPage extends GetView<ClientsController> {
  String searchText = '';

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Gestão de Clientes')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                height: Get.height * 0.3,
                decoration: BoxDecoration(
                  color: colorScheme.background,
                  borderRadius: BorderRadius.circular(12.0),
                  boxShadow: [
                    BoxShadow(
                      color: colorScheme.primary.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                  border: Border.all(
                    color: colorScheme.primary.withOpacity(0.2),
                    width: 1.0,
                  ),
                ),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(top: 16.0, bottom: 16.0),
                      child: Text(
                        'Clientes cadastrados',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                    ),
                    controller.obx(
                      (state) => ListView(
                        shrinkWrap: true,
                        children: [
                          for (var client in state!)
                            Obx(
                              () => RadioListTile(
                                title: Text(
                                  client.name,
                                  style: const TextStyle(fontSize: 14.0),
                                ),
                                value: client.id,
                                groupValue: controller.selectedItem.value,
                                onChanged: (value) {
                                  controller.selectedItem.value = value as int;
                                },
                                dense: true,
                              ),
                            )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 30.0,
            ),
            ElevatedButton(
              onPressed: () async {
                _openEditModal(await controller.fetchClientDetails(
                    controller.selectedItem.value) as ClientModel);
              },
              child: Text('Editar Cliente'),
            ),
          ],
        ),
      ),
    );
  }

  void _openEditModal(ClientModel client) {
    Get.defaultDialog(
      title: 'Editar Cliente',
      content: Container(
        width: Get.width * 0.7, // Ajuste o tamanho conforme necessário
        child: Column(
          children: [
            SizedBox(height: 16),
            TextFormField(
              controller: TextEditingController(text: client.name ?? ''),
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: TextEditingController(text: client.email ?? ''),
              decoration: InputDecoration(
                labelText: 'E-mail',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () {
          // Implemente a lógica de edição aqui
          Get.back(); // Fechar o modal após a edição
        },
        child: Text('Salvar'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back(); // Fechar o modal sem salvar
        },
        child: Text('Cancelar'),
      ),
    );
  }
}
