import 'package:flutter/material.dart';
import 'package:project_management_app/Screens/projects_screen.dart';
import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Store/user_collection.dart';
import 'package:project_management_app/model/user.dart';
import 'package:mongo_dart/mongo_dart.dart' as mg;

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: TextFormField(
              validator: (val) => val!.isEmpty ? 'Enter a name' : null,
              controller: nameController,
              autocorrect: true,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.all(20),
                border: InputBorder.none,
                hintText: 'Enter your username',
                hintStyle: Theme.of(context).textTheme.bodyText1,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                ),
                prefixIcon: const SizedBox(
                  width: 70,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).accentColor),
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                ),
                filled: true,
                fillColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor),
            onPressed: () async {
              Constants.user = await UserCollection.loginUser(User(
                  userId: mg.ObjectId(),
                  userName: nameController.text,
                  tasks: List.empty()));
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (_) => const ProjectsScreen()));
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Submit",
                style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Roboto',
                  fontSize: 20.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
