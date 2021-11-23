import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mg;
import 'package:project_management_app/Service/db_connection.dart';
import 'package:project_management_app/Store/project_collection.dart';
import 'package:project_management_app/model/project.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  DBConnection database = DBConnection();

  // Project p = Project(
  //     projectId: mg.ObjectId(),
  //     tasks: List.empty(),
  //     description: "desc",
  //     projectName: "project 1",
  //     startDate: null,
  //     endDate: null,
  //     userRoles: List.empty());
  List projectsList = List.empty(growable: true);

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    ProjectCollection.getCollection();
    var res = await ProjectCollection.getProjects();
    if (res != null) projectsList = res;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("To-do"),
      ),
      body: ListView.builder(
        itemCount: projectsList.length,
        padding: const EdgeInsets.all(8),
        itemBuilder: (context, index) {
          return Text(projectsList[index].projectName!);
        },
      ),
    );
  }
}
