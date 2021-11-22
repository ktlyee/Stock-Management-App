import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/service/database.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'data_source.dart';

class DataGrid extends StatefulWidget {
  const DataGrid({Key? key, required this.documentId}) : super(key: key);

  final String documentId;

  @override
  _DataGridState createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {
  late DataSource _dataSource;

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

        snapshot.data!.docs.forEach((document) {
          productNotifier.getEachProductSold(
            document['amount'],
            document['date'].toString().characters.getRange(0, 2),
          );
        });

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
