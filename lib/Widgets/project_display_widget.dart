import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart';

class ProjectDisplayWidget extends StatelessWidget {
  final String name;
  final ObjectId userId;

  const ProjectDisplayWidget(
      {Key? key, required this.name, required this.userId})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor,
            child: Text(
              name[0].toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyText1
                  ?.copyWith(color: Theme.of(context).accentColor),
            ),
          ),
          title: Text(
            name,
            style: Theme.of(context).textTheme.bodyText1,
          ),
          trailing: Icon(
            Icons.arrow_right,
            color: Theme.of(context).accentColor,
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
