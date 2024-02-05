class UserProfileRequestModel {
  String name;
  String type;
  String email;
  String? password;

  UserProfileRequestModel({
    required this.name,
    required this.type,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'type': type,
        'email': email,
        if (password != null && password!.isNotEmpty) 'password': password,
      };
}
