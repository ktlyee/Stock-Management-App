import 'package:csc344_project/style/color.dart';
import 'package:flutter/material.dart';

class BuildPlainTextField extends StatefulWidget {
  BuildPlainTextField({
    Key? key,
    // required this.textEditingController,
    this.hintText,
    this.initialValue,
    required this.validator,
    required this.onSaved,
    this.textInputType,
  }) : super(key: key);

  // final TextEditingController textEditingController;
  final String? hintText;
  final String? initialValue;
  final String? Function(String?) validator;
  final String? Function(String?) onSaved;
  final TextInputType? textInputType;

  @override
  _BuildPlainTextFieldState createState() => _BuildPlainTextFieldState();
}

class _BuildPlainTextFieldState extends State<BuildPlainTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: widget.textEditingController,
      initialValue: widget.initialValue,
      decoration: InputDecoration(
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: CollectionsColors.purple,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CollectionsColors.purple, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CollectionsColors.purple, width: 2.0),
        ),
      ),
      keyboardType: widget.textInputType,
      validator: widget.validator,
      onSaved: widget.onSaved,
    );
  }
}

class BuildTextField extends StatefulWidget {
  BuildTextField({
    Key? key,
    this.labelText,
    this.textEditingController,
    this.hintText,
    this.errorText,
    required this.validator,
    this.textInputType,
    this.obscureText = false,
    this.maxLength,
    this.maxLine,
    this.onSaved,
    this.initialValue,
    this.iconData,
  }) : super(key: key);

  final String? labelText;
  final TextEditingController? textEditingController;
  final String? hintText;
  final String? errorText;
  final String? Function(String?) validator;
  final TextInputType? textInputType;
  final bool? obscureText;
  final int? maxLength;
  final int? maxLine;
  final String? Function(String?)? onSaved;
  final String? initialValue;
  final IconData? iconData;

  @override
  _BuildTextFieldState createState() => _BuildTextFieldState();
}

class _BuildTextFieldState extends State<BuildTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: widget.labelText,
        errorText: widget.errorText,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: CollectionsColors.purple,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CollectionsColors.purple, width: 2.0),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.red, width: 2.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: CollectionsColors.purple, width: 2.0),
        ),
        suffixIcon: Icon(widget.iconData),
      ),
      initialValue: widget.initialValue,
      keyboardType: widget.textInputType,
      validator: widget.validator,
      obscureText: widget.obscureText!,
      onSaved: widget.onSaved!,
      maxLength: widget.maxLength,
      maxLines: widget.maxLine,
    );
  }
}
