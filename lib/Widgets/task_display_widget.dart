import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:project_management_app/Service/constants.dart';
import 'package:project_management_app/Store/task_collection.dart';
import 'package:project_management_app/Store/user_collection.dart';
import 'package:project_management_app/model/task.dart';

class TaskDisplayWidget extends StatefulWidget {
  final Task task;

  const TaskDisplayWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  State<TaskDisplayWidget> createState() => _TaskDisplayWidgetState();
}

class _TaskDisplayWidgetState extends State<TaskDisplayWidget> {
  bool isDone = false;
  String? assignedTo, assignedBy;

  @override
  void initState() {
    isDone = widget.task.status!;
    setState(() {});
    UserCollection.users.forEach((element) {
      if (element.userId == widget.task.assignedTo) {
        assignedTo = element!.userName!;
      }
      if (element.userId == widget.task.assignedBy) {
        assignedBy = element!.userName!;
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: const BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Theme.of(context).primaryColor,
              child: Text(
                widget.task.taskName![0].toUpperCase(),
                style: Theme.of(context)
                    .textTheme
                    .bodyText1
                    ?.copyWith(color: Theme.of(context).accentColor),
              ),
            ),
            title: Text(
              widget.task.taskName!,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            trailing: InkWell(
              onTap: () {
                if (widget.task.assignedTo == Constants.user.userId) {
                  isDone = !isDone;
                  setState(() {});
                  TaskCollection.updateStatus(widget.task.taskId!, isDone);
                  int i = TaskCollection.tasks.indexOf(widget.task);
                  TaskCollection.tasks[i].status = isDone;
                }
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                decoration: BoxDecoration(
                  border: Border.all(color: Theme.of(context).accentColor),
                  borderRadius: const BorderRadius.all(Radius.circular(16)),
                  color: isDone == true
                      ? Theme.of(context).accentColor
                      : Colors.black12,
                ),
                child: Text(
                  isDone == true ? "In progress" : "Done",
                  style: Theme.of(context).textTheme.subtitle1?.copyWith(
                      color: isDone == true
                          ? Theme.of(context).canvasColor
                          : Theme.of(context).accentColor),
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Task description:  ${widget.task.description!}",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Colors.white70),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Assigned to:  ",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: Colors.white60),
                          ),
                          Text(
                            assignedTo!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "Assigned by:  ",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: Colors.white60),
                          ),
                          Text(
                            assignedBy!,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "From:  ",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: Colors.white60),
                          ),
                          Container(
                            margin: const EdgeInsets.only(
                              top: 4,
                            ),
                            padding: const EdgeInsets.symmetric(
                                vertical: 4.0, horizontal: 8),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: Theme.of(context).accentColor),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(8)),
                              color: Theme.of(context).primaryColor,
                            ),
                            child: Text(
                              "${widget.task.startDate?.day}/${widget.task.startDate?.month}/${widget.task.startDate?.year}",
                              style: Theme.of(context).textTheme.subtitle1,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            "To:  ",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle2
                                ?.copyWith(color: Colors.white60),
                          ),
                          Container(
                              margin: const EdgeInsets.only(top: 4),
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 8),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: Theme.of(context).accentColor),
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(8)),
                                color: Theme.of(context).primaryColor,
                              ),
                              child: Text(
                                "${widget.task.endDate?.day}/${widget.task.endDate?.month}/${widget.task.endDate?.year}",
                                style: Theme.of(context).textTheme.subtitle1,
                              ))
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
