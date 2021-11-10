import 'package:csc344_project/model/soldItem.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:flutter/material.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:provider/provider.dart';

class OrderHistory extends StatefulWidget {
  const OrderHistory({Key? key}) : super(key: key);

  @override
  _OrderHistoryState createState() => _OrderHistoryState();
}

class _OrderHistoryState extends State<OrderHistory> {
  @override
  Widget build(BuildContext context) {
    SoldItemsNotifier soldItemsNotifier = Provider.of(context, listen: false);

    return Scaffold(
      appBar: MainAppBar(
        appBarText: "Sales History",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: soldItemsNotifier.soldList.length,
              itemBuilder: (context, index) {
                final soldItem = soldItemsNotifier.soldList[index];
                return buildCard(soldItem);
              }),
        ),
      ),
    );
  }

  Widget buildCard(SoldItem soldItem) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: CollectionsColors.lightPurple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
                child: Padding(
              padding: const EdgeInsets.fromLTRB(30, 10, 10, 10),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      soldItem.date,
                      style: FontCollection.bodyPurpleTextStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${soldItem.totalAmountSoldProducts} item sold',
                      style: FontCollection.bodyBlackTextStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      '${soldItem.totalIncome} baht',
                      style: FontCollection.bodyBlackTextStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 0, 10, 10),
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "See detail",
                      style: FontCollection.underlineButtonTextStyle,
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
