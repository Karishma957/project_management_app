import 'package:flutter/material.dart';
import 'package:project_management_app/model/task.dart';

class TaskDisplayWidget extends StatelessWidget {
  final Task task;

  const TaskDisplayWidget({
    Key? key,
    required this.task,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              task.taskName![0].toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Theme.of(context).accentColor),
            ),
          ),
          title: Text(
            task.taskName!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          subtitle: Text(
            task.description!,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: CircleAvatar(
            radius: 5,
            backgroundColor:
                task.status! ? Theme.of(context).accentColor : Colors.white60,
          ),
        ),
        Divider(
          thickness: 0.5,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }
}
