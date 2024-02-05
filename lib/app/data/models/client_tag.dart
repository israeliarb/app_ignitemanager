import 'package:get/get.dart';

class ClientTagModel extends GetxController {
  int id;
  int clientId;
  int tagId;

  var isChecked = false.obs;

  ClientTagModel({
    required this.id,
    required this.clientId,
    required this.tagId,
  });

  factory ClientTagModel.fromJson(Map<String, dynamic> json) => ClientTagModel(
        id: json['id'] ?? 0,
        clientId: json['client_id'],
        tagId: json['tag_id'],
      );
}
