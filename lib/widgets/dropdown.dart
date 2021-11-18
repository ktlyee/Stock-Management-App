import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';

class BuildDropdown extends StatelessWidget {
  BuildDropdown({
    Key? key,
    required this.dropdownValues,
    required this.onChanged,
    this.values,
    this.hintText,
    this.width,
  }) : super(key: key);

  final List<String> dropdownValues;
  final Function(String?)? onChanged;
  final String? values;
  final String? hintText;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
            color: CollectionsColors.purple, style: BorderStyle.solid, width: 2.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          items: dropdownValues
              .map((value) => DropdownMenuItem(
                    child: Text(value, style: FontCollection.bodyBlackTextStyle,),
                    value: value,
                  ))
              .toList(),
          onChanged: onChanged,
          value: values,
          // hint: Text(
          //   hintText,
          //   style: FontCollection.smallBodyTextStyle,
          // ),
        ),
      ),
    );
  }
}
