class UserModel {
  int? id;
  String name;
  String? type;
  String email;

  UserModel({
    this.id,
    required this.name,
    this.type,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        name: json['name'],
        type: json['type'],
        email: json['email'],
      );
}
