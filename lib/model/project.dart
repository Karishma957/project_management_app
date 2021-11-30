import 'dart:core';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:project_management_app/model/task.dart';
import 'package:project_management_app/model/user.dart';

class Project {
  Project({
    this.projectId,
    this.projectName,
    this.description,
    this.startDate,
    this.endDate,
    this.userRoles,
    this.tasks,
  });

  ObjectId? projectId;
  String? projectName;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  List<UserRole?>? userRoles;
  List<TaskId?>? tasks;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectId: json["_id"] ?? "",
        projectName: json["projectName"] ?? "",
        description: json["description"] ?? "",
        startDate: json["startDate"] ?? "",
        endDate: json["endDate"],
        userRoles: json["userRoles"] != null
            ? List<UserRole>.from(
                json["userRoles"].map((x) => UserRole.fromJson(x)))
            : List.empty(),
        tasks: json["tasks"] != null
            ? List<TaskId>.from(json["tasks"].map((x) => TaskId.fromJson(x)))
            : List.empty(),
      );

  Map<String, dynamic> toJson() => {
        "_id": projectId,
        "projectName": projectName,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
        "userRoles": List<dynamic>.from(userRoles!.map((x) => x?.toJson())),
        "tasks": List<dynamic>.from(tasks!.map((x) => x?.toJson())),
      };
}
