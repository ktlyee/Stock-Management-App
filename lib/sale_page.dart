import 'package:csc344_project/order_history.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/button_widget.dart';
import 'package:csc344_project/widgets/doughnut_chart.dart';
import 'package:csc344_project/order_history.dart';
import 'package:flutter/material.dart';

class SalesPage extends StatefulWidget {
  const SalesPage({Key? key}) : super(key: key);

  @override
  _SalesPageState createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  @override
  Widget build(BuildContext context) {
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
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      // margin: EdgeInsets.only(bottom: 10),
                      // padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: CollectionsColors.purple,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Vegetable',
                              style: FontCollection.bodyTextStyle,
                            ),
                          ),
                          listData('Cabbage', 60),
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

  Widget listData(String pName, double pNumber) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Text(
                  pName,
                  style: FontCollection.bodyBlackTextStyle,
                ),
              ),
              Container(
                child: Text(
                  pNumber.toString(),
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
