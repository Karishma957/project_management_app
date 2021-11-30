import 'package:mongo_dart/mongo_dart.dart';

class TaskId {
  TaskId({this.taskId});

  ObjectId? taskId;

  factory TaskId.fromJson(Map<String, dynamic> json) => TaskId(
        taskId: json["_id"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "_id": taskId,
      };
}

class Task {
  Task({
    this.taskId,
    this.taskName,
    this.description,
    this.startDate,
    this.endDate,
    this.assignedBy,
    this.assignedTo,
    this.status,
    this.priority,
  });

  ObjectId? taskId;
  String? taskName;
  String? description;
  ObjectId? assignedBy;
  ObjectId? assignedTo;
  bool? status;
  DateTime? startDate;
  DateTime? endDate;
  int? priority;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskId: json["_id"] ?? "",
        taskName: json["taskName"] ?? "",
        description: json["description"] ?? "",
        assignedBy: json["assignedBy"] ?? "",
        assignedTo: json["assignedTo"] ?? "",
        status: json["status"] ?? false,
        startDate: json["startDate"] ?? "",
        priority: json["priority"] ?? 0,
        endDate: json["endDate"],
      );

  Map<String, dynamic> toJson() => {
        "_id": taskId,
        "taskName": taskName,
        "description": description,
        "startDate": startDate,
        "endDate": endDate,
        "assignedBy": assignedBy,
        "assignedTo": assignedTo,
        "status": status,
        "priority": priority,
      };
}
