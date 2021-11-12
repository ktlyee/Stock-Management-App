import 'dart:ui';

import 'package:csc344_project/model/soldItem.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:csc344_project/service/database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:provider/provider.dart';

class orderDetail extends StatefulWidget {
  const orderDetail({Key? key}) : super(key: key);

  @override
  _orderDetailState createState() => _orderDetailState();
}

class _orderDetailState extends State<orderDetail> {
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
                    child: ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            soldItemsNotifier.currentSoldItem.products.length,
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
                              title: Text("item ",
                                  style: FontCollection.bodyBoldTextStyle),
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(0,20, 10,0),
                                  alignment: Alignment.centerRight,
                                  color: CollectionsColors.white,
                                  child: Text("3",
                                  style: FontCollection.bodyBlackTextStyle,),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(10,0,0,0),
                                  alignment: Alignment.centerLeft,
                                  color: CollectionsColors.white,
                                  child: Text("cabbbage",
                                    style: FontCollection.bodyBlackTextStyle,),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(0,0, 10, 20),
                                  alignment: Alignment.centerRight,
                                  color: CollectionsColors.white,
                                  child: Text("75"+" baht",
                                    style: FontCollection.bodyBlackTextStyle,),
                                ),
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
                        padding: EdgeInsets.fromLTRB(10,0,0,0),
                        alignment: Alignment.centerLeft,
                        child: Text("Summary",
                        style: FontCollection.bodyBoldPurpleTextStyle,),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10,10,10,0),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Number of sales",
                              style: FontCollection.bodyBlackTextStyle,),
                            Text(soldItemsNotifier.currentSoldItem.totalAmountSoldProducts.toString(),
                              style: FontCollection.bodyBlackTextStyle,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(10,0,10,0),
                        alignment: Alignment.centerLeft,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Number of income",
                              style: FontCollection.bodyBlackTextStyle,),
                            Text(soldItemsNotifier.currentSoldItem.totalIncome.toString(),
                              style: FontCollection.bodyBlackTextStyle,
                              textAlign: TextAlign.end,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                )
              ],
            ),
          ),
        ));
  }
}
