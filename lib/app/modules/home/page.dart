import 'package:app_ignitemanager/app/modules/home/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ignite Manager'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bem-vindo ao Ignite Manager!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            buildStep('1. Realizar Login',
                'Abra o aplicativo e insira seus dados de login.'),
            buildStep('2. Cadastrar Cliente',
                'Acesse a seção de clientes e adicione um novo cliente.'),
            buildStep('3. Cadastrar Tag',
                'Vá até a seção de tags e registre uma nova tag.'),
            buildStep('4. Editar Tags do Cliente',
                'Na seção de clientes, edite as tags associadas a cada cliente.'),
          ],
        ),
      ),
    );
  }

  Widget buildStep(String title, String description) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          description,
          style: TextStyle(fontSize: 16),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
