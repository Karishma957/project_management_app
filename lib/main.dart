import 'package:flutter/material.dart';
import 'package:project_management_app/Service/db_connection.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DBConnection db=DBConnection();
  @override
  void initState() {
    db.getConnection();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Project Management App"),
      ),
      body: const Text("List of projects"),
    );
  }
}

/*
mongo "mongodb+srv://cluster0.auku1.mongodb.net/miniProject" --username Karishma
MongoDB shell version v3.6.8
Enter password:
connecting to: mongodb+srv://cluster0.auku1.mongodb.net/miniProject
* */
