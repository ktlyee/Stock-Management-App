import 'package:csc344_project/home_page.dart';
import 'package:csc344_project/model/soldItem.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/service/database.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/bottom_navigation_bar.dart';
import 'package:csc344_project/widgets/button_widget.dart';
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
  int totalIncome = 0;
  String date = DateFormat('dd MMM yyyy').format(DateTime.now()).toString();
  SoldItem soldItems = SoldItem();

  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    productNotifier.productList.forEach((product) {
      amountOfEachProduct.add(0);
      soldProducts.add({'name': product.name, 'amount': 0, 'totalPrice': 0});
      if (categories.contains(product.category)) {
      } else {
        categories.add(product.category);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                child: ListTile(
                  onTap: () {},
                  title: Text(
                    date,
                    style: FontCollection.bodyBlackTextStyle,
                  ),
                  trailing: Icon(
                    Icons.calendar_today,
                    color: Colors.black,
                  ),
                ),
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
                            child: listData(categories[index]),
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
                    soldItems.date = date;
                    soldItems.totalIncome = totalIncome;
                    soldItems.products = soldProducts;

                    addSoldProducts(
                      soldItems,
                      date.characters.getRange(3, 6).toString(),
                    );

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => NavigationBar(),
                      ),
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

  void handleIncreaseAmount(int index, String priceProduct) {
    int price = int.parse(priceProduct);

    setState(() {
      amountOfEachProduct[index] += 1;
      totalIncome += price;
    });

    soldProducts[index].update('amount', (value) => amountOfEachProduct[index]);
    soldProducts[index]
        .update('totalPrice', (value) => price * amountOfEachProduct[index]);
  }

  void handleDecreaseAmount(int index, String priceProduct) {
    int price = int.parse(priceProduct);

    if (amountOfEachProduct[index] > 0) {
      setState(() {
        amountOfEachProduct[index] -= 1;
        totalIncome -= price;
      });
      soldProducts[index]
          .update('amount', (value) => amountOfEachProduct[index]);
      soldProducts[index]
          .update('totalPrice', (value) => price * amountOfEachProduct[index]);
    } else {
      soldProducts[index].update('amount', (value) => 0);
      soldProducts[index].update('totalPrice', (value) => 0);
    }
  }

  Widget listData(String category) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);
    List products = [];

    productNotifier.productList.forEach((product) {
      if (product.category == category) {
        products.add(product.name);
      }
    });

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
                  products[index],
                  style: FontCollection.bodyBlackTextStyle,
                ),
              ),
              Container(
                  child: CustomStepper(
                value: amountOfEachProduct[index],
                iconSize: 25,
                decreaseAmount: () => handleDecreaseAmount(
                    index, productNotifier.productList[index].price),
                increaseAmount: () => handleIncreaseAmount(
                    index, productNotifier.productList[index].price),
              )),
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
