class TaskId {
  TaskId({this.taskId});

  String? taskId;

  factory TaskId.fromJson(Map<String, dynamic> json) => TaskId(
        taskId: json["taskId"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "taskId": taskId,
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

  String? taskId;
  String? taskName;
  String? description;
  String? assignedBy;
  String? assignedTo;
  bool? status;
  String? startDate;
  String? endDate;
  int? priority;

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        taskId: json["taskId"] ?? "",
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
        "taskId": taskId,
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
