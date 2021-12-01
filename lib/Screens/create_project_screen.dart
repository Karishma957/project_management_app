import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as mg;
import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Store/project_collection.dart';
import 'package:project_management_app/Store/user_collection.dart';
import 'package:project_management_app/Widgets/users_list_widget.dart';
import 'package:project_management_app/model/project.dart';
import 'package:project_management_app/model/role.dart';
import 'package:project_management_app/model/user.dart';

class CreateProjectScreen extends StatefulWidget {
  const CreateProjectScreen({Key? key}) : super(key: key);

  @override
  State<CreateProjectScreen> createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  DateTime endDate = DateTime.now(), startDate = DateTime.now();
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  List<UserRole> selectedMembers = List.empty(growable: true);
  List _users = [];
  bool selectMembers = false;

  @override
  void initState() {
    getData();
    _users = UserCollection.users;
    Role role = Role();
    role.admin();
    selectedMembers
        .add(UserRole(userId: Constants.user.userId, roleId: role.roleId));
    setState(() {});
    super.initState();
  }

  getData() async {
    await UserCollection.getUsers();
  }

  onMemberSelected(int index, bool isSelected, bool isMember) {
    if (isSelected) {
      Role role = Role();
      isMember ? role.member() : role.coLeader();
      selectedMembers
          .add(UserRole(userId: _users[index].userId, roleId: role.roleId));
    } else {
      int i = selectedMembers
          .indexWhere((element) => _users[index].userId == element.userId);
      selectedMembers.removeAt(i);
    }
  }

  onRoleChanged(int index, bool isMember) {
    Role role = Role();
    isMember ? role.member() : role.coLeader();
    int i = selectedMembers
        .indexWhere((element) => _users[index].userId == element.userId);
    selectedMembers[i].roleId = role.roleId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create new Project"),
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
                    hintText: 'Enter project description',
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
                      "Project Duration:",
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
                    Text(
                      "Members:",
                      style: Theme.of(context).textTheme.bodyText1,
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
                              children: _users
                                  .map((e) => e.userId != Constants.user.userId
                                      ? UsersListWidget(
                                          onClick: onMemberSelected,
                                          roleChanged: onRoleChanged,
                                          userName: e.userName,
                                          index: _users.indexOf(e),
                                          edit: true,
                                        )
                                      : const SizedBox())
                                  .toList(),
                            )
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
                  await ProjectCollection.addToCollection(
                    Project(
                        tasks: [],
                        userRoles: selectedMembers,
                        startDate: startDate,
                        endDate: endDate,
                        description: descriptionController.text,
                        projectName: nameController.text,
                        projectId: mg.ObjectId()),
                  );

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
