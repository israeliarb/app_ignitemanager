import 'package:app_ignitemanager/app/core/theme/app_theme.dart';
import 'package:app_ignitemanager/app/data/models/user.dart';
import 'package:app_ignitemanager/app/data/models/user_profile_request.dart';
import 'package:app_ignitemanager/app/modules/users/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsersPage extends GetView<UsersController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: Text('Gestão de Usuários')),
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
                          'Usuários cadastrados',
                          style: TextStyle(
                              fontSize: 18.0, fontWeight: FontWeight.bold),
                        ),
                      ),
                      controller.obx(
                        (state) => Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              for (var user in state!)
                                Obx(
                                  () => RadioListTile(
                                    title: Text(
                                      user.name,
                                      style: const TextStyle(fontSize: 14.0),
                                    ),
                                    value: user.id,
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
              if (controller.currentUserType == 'admin')
                ElevatedButton(
                  onPressed: () async {
                    _openEditModal();
                  },
                  child: Text('Criar Usuário'),
                ),
              const SizedBox(
                height: 30.0,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (controller.selectedItem.value == 0) {
                    Get.snackbar(
                      'Erro',
                      'Nenhum Usuário selecionado. Selecione um Usuário antes de editar.',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    _openEditModal(userId: controller.selectedItem.value);
                  }
                },
                child: Text('Editar Usuário'),
              ),
              const SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openEditModal({int? userId}) async {
    UserModel user;

    if (userId != null) {
      user = await controller.fetchUserDetails(userId);
    } else {
      user = UserModel(name: '', email: '');
    }

    TextEditingController nameController =
        TextEditingController(text: user.name);

    TextEditingController emailController =
        TextEditingController(text: user.email);

    Get.defaultDialog(
      title: 'Editar Usuário',
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
          user.name = nameController.text;
          user.email = emailController.text;

          if (userId != null) {
            await controller.updateUser(UserModel(
              id: userId,
              name: user.name,
              email: user.email,
            ));
          } else {
            await controller.registerUser(UserProfileRequestModel(
              name: user.name,
              email: user.email,
              type: 'user',
              password: '123456',
            ));
          }

          await controller.updateUsersList();

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
