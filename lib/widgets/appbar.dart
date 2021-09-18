import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  MainAppBar({Key? key, required this.appBarText}) : preferredSize = Size.fromHeight(60), super(key: key);

  final Size preferredSize;
  final String appBarText;

  @override
  _MainAppBarState createState() => _MainAppBarState();
}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.appBarText,
        style: FontCollection.topicBoldTextStyle,
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }
}
