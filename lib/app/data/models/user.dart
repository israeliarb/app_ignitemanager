class UserModel {
  int id;
  String name;
  String type;
  String email;

  UserModel({
    required this.id,
    required this.name,
    required this.type,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['user_id'],
        name: json['name'],
        type: json['type'],
        email: json['email'],
      );
}
