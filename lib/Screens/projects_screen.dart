import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mg;
import 'package:project_management_app/Screens/create_project_screen.dart';
import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Service/db_connection.dart';
import 'package:project_management_app/Store/project_collection.dart';
import 'package:project_management_app/model/project.dart';
import 'package:project_management_app/model/user.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  DBConnection database = DBConnection();

  Project p = Project(
      projectId: mg.ObjectId(),
      tasks: List.empty(),
      description: "desc",
      projectName: "project 5",
      startDate: null,
      endDate: null,
      userRoles: [
        UserRole(userId: Constants.user.userId, roleId: Constants.user.userId)
      ]);
  List projectsList = List.empty(growable: true);

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    ProjectCollection.getCollection();
    ProjectCollection.addToCollection(p);
    print(p.toJson());
    var res = await ProjectCollection.getProjects();
    if (res != null) {
      projectsList = res;
      // projectsList = res.where((element) {
      //   return element.userRoles
      //           .indexWhere((e) => e.userId == Constants.user.userName) !=
      //       -1;
      // }).toList();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.user.userName ?? ""),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => const CreateProjectScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 16.0),
              child: Icon(
                Icons.add,
              ),
            ),
          )
        ],
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
