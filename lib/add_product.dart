import 'dart:io';

import 'package:csc344_project/model/product.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/button_widget.dart';
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

  @override
  void initState() {
    _currentProduct = Product();
    // _imageUrl = _currentProduct!.image;
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

    uploadProductAndImage(
        _currentProduct!, widget.isUpdating, _onUploadedProduct);
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
                  ),
                  child: SizedBox(
                    child: showImage(),
                  ),
                ),
                Center(
                  child: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: FloatingActionButton(
                      onPressed: () => getLocalImage(),
                      backgroundColor: CollectionsColors.lightPurple,
                      child: Center(
                        child: Icon(
                          Icons.add,
                          color: CollectionsColors.black,
                          size: 50,
                        ),
                      ),
                    ),
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
                          'Weight / Item',
                          _currentProduct!.cost,
                          shortTextFieldWidth,
                          'gram',
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

  showImage() {
    if (_imageUrl == '' && _imageFile == null) {
      return Image.network(
        'https://www.testingxperts.com/wp-content/uploads/2019/02/placeholder-img.jpg',
        fit: BoxFit.cover,
      );
    } else if (_imageFile != null) {
      return Image.file(_imageFile!, fit: BoxFit.cover);
    } else if (_imageUrl != '') {
      return Image.network(_imageUrl, fit: BoxFit.cover);
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
}
