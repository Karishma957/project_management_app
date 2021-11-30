import 'package:flutter/material.dart';
import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Store/user_collection.dart';
import 'package:project_management_app/Widgets/users_list_widget.dart';
import 'package:project_management_app/model/project.dart';
import 'package:project_management_app/model/role.dart';
import 'package:project_management_app/model/user.dart';

class TasksScreen extends StatefulWidget {
  final Project project;

  const TasksScreen({Key? key, required this.project}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  bool showInfo = false;
  String myRole = "None";

  @override
  void initState() {
    int myIndex = widget.project.userRoles!
        .indexWhere((element) => element!.userId == Constants.user.userId);
    if (myIndex != -1) {
      bool isAdmin = false;
      bool isMem = Role.isMember(widget.project.userRoles![myIndex]!.roleId!);
      if (isMem) {
        myRole = "Member";
      } else {
        isAdmin = Role.isAdmin(widget.project.userRoles![myIndex]!.roleId!);
        isAdmin ? myRole = "Admin" : myRole = "Co-leader";
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.project.projectName!),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  setState(() {
                    showInfo = !showInfo;
                  });
                },
                child: Icon(
                    showInfo ? Icons.arrow_drop_up : Icons.arrow_drop_down)),
          )
        ],
      ),
      floatingActionButton: myRole == "Admin" || myRole == "Co-leader"
          ? Row(
              children: [
                const Spacer(),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(30)),
                    color: Theme.of(context).accentColor,
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.add, color: Colors.white),
                      Text(
                        " Assign Task ",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
              ],
            )
          : const SizedBox(),
      body: Column(
        children: [
          if (showInfo)
            Container(
              color: Colors.black12,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Project description:",
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    Container(
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 16),
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(8)),
                        color: Theme.of(context).primaryColor,
                      ),
                      child: Text(
                        widget.project.description!,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
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
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(8)),
                                  color: Theme.of(context).primaryColor,
                                ),
                                child: Text(
                                  "${widget.project.startDate?.day}/${widget.project.startDate?.month}/${widget.project.startDate?.year}",
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
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(8)),
                                    color: Theme.of(context).primaryColor,
                                  ),
                                  child: Text(
                                    "${widget.project.endDate?.day}/${widget.project.endDate?.month}/${widget.project.endDate?.year}",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
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
                              child: Column(
                                children: widget.project.userRoles!.map((e) {
                                  final u = UserCollection.users[UserCollection
                                      .users
                                      .indexWhere((element) =>
                                          element.userId == e?.userId)];
                                  return UsersListWidget(
                                      onClick: () {},
                                      roleChanged: () {},
                                      userName: u.userName,
                                      isMember: Role.isMember(e!.roleId!),
                                      index:
                                          widget.project.userRoles!.indexOf(e),
                                      edit: false);
                                }).toList(),
                              )),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
