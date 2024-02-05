class ClientTagModel {
  int id;
  int clientId;
  int tagId;

  ClientTagModel({
    required this.id,
    required this.clientId,
    required this.tagId,
  });

  factory ClientTagModel.fromJson(Map<String, dynamic> json) => ClientTagModel(
        id: json['id'],
        clientId: json['clientId'],
        tagId: json['tagId'],
      );
}
