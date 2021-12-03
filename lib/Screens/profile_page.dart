import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Store/task_collection.dart';
import 'package:project_management_app/Widgets/task_display_widget.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isLoading = true;
  List tasksList = List.empty(growable: true);

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    tasksList.clear();
    TaskCollection.tasks.forEach((element) {
      Constants.user.tasks?.forEach((e) {
        if (e?.taskId == element.taskId) tasksList.add(element);
      });
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(Constants.user.userName ?? ""),
      ),
      body: SingleChildScrollView(
        child: isLoading
            ? SizedBox(
                height: MediaQuery.of(context).size.height - 150,
                child: const Center(
                  child: SpinKitFadingCube(
                    color: Color.fromRGBO(78, 204, 163, 1),
                  ),
                ),
              )
            : Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(
                      children: tasksList
                          .map((e) => TaskDisplayWidget(task: e))
                          .toList(),
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
