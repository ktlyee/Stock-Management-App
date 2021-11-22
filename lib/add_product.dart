import 'dart:io';

import 'package:csc344_project/model/product.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/alertDialog.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/button_widget.dart';
import 'package:csc344_project/widgets/dropdown.dart';
import 'package:csc344_project/widgets/textfield.dart';
import 'package:csc344_project/service/database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({Key? key, required this.isUpdating}) : super(key: key);

  final bool isUpdating;

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Product? _currentProduct;
  File? _imageFile;
  String _imageUrl = '';
  late String _selectedCategory;

  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    _selectedCategory = productNotifier.categoriesList.first;
    if (widget.isUpdating) {
      _currentProduct = productNotifier.currentProduct;
    } else {
      _currentProduct = Product();
    }
    _imageUrl = _currentProduct!.image;
    super.initState();
  }

  _onUploadedProduct(Product product) {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    productNotifier.addProduct(product);
    Navigator.pop(context);
  }

  _handleSavedProduct() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);

    if (!_formKey.currentState!.validate()) {
      return;
    }
    _formKey.currentState?.save();

    _currentProduct!.productId = '00${productNotifier.productList.length + 1}';
    _currentProduct!.category = _selectedCategory;

    uploadProductAndImage(
        _currentProduct!, widget.isUpdating, _onUploadedProduct, _imageFile);
  }

  getLocalImage() async {
    PickedFile? imageFile =
        await ImagePicker().getImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        _imageFile = File(imageFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    double shortTextFieldWidth = MediaQuery.of(context).size.width / 3;

    return Scaffold(
      appBar: MainAppBar(
        appBarText: 'Add Product',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Form(
            key: _formKey,
            autovalidateMode: AutovalidateMode.always,
            child: Column(
              children: [
                Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: CollectionsColors.lightPurple,
                  ),
                  child: (_imageUrl == '' && _imageFile == null)
                      ? GestureDetector(
                          onTap: () => getLocalImage(),
                          child: Icon(
                            Icons.add,
                            size: 50,
                            color: CollectionsColors.black,
                          ),
                        )
                      : GestureDetector(
                          onTap: () => getLocalImage(),
                          child: Stack(
                            fit: StackFit.expand,
                            children: [
                              CircleAvatar(
                                backgroundImage: showImage(),
                              ),
                              Positioned(
                                bottom: 0,
                                right: 0,
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Colors.white, width: 3),
                                    color: CollectionsColors.yellow,
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: CollectionsColors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                Container(
                  child: buildDropDown(
                    'Category',
                    productNotifier,
                  ),
                ),
                Container(
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: buildButton(
                    'Edit category',
                    () {
                      displayShowDialog(context, productNotifier);
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: buildTextField(
                    'Name',
                    _currentProduct!.name,
                    false,
                    (value) {
                      _currentProduct!.name = value.toString();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: buildShortTextField(
                          'Price',
                          _currentProduct!.price,
                          shortTextFieldWidth,
                          'bath',
                          (value) {
                            _currentProduct!.price = value.toString();
                          },
                        ),
                      ),
                      Expanded(
                        child: buildShortTextField(
                          'Cost',
                          _currentProduct!.cost,
                          shortTextFieldWidth,
                          'baht',
                          (value) {
                            _currentProduct!.cost = value.toString();
                          },
                        ),
                      ),
                      Container(
                        child: buildShortTextField(
                          'Amount',
                          _currentProduct!.amount,
                          shortTextFieldWidth,
                          null,
                          (value) {
                            _currentProduct!.amount = value.toString();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: buildTextField(
                    'Product Detail',
                    _currentProduct!.detail,
                    true,
                    (value) {
                      _currentProduct!.detail = value.toString();
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30),
                  child: BuildButton(
                    onPressed: () {
                      FocusScope.of(context).requestFocus(new FocusNode());
                      _handleSavedProduct();
                    },
                    text: 'Save',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> displayShowDialog(
      BuildContext context, ProductNotifier productNotifier) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BuildAlertDialog(
          productNotifier: productNotifier,
        );
      },
    );
  }

  showImage() {
    if (_imageUrl == '' && _imageFile == null) {
      return AssetImage(
        'assets/images/placeholder-img.jpg',
        // fit: BoxFit.cover,
      );
    } else if (_imageFile != null) {
      return FileImage(
        _imageFile!,
        // fit: BoxFit.cover,
      );
    } else if (_imageUrl != '') {
      return NetworkImage(
        _imageUrl,
        // fit: BoxFit.cover,
      );
    }
  }

  Widget buildTextField(String title, String initialValue, bool isBigBox,
      String? Function(String?) onSaved) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: FontCollection.bodyBlackBoldTextStyle,
          ),
        ),
        isBigBox
            ? Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 10),
                child: BuildTextField(
                  initialValue: initialValue,
                  validator: (value) {},
                  onSaved: onSaved,
                  maxLine: 5,
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(top: 10),
                child: BuildPlainTextField(
                  initialValue: initialValue,
                  validator: (value) {},
                  onSaved: onSaved,
                ),
              ),
      ],
    );
  }

  Widget buildShortTextField(String title, String initialValue, double width,
      String? unit, String? Function(String?) onSaved) {
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
                  validator: (value) {},
                  onSaved: onSaved,
                  initialValue: initialValue,
                  textInputType: TextInputType.number,
                ),
              ),
              unit == null
                  ? SizedBox.shrink()
                  : Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Text(unit),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildDropDown(String title, ProductNotifier productNotifier) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.fromLTRB(0, 20, 0, 10),
          alignment: Alignment.topLeft,
          child: Text(
            title,
            style: FontCollection.bodyBlackBoldTextStyle,
          ),
        ),
        BuildDropdown(
          width: MediaQuery.of(context).size.width,
          dropdownValues: productNotifier.categoriesList,
          onChanged: (value) {
            setState(() {
              _selectedCategory = value!;
            });
          },
          values: _selectedCategory,
          hintText: 'Please select category',
        ),
      ],
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

  // Widget catalogLists(
  //   String category,
  //   ProductNotifier productNotifier,
  //   int index,
  // ) {
  //   TextEditingController controller = new TextEditingController();
  //   controller.text = category;
  //
  //   return Container(
  //     child: Row(
  //       mainAxisSize: MainAxisSize.max,
  //       children: [
  //         Expanded(
  //           flex: 10,
  //           child: Padding(
  //             padding: EdgeInsets.only(bottom: 20),
  //             child: BuildPlainTextField(
  //               // validator: (value) {},
  //               // initialValue: category,
  //               textEditingController: controller,
  //               // onSaved: (value) {},
  //             ),
  //           ),
  //         ),
  //         Expanded(
  //           flex: 2,
  //           child: Container(
  //             alignment: Alignment.topCenter,
  //             child: InkWell(
  //               onTap: () {
  //                 productNotifier.categoriesList[index] =
  //                     controller.text.trim();
  //
  //                 productNotifier.productList.forEach((product) {
  //                   if (product.category == category) {
  //                     updateProductModel(
  //                       product.documentId,
  //                       {'category': controller.text.trim()},
  //                     );
  //                     print(product.name);
  //                   }
  //                 });
  //                 productNotifier.reloadProductList(productNotifier);
  //               },
  //               child: Icon(
  //                 Icons.edit,
  //                 color: Colors.black,
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

}
