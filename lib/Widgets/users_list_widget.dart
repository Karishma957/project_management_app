import 'package:flutter/material.dart';

class UsersListWidget extends StatefulWidget {
  final Function onClick;
  final bool? isMember;
  final String userName;
  final int index;

  const UsersListWidget({
    Key? key,
    required this.onClick,
    this.isMember,
    required this.userName,
    required this.index,
  }) : super(key: key);

  @override
  _UsersListWidgetState createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  bool isSelected = false;
  List<bool> roleSelected = [false, true];

  @override
  void initState() {
    if (widget.isMember != null) isSelected = widget.isMember!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        setState(() {
          isSelected = !isSelected;
        });
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).backgroundColor,
          child: isSelected
              ? Icon(Icons.check_rounded, color: Theme.of(context).accentColor)
              : Text(
                  '${widget.index}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyText1
                      ?.copyWith(color: Theme.of(context).accentColor),
                ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.userName,
              style: Theme.of(context).textTheme.bodyText1,
            ),
            if (isSelected)
              ToggleButtons(
                selectedColor: Theme.of(context).accentColor,
                isSelected: roleSelected,
                children: const [
                  Text(
                    "Member",
                  ),
                  Text(
                    "Co-leader",
                  ),
                ],
                onPressed: (int index) {
                  setState(() {
                    roleSelected[index] = !roleSelected[index];
                  });
                  print(roleSelected);
                },
              )
          ],
        ),
      ),
    );
  }
}
