import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mg;
import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Store/project_collection.dart';
import 'package:project_management_app/Store/task_collection.dart';
import 'package:project_management_app/Store/user_collection.dart';
import 'package:project_management_app/model/task.dart';
import 'package:project_management_app/model/user.dart';

class CreateTaskScreen extends StatefulWidget {
  final mg.ObjectId projectId;
  final List members;

  const CreateTaskScreen(
      {Key? key, required this.members, required this.projectId})
      : super(key: key);

  @override
  State<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends State<CreateTaskScreen> {
  DateTime endDate = DateTime.now(), startDate = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<UserRole> selectedMembers = List.empty(growable: true);
  List _users = List.empty(growable: true);
  bool selectMembers = false;
  UserRole? selectedMember;
  String? selectedMemberName;

  @override
  void initState() {
    widget.members.map((e) => _users.add(e)).toList();
    setState(() {});
    super.initState();
  }

  Widget membersListTile(String? str) {
    return ListTile(
      leading: CircleAvatar(
        backgroundColor: Theme.of(context).backgroundColor,
        child: Text(
          str![0],
          style: Theme.of(context)
              .textTheme
              .bodyText1
              ?.copyWith(color: Theme.of(context).accentColor),
        ),
      ),
      title: Text(
        str,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new Task"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 18.0,
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (val) => val!.isEmpty ? 'Enter task name' : null,
                  controller: nameController,
                  autocorrect: true,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Task name',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: TextFormField(
                  validator: (val) =>
                      val!.isEmpty ? 'Enter a description' : null,
                  controller: descriptionController,
                  autocorrect: true,
                  maxLines: 5,
                  style: Theme.of(context).textTheme.bodyText1,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Enter Task description',
                    hintStyle: Theme.of(context).textTheme.bodyText1,
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).accentColor),
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                    ),
                    filled: true,
                    fillColor: Theme.of(context).primaryColor,
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: Text(
                      "Task Duration:",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: InkWell(
                  onTap: () async {
                    final picked = await showDateRangePicker(
                      context: context,
                      lastDate: DateTime(2121),
                      firstDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() {
                        startDate = picked.start.toUtc();
                        endDate = picked.end.toUtc();
                      });
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "From:",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 8.0, horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).accentColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              "${startDate.day}/${startDate.month}/${startDate.year}",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "To:",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).accentColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                "${endDate.day}/${endDate.month}/${endDate.year}",
                                style: Theme.of(context).textTheme.bodyText1,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Assign to:",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                        selectedMemberName == null
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(right: 50.0),
                                child: Text(
                                  selectedMemberName!,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: selectMembers
                          ? Column(
                              children: _users.map((e) {
                              User u = UserCollection.users
                                  .firstWhere((ele) => ele.userId == e.userId);
                              return InkWell(
                                  onTap: () {
                                    if (selectedMember != null) {
                                      _users.add(selectedMember);
                                    }
                                    setState(() {
                                      selectedMember = e;
                                      selectedMemberName = u.userName;
                                      _users.remove(e);
                                    });
                                  },
                                  child: membersListTile(u.userName));
                            }).toList())
                          : InkWell(
                              onTap: () {
                                setState(() {
                                  selectMembers = true;
                                });
                              },
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Select members ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        ?.copyWith(
                                            color:
                                                Theme.of(context).accentColor),
                                  ),
                                  Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context).accentColor,
                                  ),
                                ],
                              ),
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).accentColor),
                onPressed: () async {
                  mg.ObjectId id = mg.ObjectId();
                  await TaskCollection.addToCollection(Task(
                      taskName: nameController.text,
                      description: descriptionController.text,
                      startDate: startDate,
                      endDate: endDate,
                      status: true,
                      priority: 1,
                      assignedBy: Constants.user.userId,
                      assignedTo: selectedMember!.userId!,
                      taskId: id));
                  await UserCollection.update(selectedMember!.userId!, id);
                  await ProjectCollection.update(widget.projectId, id);
                  Navigator.pop(context);
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
        ),
      ),
    );
  }
}
