import 'dart:ui';

import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:provider/provider.dart';

class OrderDetail extends StatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  _OrderDetailState createState() => _OrderDetailState();
}

class _OrderDetailState extends State<OrderDetail> {
  List categories = [];

  @override
  void initState() {
    SoldItemsNotifier soldItemsNotifier =
        Provider.of<SoldItemsNotifier>(context, listen: false);
    soldItemsNotifier.currentSoldItem.products.forEach((p) {
      if (categories.contains(p['category'])) {
      } else {
        categories.add(p['category']);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SoldItemsNotifier soldItemsNotifier =
        Provider.of<SoldItemsNotifier>(context);
    return Scaffold(
        appBar: MainAppBar(
          appBarText: "Order detail",
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Container(
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  // padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Text(
                    soldItemsNotifier.currentSoldItem.date,
                    style: FontCollection.bodyBlackBoldTextStyle,
                  ),
                ),
                Container(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: CollectionsColors.purple,
                    ),
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          List products = [];

                          soldItemsNotifier.currentSoldItem.products.forEach(
                            (p) {
                              if (p['category'] == categories[index]) {
                                products.add(p);
                              }
                            },
                          );

                          return Container(
                            child: ExpansionTile(
                              // collapsedIconColor: CollectionsColors.white,
                              // iconColor: CollectionsColors.white,
                              title: Text(
                                categories[index],
                                style: FontCollection.bodyBoldTextStyle,
                              ),
                              children: [
                                ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount: products.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 20, 10, 0),
                                              alignment: Alignment.centerRight,
                                              color: CollectionsColors.white,
                                              child: Text(
                                                products[index]["amount"]
                                                        .toString() +
                                                    " unit",
                                                style: FontCollection
                                                    .bodyBlackTextStyle,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 0, 0, 0),
                                              alignment: Alignment.centerLeft,
                                              color: CollectionsColors.white,
                                              child: Text(
                                                products[index]["name"],
                                                style: FontCollection
                                                    .bodyBlackTextStyle,
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 0, 10, 20),
                                              alignment: Alignment.centerRight,
                                              color: CollectionsColors.white,
                                              child: Text(
                                                products[index]["totalPrice"]
                                                        .toString() +
                                                    " baht",
                                                style: FontCollection
                                                    .bodyBlackTextStyle,
                                              ),
                                            ),
                                            Divider(
                                              color: CollectionsColors.purple,
                                              height: 1,
                                            )
                                          ],
                                        ),
                                      );
                                    })
                              ],
                            ),
                          );
                        }),
                  ),
                ),
                Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Summary",
                            style: FontCollection.bodyBoldPurpleTextStyle,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Number of sales",
                                style: FontCollection.bodyBlackTextStyle,
                              ),
                              Text(
                                soldItemsNotifier
                                        .currentSoldItem.totalAmountSoldProducts
                                        .toString() +
                                    " items",
                                style: FontCollection.bodyBlackTextStyle,
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                          alignment: Alignment.centerLeft,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Number of income",
                                style: FontCollection.bodyBlackTextStyle,
                              ),
                              Text(
                                soldItemsNotifier.currentSoldItem.totalIncome
                                        .toString() +
                                    " baht",
                                style: FontCollection.bodyPurpleTextStyle,
                                textAlign: TextAlign.end,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ))
              ],
            ),
          ),
        ));
  }
}
