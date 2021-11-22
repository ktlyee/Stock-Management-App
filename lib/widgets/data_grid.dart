// ignore_for_file: unused_local_variable

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/service/api.dart';
import 'package:csc344_project/service/database.dart';
import 'package:csc344_project/service/predict_model.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'data_source.dart';

class DataGrid extends StatefulWidget {
  const DataGrid({Key? key, required this.documentId}) : super(key: key);

  final String documentId;

  @override
  _DataGridState createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {
  late DataSource _dataSource;

  // var url = 'http://127.0.0.1:5000/predict';
  //
  // Future postToFlask(List<int> inputList) async {
  //   try {
  //     final res = await http.post(Uri.parse(url),
  //         body: {
  //
  //
  //     }
  //     );
  //   } catch (ex) {}
  // }

  @override
  Widget build(BuildContext context) {
    ProductNotifier productNotifier = Provider.of<ProductNotifier>(context);

    return StreamBuilder(
      stream: getEachProductSold(widget.documentId),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Text('Loading');
        }

        _dataSource = DataSource(productSold: snapshot.data!.docs);

        List<int> amount = [];
        List<Characters> date = [];

        snapshot.data!.docs.forEach((document) {
          // fetchData();
          amount.add(document['amount']);
          date.add(document['date'].toString().characters.getRange(0, 2));
          // productNotifier.getEachProductSold(
          //   document['amount'],
          //   document['date'].toString().characters.getRange(0, 2),
          // );
          // print(document);
        });
        // print(amount);

        productNotifier.amountProductSold = amount;
        productNotifier.dateProductSold = date;
        //
        // Map<String, dynamic> temp = {
        //   'x': productNotifier.convertArray(date),
        //   'y':
        //       productNotifier.convertArray(amount),
        //   'x_predict': productNotifier.dateProductSold.length + 1
        // };
        // PredictModel.predictData(temp);

        // print(snapshot.data!.docs.map((e) => e));

        return SfDataGridTheme(
          data: SfDataGridThemeData(headerColor: CollectionsColors.deepPurple),
          child: SfDataGrid(
            source: _dataSource,
            columnWidthMode: ColumnWidthMode.fill,
            columns: [
              GridColumn(
                columnName: 'date',
                label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Date',
                    overflow: TextOverflow.ellipsis,
                    style: FontCollection.descriptionBoldTextStyle,
                  ),
                ),
              ),
              GridColumn(
                columnName: 'amount',
                label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Amount',
                    overflow: TextOverflow.ellipsis,
                    style: FontCollection.descriptionBoldTextStyle,
                  ),
                ),
              ),
              GridColumn(
                columnName: 'productSales',
                label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Product Sales',
                    overflow: TextOverflow.ellipsis,
                    style: FontCollection.descriptionBoldTextStyle,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
