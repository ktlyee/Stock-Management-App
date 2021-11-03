import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/button_widget.dart';
import 'package:csc344_project/widgets/textfield.dart';
import 'package:flutter/material.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key}) : super(key: key);

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {

  @override
  Widget build(BuildContext context) {
    double shortTextFieldWidth = MediaQuery.of(context).size.width / 3;
    return Scaffold(
      appBar: MainAppBar(
        appBarText: 'Add Product',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Center(
                child: Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CollectionsColors.lightPurple,
                  ),
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: CollectionsColors.black,
                      size: 50,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: buildTextField('Name', 'Please fill product name', false),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: buildShortTextField('Name', '0.00',shortTextFieldWidth, 'bath'),
                    ),
                    Expanded(
                      child: buildShortTextField('Weight / Item', '0.00',shortTextFieldWidth, 'gram'),
                    ),
                    Container(
                      child: buildShortTextField('Amount', '0.00',shortTextFieldWidth,null),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: buildTextField('Product Detail', 'Please fill product detail', true),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: BuildButton(
                  onPressed: () {},
                  text: 'Save',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextEditingController? controller;
  String value = '';

  Widget buildTextField(String title, String hintText, bool isBigBox) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: FontCollection.bodyBlackBoldTextStyle,
          ),
        ),
        isBigBox ?
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 10),
          child: BuildTextField(
            hintText: hintText,
            validator: (value) {},
            onSaved: (value) {},
            initialValue: '',
            maxLine: 5,
          ),
        ) :
        Container(
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 10),
          child: BuildPlainTextField(
            // textEditingController: controller!,
            hintText: hintText,
            validator: (value) {},
            onSaved: (value) {},
            initialValue: '',
          ),
        ),
      ],
    );
  }

  Widget buildShortTextField(String title, String hintText, double width, String? unit) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: FontCollection.bodyBlackBoldTextStyle,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Container(
                width: width - 60,
                child: BuildPlainTextField(
                  // textEditingController: controller!,
                  hintText: hintText,
                  validator: (value) {},
                  onSaved: (value) {},
                  initialValue: '',
                  textInputType: TextInputType.number,
                ),
              ),
              unit == null ? SizedBox.shrink() : Container(
                padding: EdgeInsets.only(left: 10),
                child: Text(unit),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
