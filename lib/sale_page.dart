import 'package:csc344_project/model/sales.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/order_history.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/button_widget.dart';
import 'package:csc344_project/widgets/doughnut_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);

    return Scaffold(
      appBar: MainAppBar(
        appBarText: 'Sales',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              Container(
                child: DoughnutChart(),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: productNotifier.categoriesList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CollectionsColors.purple,
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: CollectionsColors.white,
                        iconColor: CollectionsColors.white,
                        title: Text(
                          productNotifier.categoriesList[index],
                          style: FontCollection.bodyBoldTextStyle,
                        ),
                        children: [
                          Container(
                            color: CollectionsColors.white,
                            child: listData(
                              productNotifier.categoriesList[index],
                              productNotifier,
                            ),
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
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => OrderHistory()));
                  },
                  text: 'See sales history',
                  width: MediaQuery.of(context).size.width,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listData(String category, ProductNotifier productNotifier) {
    List<Sales> products = [];

    productNotifier.amountOfProductSold.forEach((product) {
      if (product.category == category) {
        products.add(product);
      }
    });

    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  products[index].productName,
                  style: FontCollection.bodyBlackTextStyle,
                ),
              ),
              Container(
                child: Text(
                  products[index].totalAmount.toString(),
                  style: FontCollection.bodyBlackTextStyle,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
