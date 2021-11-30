import 'package:flutter/material.dart';

class UsersListWidget extends StatefulWidget {
  final Function onClick;
  final Function roleChanged;
  final bool? isMember;
  final String userName;
  final int index;
  final bool edit;

  const UsersListWidget({
    Key? key,
    required this.onClick,
    required this.roleChanged,
    this.isMember,
    required this.userName,
    required this.index,
    required this.edit,
  }) : super(key: key);

  @override
  _UsersListWidgetState createState() => _UsersListWidgetState();
}

class _UsersListWidgetState extends State<UsersListWidget> {
  bool isSelected = false;
  bool isMember = true;

  @override
  void initState() {
    if (widget.isMember != null) isSelected = widget.isMember!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.edit) {
          setState(() {
            isSelected = !isSelected;
            widget.onClick(widget.index, isSelected, isMember);
          });
        }
      },
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Theme.of(context).backgroundColor,
          child: isSelected
              ? Icon(Icons.check_rounded, color: Theme.of(context).accentColor)
              : Text(
                  widget.userName[0],
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
              InkWell(
                onTap: () {
                  if (widget.edit) {
                    setState(() {
                      isMember = !isMember;
                      widget.roleChanged(widget.index, isMember);
                    });
                  }
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 4),
                  padding:
                      const EdgeInsets.symmetric(vertical: 4.0, horizontal: 16),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).accentColor),
                    borderRadius: const BorderRadius.all(Radius.circular(16)),
                    color: Theme.of(context).backgroundColor,
                  ),
                  child: Text(
                    isMember ? "Member" : "Co-leader",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText2
                        ?.copyWith(color: Theme.of(context).accentColor),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
