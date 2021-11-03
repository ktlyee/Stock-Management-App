import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/widgets/button_widget.dart';
import 'package:csc344_project/widgets/stepper.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AddOrderPage extends StatefulWidget {
  const AddOrderPage({Key? key}) : super(key: key);

  @override
  _AddOrderPageState createState() => _AddOrderPageState();
}

class _AddOrderPageState extends State<AddOrderPage> {
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
                    DateFormat('dd MMM yyyy').format(DateTime.now()).toString(),
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
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.only(bottom: 10),
                      // padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: CollectionsColors.purple,
                      ),
                      child: ExpansionTile(
                        collapsedIconColor: CollectionsColors.white,
                        iconColor: CollectionsColors.white,
                        title: Text(
                          'Vegetable',
                          style: FontCollection.bodyBoldTextStyle,
                        ),
                        children: [
                          Container(
                            color: CollectionsColors.white,
                            child: listData('Cabbage', 60),
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
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int amount = 1;

  void handleIncreaseAmount() {
    setState(() {
      amount += 1;
    });
  }

  void handleDecreaseAmount() {
    if (amount > 0) {
      setState(() {
        amount -= 1;
      });
    }
  }

  Widget listData(String pName, double pNumber) {
    return ListView.separated(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: 3,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.only(bottom: 5),
          padding: EdgeInsets.fromLTRB(20,0,20,0),
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
                  child: CustomStepper(
                value: amount,
                iconSize: 25,
                decreaseAmount: handleDecreaseAmount,
                increaseAmount: handleIncreaseAmount,
              )),
            ],
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Divider(thickness: 2,);
      },
    );
  }
}
