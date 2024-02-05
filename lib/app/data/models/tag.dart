class TagModel {
  int? id;
  String name;
  bool active;

  TagModel({
    this.id,
    required this.name,
    required this.active,
  });

  factory TagModel.fromJson(Map<String, dynamic> json) => TagModel(
        id: json['id'],
        name: json['name'],
        active: json['active'],
      );
}
