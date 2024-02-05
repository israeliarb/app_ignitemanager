import 'package:app_ignitemanager/app/core/theme/app_theme.dart';
import 'package:app_ignitemanager/app/data/models/client.dart';
import 'package:app_ignitemanager/app/data/models/client_tag.dart';
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
        body: SingleChildScrollView(
          child: Column(
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
                        (state) => Expanded(
                          child: ListView(
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
                                      controller.selectedItem.value =
                                          value as int;
                                    },
                                    dense: true,
                                  ),
                                )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  _openEditModal();
                },
                child: Text('Criar Cliente'),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  _openEditModal(clientId: controller.selectedItem.value);
                },
                child: Text('Editar Cliente'),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  await controller.updateTagList();
                  _openTagsModal(clientId: controller.selectedItem.value);
                },
                child: Text('Editar Tags'),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  await _showDeleteConfirmationDialog(
                      controller.selectedItem.value);
                },
                child: Text('Excluir Cliente'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openEditModal({int? clientId}) async {
    await controller.updateTagList();
    ClientModel client;

    if (clientId != null) {
      client = await controller.fetchClientDetails(clientId);
    } else {
      client = ClientModel(name: '', email: '', lastUpdateBy: 1);
    }

    TextEditingController nameController =
        TextEditingController(text: client.name);

    TextEditingController emailController =
        TextEditingController(text: client.email);

    Get.defaultDialog(
      title: 'Editar Cliente',
      content: Container(
        width: Get.width * 0.7,
        child: Column(
          children: [
            SizedBox(height: 16),
            TextFormField(
              controller: nameController,
              decoration: InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextFormField(
              controller: emailController,
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
        onPressed: () async {
          client.name = nameController.text;
          client.email = emailController.text;

          if (clientId != null) {
            await controller.updateClient(ClientModel(
              id: clientId,
              name: client.name,
              email: client.email,
              lastUpdateBy: 1,
            ));
          } else {
            await controller.registerClient(ClientModel(
              name: client.name,
              email: client.email,
              createdBy: 1,
              lastUpdateBy: 1,
            ));
          }

          await controller.updateClientsList();

          Get.back();
        },
        child: Text('Salvar'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Cancelar'),
      ),
    );
  }

  void _openTagsModal({required int clientId}) async {
    await controller.getClientTags(clientId);

    if (controller.selectedItem.value != 0) {
      ClientTagModel clientTag = ClientTagModel(id: 0, clientId: 0, tagId: 0);

      Get.defaultDialog(
        title: 'Lista de Tags',
        backgroundColor: colorScheme.background,
        content: Container(
          width: Get.width * 0.7,
          height: Get.height * 0.7,
          child: ListView(
            shrinkWrap: true,
            children: [
              for (var tag in controller.tagsList)
                Obx(
                  () => CheckboxListTile(
                    title: Text(
                      tag.name,
                      style: TextStyle(
                        color: tag.active
                            ? Colors.black
                            : Colors.grey.withOpacity(0.5),
                      ),
                    ),
                    value: controller.clientTagsList
                        .any((clientTag) => clientTag.tagId == tag.id),
                    onChanged: (value) async {
                      if (tag.active) {
                        clientTag.clientId = clientId;
                        clientTag.tagId = tag.id!;
                        if (value == true) {
                          await controller.registerClientTag(clientTag);
                          controller.selectedTags.add(tag.id);
                        } else {
                          final clientTagToDelete = controller.clientTagsList
                              .firstWhere((ct) => ct.tagId == tag.id);

                          if (clientTagToDelete != null) {
                            await controller
                                .deleteClientTag(clientTagToDelete.id);
                          }
                        }
                        controller.getClientTags(clientId);
                      } else {}
                    },
                    controlAffinity: ListTileControlAffinity.trailing,
                    activeColor: tag.active ? Colors.blue : Colors.grey,
                  ),
                )
            ],
          ),
        ),
        confirm: ElevatedButton(
          onPressed: () async {
            await controller.updateClientsList();
            Get.back();
          },
          child: Text('Fechar'),
        ),
      );
    }
  }

  Future<void> _showDeleteConfirmationDialog(int clientId) async {
    return Get.defaultDialog(
      title: 'Confirmar Exclusão',
      middleText: 'Tem certeza que deseja excluir este cliente?',
      confirm: ElevatedButton(
        onPressed: () async {
          await controller.deleteClient(clientId);
          Get.back();
        },
        child: Text('Confirmar'),
      ),
      cancel: ElevatedButton(
        onPressed: () {
          Get.back();
        },
        child: Text('Cancelar'),
      ),
    );
  }
}
