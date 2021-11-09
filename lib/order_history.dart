import 'package:csc344_project/add_product.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/service/database.dart';
import 'package:flutter/material.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:provider/provider.dart';

class orderHistory extends StatefulWidget {
  const orderHistory({Key? key}) : super(key: key);

  @override
  _orderHistoryState createState() => _orderHistoryState();
}

class _orderHistoryState extends State<orderHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        appBarText: "Sales History",
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              buildCard("12 September 2021", "54", "2048 "),
              buildCard("20 September 2021", "45", "1453")
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(String date, String soldItemno, String price) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);

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
                      date,
                      style: FontCollection.bodyPurpleTextStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      soldItemno + " item sold",
                      style: FontCollection.bodyBlackTextStyle,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 10, 0),
                    alignment: Alignment.topLeft,
                    child: Text(
                      price + " baht",
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
