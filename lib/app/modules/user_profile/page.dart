import 'package:app_ignitemanager/app/data/models/user.dart';
import 'package:app_ignitemanager/app/data/models/user_profile_request.dart';
import 'package:app_ignitemanager/app/modules/user_profile/controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserProfilePage extends GetView<UserProfileController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Meu Perfil')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: controller.fetchUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Nome:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.userName.value = value;
                    },
                    initialValue: controller.userName.value,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'E-mail:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.userEmail.value = value;
                    },
                    initialValue: controller.userEmail.value,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Password:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextFormField(
                    onChanged: (value) {
                      controller.newPassword.value = value;
                    },
                    obscureText: true,
                    style: TextStyle(fontSize: 16),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(12),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (controller.newPassword.value != '') {
                            controller.updateUserPassword(
                              UserProfileRequestModel(
                                  name: controller.userName.value,
                                  type: 'admin',
                                  email: controller.userEmail.value,
                                  password: controller.newPassword.value),
                            );
                          } else {
                            controller.updateUser(
                              UserModel(
                                name: controller.userName.value,
                                type: 'admin',
                                email: controller.userEmail.value,
                              ),
                            );
                          }
                        },
                        child: Text('Salvar Alterações'),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
