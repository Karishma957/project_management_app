import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:mongo_dart/mongo_dart.dart' as mg;
import 'package:project_management_app/Screens/login.dart';
import 'package:project_management_app/Screens/projects_screen.dart';
import 'package:project_management_app/Service/db_connection.dart';
import 'package:project_management_app/Store/task_collection.dart';
import 'package:project_management_app/Store/user_collection.dart';
import 'package:project_management_app/model/user.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  DBConnection database = DBConnection();
  bool isLoading = true;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    if (await database.getConnection()) {
      UserCollection.getCollection();
      await UserCollection.getUsers();
      TaskCollection.getCollection();
      await TaskCollection.getTasks();
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Scaffold(
            body: SpinKitFadingCube(
            color: Color.fromRGBO(78, 204, 163, 1),
          ))
        : const LoginScreen();
  }
}
