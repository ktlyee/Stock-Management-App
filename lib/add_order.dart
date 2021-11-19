import 'package:csc344_project/model/soldItem.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:csc344_project/service/database.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/bottom_navigation_bar.dart';
import 'package:csc344_project/widgets/button_widget.dart';
import 'package:csc344_project/widgets/datetime_picker_widget.dart';
import 'package:csc344_project/widgets/stepper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({Key? key}) : super(key: key);

  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
  List categories = [];
  List amountOfEachProduct = [];
  List<Map<String, dynamic>> soldProducts = [];
  int totalAmountSoldProducts = 0;
  int totalIncome = 0;
  String date = DateFormat('dd MMM yyyy').format(DateTime.now()).toString();
  SoldItem soldItems = SoldItem();

  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    productNotifier.productList.forEach((product) {
      soldProducts.add({
        'docId': product.documentId,
        'name': product.name,
        'amount': 0,
        'totalPrice': 0
      });
      if (categories.contains(product.category)) {
      } else {
        categories.add(product.category);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    SoldItemsNotifier soldItemsNotifier =
        Provider.of<SoldItemsNotifier>(context);

    return Scaffold(
      appBar: MainAppBar(
        appBarText: 'Add an order',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 2, color: CollectionsColors.purple),
                ),
                alignment: Alignment.centerLeft,
                child: DatePickerWidget(),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CollectionsColors.purple,
                      ),
                      child: ExpansionTile(
                        // collapsedIconColor: CollectionsColors.white,
                        // iconColor: CollectionsColors.white,
                        title: Text(
                          categories[index],
                          style: FontCollection.bodyBoldTextStyle,
                        ),
                        children: [
                          Container(
                            color: CollectionsColors.white,
                            child: listData(categories[index], index),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: BuildButton(
                  text: 'Submit',
                  width: MediaQuery.of(context).size.width,
                  onPressed: () {
                    soldProducts.removeWhere((p) => p['amount'] == 0);
                    soldProducts.forEach((product) {
                      addSoldProductInEachDocument(
                        product,
                        soldItemsNotifier.date != ''
                            ? soldItemsNotifier.date
                            : date,
                      );
                      productNotifier.productList.forEach((document) {
                        if (document.name == product['name']) {
                          num newAmount =
                              int.parse(document.amount) - product['amount'];
                          updateAmountProduct(
                            document.documentId,
                            newAmount.toString(),
                          );
                        }
                      });
                    });

                    for (int i = 0; i < amountOfEachProduct.length; i++) {
                      amountOfEachProduct[i].forEach((amountProduct) {
                        int amount = amountProduct;
                        totalAmountSoldProducts += amount;
                      });
                    }

                    soldItems.date = soldItemsNotifier.date != ''
                        ? soldItemsNotifier.date
                        : date;
                    soldItems.totalIncome = totalIncome;
                    soldItems.totalAmountSoldProducts = totalAmountSoldProducts;
                    soldItems.products = soldProducts;

                    addSoldProducts(
                      soldItems,
                      soldItemsNotifier.date != ''
                          ? soldItemsNotifier.date.characters
                              .getRange(3, 6)
                              .toString()
                          : date.characters.getRange(3, 6).toString(),
                    );

                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (context) => NavigationBar(),
                      ),
                      (route) => false,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void handleIncreaseAmount(String priceProduct, int amount, String pName) {
    int price = int.parse(priceProduct);

    setState(() {
      totalIncome += price;
    });

    soldProducts.forEach((product) {
      if (product['name'] == pName) {
        product.update('amount', (value) => amount);
        product.update('totalPrice', (value) => price * amount);
      }
    });
  }

  void handleDecreaseAmount(String priceProduct, int amount, String pName) {
    int price = int.parse(priceProduct);

    if (amount > 0) {
      setState(() {
        totalIncome -= price;
      });
      soldProducts.forEach((product) {
        if (product['name'] == pName) {
          product.update('amount', (value) => amount);
          product.update('totalPrice', (value) => price * amount);
        }
      });
    } else {
      soldProducts.forEach((product) {
        if (product['name'] == pName) {
          product.update('amount', (value) => 0);
          product.update('totalPrice', (value) => 0);
        }
      });
    }
  }

  Widget listData(String category, int i) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    List<Map<String, dynamic>> products = [];
    List amount = [];

    productNotifier.productList.forEach((product) {
      if (product.category == category) {
        products.add({
          'name': product.name,
          'price': product.price,
          'amount': int.parse(product.amount),
        });
        amount.add(0);
      }
    });

    if (amountOfEachProduct.length != categories.length) {
      amountOfEachProduct.add(amount);
    }

    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  products[index]['name'],
                  style: FontCollection.bodyBlackTextStyle,
                ),
              ),
              Container(
                child: CustomStepper(
                  value: amountOfEachProduct[i][index],
                  iconSize: 25,
                  increaseAmount: () {
                    if (amountOfEachProduct[i][index] <=
                        products[index]['amount']) {
                      setState(() {
                        amountOfEachProduct[i][index] += 1;
                      });
                    }
                    handleIncreaseAmount(
                      products[index]['price'],
                      amountOfEachProduct[i][index],
                      products[index]['name'],
                    );
                  },
                  decreaseAmount: () {
                    if (amountOfEachProduct[i][index] > 0) {
                      setState(() {
                        amountOfEachProduct[i][index] -= 1;
                      });
                    }
                    handleDecreaseAmount(
                      products[index]['price'],
                      amountOfEachProduct[i][index],
                      products[index]['name'],
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(
          thickness: 2,
        );
      },
    );
  }
}
