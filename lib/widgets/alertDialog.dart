import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/textfield.dart';
import 'package:flutter/material.dart';

import 'button_widget.dart';

class BuildAlertDialog extends StatefulWidget {
  BuildAlertDialog({Key? key, required this.productNotifier}) : super(key: key);

  final ProductNotifier productNotifier;

  @override
  _BuildAlertDialogState createState() => _BuildAlertDialogState();
}

class _BuildAlertDialogState extends State<BuildAlertDialog> {
  TextEditingController newCategory = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30),
      ),
      title: Text(
        'Category',
        style: FontCollection.bodyBoldPurpleTextStyle,
      ),
      content: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 2,
          child: Column(
            children: [
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                itemCount: widget.productNotifier.categoriesList.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  String category =
                      widget.productNotifier.categoriesList[index];
                  return categoryList(category, widget.productNotifier, index);
                },
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                alignment: Alignment.topLeft,
                child: Text(
                  'Add category',
                  style: FontCollection.bodyBlackTextStyle,
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                alignment: Alignment.topLeft,
                child: addCategory(widget.productNotifier),
              ),
              Container(
                alignment: Alignment.center,
                child: buildButton('Save', () {
                  Navigator.pop(context);
                }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int? selectedIndex;

  Widget categoryList(
    String categoryName,
    ProductNotifier productNotifier,
    int index,
  ) {
    TextEditingController controller = new TextEditingController();
    controller.text = categoryName;

    return Column(
      children: [
        Container(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 10,
                child: (index == selectedIndex)
                    ? Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: BuildPlainTextField(
                          textEditingController: controller,
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          categoryName,
                          style: FontCollection.bodyBlackTextStyle,
                        ),
                      ),
              ),
              Expanded(
                flex: 2,
                child: Container(
                  alignment: Alignment.topCenter,
                  child: (index == selectedIndex)
                      ? GestureDetector(
                          // onTap: () {
                          //   productNotifier.categoriesList[index] =
                          //       controller.text.trim();
                          //   print(productNotifier.categoriesList);

                          //   productNotifier.productList.forEach((product) {
                          //     if (product.category == categoryName) {
                          //       updateProductModel(
                          //         product.documentId,
                          //         {'category': controller.text.trim()},
                          //       );
                          //       print(product.name);
                          //     }
                          //   });
                          //   productNotifier.reloadProductList(productNotifier);
                          //   Navigator.pop(context);
                          // },
                          child: Icon(
                            Icons.check,
                            color: Colors.black,
                          ),
                        )
                      : GestureDetector(
                          // onTap: () {
                          //   selectedIndex = index;
                          //   setState(() {
                          //     print(index);
                          //   });
                          // },
                          child: Icon(
                            Icons.edit,
                            color: Colors.black,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
        Divider(
          thickness: 2,
        ),
      ],
    );
  }

  Widget addCategory(ProductNotifier productNotifier) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 10,
            child: Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: BuildPlainTextField(
                textEditingController: newCategory,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              alignment: Alignment.topCenter,
              child: EditButton(
                onClicked: () {
                  productNotifier.categoriesList.add(newCategory.text.trim());
                  // _selectedCategory = productNotifier.categoriesList.last;
                  Navigator.pop(context);
                },
                editText: 'Add',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildButton(String text, VoidCallback handleClick) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: CollectionsColors.yellow,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      onPressed: handleClick,
      child: Text(
        text,
        style: FontCollection.smallBodyBlackTextStyle,
      ),
    );
  }
}
