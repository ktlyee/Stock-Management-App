import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  MainAppBar({Key? key, required this.appBarText, this.action}) : preferredSize = Size.fromHeight(60), super(key: key);

  final Size preferredSize;
  final String appBarText;
  final List<Widget>? action;

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: CollectionsColors.deepPurple, //change your color here
      ),
      title: Text(
        widget.appBarText,
        style: FontCollection.topicBoldPurpleTextStyle,
      ),
      actions: widget.action,
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
