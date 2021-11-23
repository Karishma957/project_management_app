import 'package:mongo_dart/mongo_dart.dart';

class Role {
  Role({
    this.roleId,
    this.roleName,
    this.description,
  });

  ObjectId? roleId;
  String? roleName;
  String? description;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        roleId: json["_id"] ?? "",
        roleName: json["roleName"] ?? "",
        description: json["description"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": roleId,
        "roleName": roleName,
        "description": description,
      };
}
