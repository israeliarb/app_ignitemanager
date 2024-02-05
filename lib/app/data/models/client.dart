class ClientModel {
  int id;
  String name;
  String email;
  int createdBy;
  int lastUpdateBy;

  ClientModel({
    required this.id,
    required this.name,
    required this.email,
    required this.createdBy,
    required this.lastUpdateBy,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) => ClientModel(
        id: json['id'],
        name: json['name'],
        email: json['email'],
        createdBy: json['created_by'],
        lastUpdateBy: json['last_update_by'],
      );
}
