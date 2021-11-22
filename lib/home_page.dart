import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:csc344_project/sale_page.dart';
import 'package:csc344_project/service/database.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/line_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String month = DateFormat('MMM').format(DateTime.now()).toString();

  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    SoldItemsNotifier soldItem =
        Provider.of<SoldItemsNotifier>(context, listen: false);
    getSoldItems(soldItem, month);
    getProducts(productNotifier);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: MainAppBar(
        appBarText: 'Home',
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 0, 0, 20),
                alignment: Alignment.topLeft,
                child: Text(
                  'Sales',
                  style: FontCollection.bodyBoldPurpleTextStyle,
                ),
              ),
              buildToggleButton(isSelected2),
              buildCard(
                Icons.info,
                'See more detail',
                () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => SalesPage(),
                    ),
                  );
                },
                Container(
                  padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                  child: LineChart(isIncome: false),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(5, 20, 0, 20),
                alignment: Alignment.topLeft,
                child: Text(
                  'Income',
                  style: FontCollection.bodyBoldPurpleTextStyle,
                ),
              ),
              buildToggleButton(isSelected),
              Container(
                padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: CollectionsColors.purple,
                ),
                child: LineChart(isIncome: true),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCard(
      IconData icon, String navText, VoidCallback onClicked, Widget child) {
    return Column(
      // fit: StackFit.passthrough,
      // overflow: Overflow.visible,
      children: [
        Container(
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(10),
              ),
            ),
            color: CollectionsColors.purple,
            child: Container(
              width: MediaQuery.of(context).size.width,
              child: child,
            ),
          ),
        ),
        GestureDetector(
          onTap: onClicked,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(10),
              ),
            ),
            color: CollectionsColors.lightPurple,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(30, 0, 20, 0),
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(icon),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(
                            navText,
                            style: FontCollection.bodyBlackTextStyle,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Icon(Icons.navigate_next),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildStat(String topic, String number) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Text(
              topic,
              style: FontCollection.bodyTextStyle,
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              number,
              style: TextStyle(
                color: CollectionsColors.yellow,
                fontWeight: FontWeight.w700,
                fontSize: 24.0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<bool> isSelected = [true, false, false];
  List<bool> isSelected2 = [true, false, false];

  Widget buildToggleButton(List<bool> isSelected) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: CollectionsColors.lightPurple,
      ),
      margin: EdgeInsets.fromLTRB(5, 0, 5, 20),
      child: ToggleButtons(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        renderBorder: false,
        fillColor: CollectionsColors.deepPurple,
        children: <Widget>[
          Container(
            width: (MediaQuery.of(context).size.width / 3) - 20,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Weekly',
              style: FontCollection.smallBodyTextStyle,
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width / 3) - 10,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Monthly',
              style: FontCollection.smallBodyTextStyle,
            ),
          ),
          Container(
            width: (MediaQuery.of(context).size.width / 3) - 20,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              'Yearly',
              style: FontCollection.smallBodyTextStyle,
            ),
          ),
        ],
        isSelected: isSelected,
        onPressed: (int newIndex) {
          setState(() {
            for (int index = 0; index < isSelected.length; index++) {
              if (index == newIndex) {
                isSelected[index] = true;
              } else {
                isSelected[index] = false;
              }
            }
          });
        },
      ),
    );
  }
}
