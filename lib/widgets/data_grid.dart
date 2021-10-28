import 'package:csc344_project/model/data.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'data_source.dart';

class DataGrid extends StatefulWidget {
  const DataGrid({Key? key}) : super(key: key);

  @override
  _DataGridState createState() => _DataGridState();
}

class _DataGridState extends State<DataGrid> {

  late EmployeeDataSource _employeeDataSource;

  List<Employee> _employees = <Employee>[];

  @override
  void initState() {
    super.initState();
    _employees = getEmployeeData();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
  }

  List<Employee> getEmployeeData() {
    return [
      Employee('James', 'Project Lead', 20000),
      Employee('Kathryn', 'Manager', 30000),
      Employee('Lara', 'Developer', 15000),
      Employee('Michael', 'Designer', 15000),
      Employee('Martin', 'Developer', 15000),
      Employee('Newberry', 'Developer', 15000),
      Employee('Balnc', 'Developer', 15000),
      Employee('Perry', 'Developer', 15000),
      Employee('Gable', 'Developer', 15000),
      Employee('Grimes', 'Developer', 15000),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SfDataGridTheme(
      data: SfDataGridThemeData(headerColor: CollectionsColors.deepPurple),
      child: SfDataGrid(
        source: _employeeDataSource,
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
                  ))),
          GridColumn(
              columnName: 'amount',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Amount',
                    overflow: TextOverflow.ellipsis,
                    style: FontCollection.descriptionBoldTextStyle,
                  ))),
          GridColumn(
              columnName: 'productSales',
              label: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Product Sales',
                    overflow: TextOverflow.ellipsis,
                    style: FontCollection.descriptionBoldTextStyle,
                  ))),
        ],
      ),
    );
  }
}
