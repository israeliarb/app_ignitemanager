import 'package:app_ignitemanager/app/modules/clients/page.dart';
import 'package:app_ignitemanager/app/modules/dashboard/controller.dart';
import 'package:app_ignitemanager/app/modules/home/page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DashboardPage extends GetView<DashboardController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          onDestinationSelected: controller.changePageIndex,
          selectedIndex: controller.currentPageIndex.value,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.home_outlined),
              label: 'Início',
              selectedIcon: Icon(Icons.home),
            ),
            NavigationDestination(
              icon: Icon(Icons.people_alt_outlined),
              label: 'Clientes',
              selectedIcon: Icon(Icons.people_alt),
            ),
            NavigationDestination(
              icon: Icon(Icons.bookmark_outline),
              label: 'Tags',
              selectedIcon: Icon(Icons.bookmark),
            ),
            NavigationDestination(
              icon: Icon(Icons.person_2_outlined),
              label: 'Meu Perfil',
              selectedIcon: Icon(Icons.person_2),
            ),
          ],
        ),
      ),
      body: Obx(
        () => IndexedStack(
          index: controller.currentPageIndex.value,
          children: [
            HomePage(),
            ClientsPage(),
            Text('Tags'),
            Text('Meu Perfil'),
          ],
        ),
      ),
    );
  }
}
