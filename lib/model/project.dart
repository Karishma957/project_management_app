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

  String? projectId;
  String? projectName;
  String? description;
  String? startDate;
  String? endDate;
  List<UserRole?>? userRoles;
  List<TaskId?>? tasks;

  factory Project.fromJson(Map<String, dynamic> json) => Project(
        projectId: json["projectId"] ?? "",
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
        "projectId": projectId,
        "projectName": projectName,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
        "userRoles": List<dynamic>.from(userRoles!.map((x) => x?.toJson())),
        "tasks": List<dynamic>.from(tasks!.map((x) => x?.toJson())),
      };
}