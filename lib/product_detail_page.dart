import 'package:csc344_project/add_product.dart';
import 'package:csc344_project/model/product.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:csc344_project/service/database.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:csc344_project/widgets/appbar.dart';
import 'package:csc344_project/service/predict_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:csc344_project/widgets/data_grid.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:csc344_project/service/api.dart';
import 'package:dio/dio.dart';


class InventoryDetailPage extends StatefulWidget {
  InventoryDetailPage({Key? key}) : super(key: key);

  @override
  _InventoryDetailPageState createState() => _InventoryDetailPageState();
}

class _InventoryDetailPageState extends State<InventoryDetailPage> {
  Product product = Product();

  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);
    product = productNotifier.currentProduct;
    super.initState();
  }

  void actionPopUpItemSelected(String value, String name) {
    String message;
    if (value == 'edit') {
      // message = 'You selected edit for $name';
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddProductPage(isUpdating: true)));
      // print(message);
    } else if (value == 'delete') {
      message = 'You selected delete for $name';
      print(message);
    } else {
      message = 'Not implemented';
      print(message);
    }
  }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);

    return Scaffold(
      appBar: MainAppBar(
        appBarText: 'Product Detail',
        action: [
          PopupMenuButton(
              color: CollectionsColors.lightPurple,
              onSelected: (String value) {
                actionPopUpItemSelected(value, product.name);
              },
              itemBuilder: (context) => [
                    PopupMenuItem(
                      child: popUpList('Edit', Icons.edit),
                      value: 'edit',
                    ),
                    PopupMenuItem(
                      child: popUpList('Delete', Icons.delete),
                      value: 'delete',
                    ),
                  ])
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
                      child: product.image != ''
                          ? Image.network(product.image)
                          : Image.asset(
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
                          showAmount('Cost', product.cost, 'per unit'),
                          showAmount('Price', product.price, 'baht'),
                          showAmount('Amount', product.amount, 'unit'),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: showInformation('Product Detail', product.detail),
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
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 20),
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
                        child: DataGrid(
                          documentId: productNotifier.currentProduct.documentId,
                        ),
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
            '#${product.productId}',
            style: FontCollection.bodyBlackTextStyle,
          ),
        ),
        Container(
          alignment: Alignment.bottomLeft,
          child: Text(
            product.name,
            style: FontCollection.topicBoldTextStyle,
          ),
        ),
      ],
    );
  }

  Widget amountForecast() {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);

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
                child: FutureBuilder<double>(
                  future: PredictModel.predictData({
                    'x': productNotifier.convertArray(productNotifier.dateProductSold),
                    'y':
                    productNotifier.convertArray(productNotifier.amountProductSold),
                    'x_predict': productNotifier.dateProductSold.length + 1
                  }),
                  builder: (context,AsyncSnapshot<double> snapshot) {
                    if (snapshot.hasData){
                      double? predictRes = snapshot.data;
                      return Text(predictRes!.toStringAsFixed(2), style: FontCollection.bodyBlackTextStyle,);
                    }else{
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
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

  Widget popUpList(String text, IconData iconData) {
    return ListTile(
      leading: Icon(
        iconData,
        color: Colors.black,
      ),
      title: Text(
        text,
        style: FontCollection.bodyBlackTextStyle,
      ),
    );
  }
}
