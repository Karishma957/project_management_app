import 'package:flutter/material.dart';
import 'package:project_management_app/model/project.dart';

class TasksScreen extends StatelessWidget {
  final Project project;

  const TasksScreen({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(project.projectName!),
      ),
      body: Container(
        child: Text(""),
      ),
    );
  }
}
