import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';

class ShowDateTime extends StatelessWidget {
  ShowDateTime(
      {Key? key,
       required this.text,
       required this.onClicked})
      : super(key: key);

  final String text;
  final VoidCallback onClicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListTile(
        onTap: onClicked,
        title: Text(
          text,
          style: FontCollection.bodyBlackTextStyle,
        ),
        trailing: Icon(
          Icons.calendar_today,
          color: Colors.black,
        ),
      ),
    );
  }
}
