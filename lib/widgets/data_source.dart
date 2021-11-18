import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class DataSource extends DataGridSource {
  DataSource({required List productSold}) {
    dataGridRows = productSold
        .map<DataGridRow>(
          (data) => DataGridRow(
            cells: [
              DataGridCell<String>(columnName: 'date', value: data['date']),
              DataGridCell<int>(columnName: 'amount', value: data['amount']),
              DataGridCell<int>(
                  columnName: 'productSales', value: data['totalPrice']),
            ],
          ),
        )
        .toList();
  }

  List<DataGridRow> dataGridRows = [];

  @override
  List<DataGridRow> get rows => dataGridRows;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
          alignment: Alignment.centerLeft,
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            dataGridCell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ));
    }).toList());
  }
}
