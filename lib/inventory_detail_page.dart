import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/data_grid.dart';
import 'package:flutter/material.dart';

class InventoryDetailPage extends StatefulWidget {
  InventoryDetailPage({Key? key}) : super(key: key);

  @override
  _InventoryDetailPageState createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
  String info =
      'Amet minim mollit non deserunt ullamco est sit aliqua dolor do amet sint. Velit officia consequat duis enim velit mollit. Exercitation veniam consequat sunt nostrud amet.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        appBarText: 'Product Detail',
        action: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert, color: CollectionsColors.deepPurple,))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        'assets/images/vegetables.jpg',
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            child: productName(),
                          ),
                          Container(
                            child: amountForecast(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          showAmount('Cost', '25.0', 'per unit'),
                          showAmount('Amount', '40', 'bath'),
                          showAmount('Weight', '40', 'gram'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: showInformation('Product Detail', info),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Product Sales of Week',
                              style: FontCollection.bodyBlackBoldTextStyle,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                            child: Text(
                              '*Product sales statistics for the last 7 days ',
                              style: FontCollection.descriptionBlackTextStyle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        child: DataGrid(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productName() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            '#0002',
            style: FontCollection.bodyBlackTextStyle,
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            'Cucumber',
            style: FontCollection.topicBoldTextStyle,
          ),
        ),
      ],
    );
  }

  Widget amountForecast() {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 10),
          child: Text(
            'TMR forecast',
            style: FontCollection.bodyBlackBoldTextStyle,
          ),
        ),
        Container(
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.only(right: 10),
                child: Text(
                  '20',
                  style: FontCollection.bodyBoldPurpleTextStyle,
                ),
              ),
              Container(
                child: Text(
                  'Amount',
                  style: FontCollection.bodyBlackBoldTextStyle,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget showAmount(String header, String amount, String unit) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.topCenter,
            padding: EdgeInsets.only(bottom: 20),
            child: Text(
              header,
              style: FontCollection.bodyBlackBoldTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              amount,
              style: FontCollection.topicBoldPurpleTextStyle,
            ),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Text(
              unit,
              style: TextStyle(fontSize: 12, color: CollectionsColors.darkGrey),
            ),
          ),
        ],
      ),
    );
  }

  Widget showInformation(String header, String info) {
    return Column(
      children: [
        Container(
          alignment: Alignment.topLeft,
          padding: EdgeInsets.only(bottom: 20),
          child: Text(
            header,
            style: FontCollection.bodyBlackBoldTextStyle,
          ),
        ),
        Container(
          child: Text(
            info,
            style: FontCollection.bodyBlackTextStyle,
          ),
        ),
      ],
    );
  }
}
