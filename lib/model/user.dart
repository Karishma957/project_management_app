import 'package:mongo_dart/mongo_dart.dart';
import 'package:project_management_app/model/task.dart';

class User {
  User({
    this.userId,
    this.userName,
    this.tasks,
  });

  ObjectId? userId;
  String? userName;
  List<TaskId?>? tasks = [];

  factory User.fromJson(Map<String, dynamic> json) => User(
        userId: json["_id"] ?? "",
        userName: json["userName"] ?? "",
        tasks: json["tasks"] != null
            ? List<TaskId>.from(json["tasks"].map((x) => TaskId.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "_id": userId,
        "userName": userName,
        "tasks": List<dynamic>.from(tasks!.map((x) => x?.toJson())),
      };
}

class UserRole {
  UserRole({
    this.userId,
    this.roleId,
  });

  ObjectId? userId;
  ObjectId? roleId;

  factory UserRole.fromJson(Map<String, dynamic> json) => UserRole(
        userId: json["userId"],
        roleId: json["roleId"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "roleId": roleId,
      };
}
