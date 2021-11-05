import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';

class BuildButton extends StatelessWidget {
  BuildButton(
      {Key? key, required this.onPressed, required this.text, this.width})
      : super(key: key);

  final VoidCallback onPressed;
  final String text;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width != null ? MediaQuery.of(context).size.width : width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          primary: CollectionsColors.yellow,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Text(
            text,
            style: FontCollection.bodyBlackTextStyle,
          ),
        ),
      ),
    );
  }
}
