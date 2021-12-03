import 'package:flutter/material.dart';
import 'package:project_management_app/Screens/create_project_screen.dart';
import 'package:project_management_app/Screens/profile_page.dart';
import 'package:project_management_app/Screens/tasks_screen.dart';
import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Service/db_connection.dart';
import 'package:project_management_app/Store/project_collection.dart';
import 'package:project_management_app/Widgets/project_display_widget.dart';

class ProjectsScreen extends StatefulWidget {
  const ProjectsScreen({Key? key}) : super(key: key);

  @override
  State<ProjectsScreen> createState() => _ProjectsScreenState();
}

class _ProjectsScreenState extends State<ProjectsScreen> {
  DBConnection database = DBConnection();
  List projectsList = List.empty(growable: true);

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    ProjectCollection.getCollection();
    await ProjectCollection.getProjects();
    var res = ProjectCollection.projectsList;
    projectsList = res;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => const ProfilePage()));
            },
            child: Text(Constants.user.userName ?? "")),
        actions: [
          InkWell(
            onTap: () {
              Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const CreateProjectScreen()))
                  .then((value) {
                getData();
              });
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
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => TasksScreen(
                            pr: projectsList[index],
                          ))).then((value) => getData());
            },
            child: ProjectDisplayWidget(
              name: projectsList[index].projectName!,
              userId: projectsList[index].projectId,
            ),
          );
        },
      ),
    );
  }
}
