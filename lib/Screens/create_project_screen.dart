import 'package:flutter/material.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({Key? key}) : super(key: key);

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new Project"),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: TextFormField(
              validator: (val) => val!.isEmpty ? 'Enter a name' : null,
              controller: nameController,
              autocorrect: true,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter Project name',
                hintStyle: Theme.of(context).textTheme.bodyText1,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 8),
            child: TextFormField(
              validator: (val) => val!.isEmpty ? 'Enter a description' : null,
              controller: descriptionController,
              autocorrect: true,
              maxLines: 5,
              style: Theme.of(context).textTheme.bodyText1,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Enter project description',
                hintStyle: Theme.of(context).textTheme.bodyText1,
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
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
            height: 16,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).accentColor),
            onPressed: () async {},
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
