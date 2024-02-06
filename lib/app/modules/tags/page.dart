import 'package:app_ignitemanager/app/core/theme/app_theme.dart';
import 'package:app_ignitemanager/app/data/models/tag.dart';
import 'package:app_ignitemanager/app/modules/tags/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TagsPage extends GetView<TagsController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Gestão de Tags'),
          automaticallyImplyLeading: false,
        ),
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
                          'Tags cadastrados',
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
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  _openEditModal();
                },
                child: Text('Criar Tag'),
              ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (controller.selectedItem.value == 0) {
                    Get.snackbar(
                      'Erro',
                      'Nenhuma tag selecionada. Selecione uma tag antes de editar.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    _openEditModal(tagId: controller.selectedItem.value);
                  }
                },
                child: Text('Editar Tag'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openEditModal({int? tagId}) async {
    TagModel tag;

    if (tagId != null) {
      tag = await controller.fetchTagDetails(tagId);
    } else {
      tag = TagModel(name: '', active: false);
    }

    TextEditingController nameController =
        TextEditingController(text: tag.name);

    Get.defaultDialog(
      title: 'Editar Tag',
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
            ListTile(
              leading: Obx(
                () => Checkbox(
                  value: controller.editModalController.isChecked.value,
                  onChanged: (value) {
                    controller.editModalController.isChecked.value = value!;
                  },
                ),
              ),
              title: Text('Ativar/Desativar'),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      confirm: ElevatedButton(
        onPressed: () async {
          tag.name = nameController.text;

          if (tagId != null) {
            await controller.updateTag(TagModel(
              id: tagId,
              name: tag.name,
              active: controller.editModalController.isChecked.value,
            ));
          } else {
            await controller.registerTag(TagModel(
              name: tag.name,
              active: controller.editModalController.isChecked.value,
            ));
          }

          await controller.updateTagList();

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
}
