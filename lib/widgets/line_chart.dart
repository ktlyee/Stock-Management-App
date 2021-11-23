import 'package:csc344_project/model/soldItem.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import '../home_page.dart';


class LineChart extends StatefulWidget {
  LineChart({Key? key, @required this.isIncome,})
      : super(key: key);
  final isIncome;

  @override
  _LineChartState createState() => _LineChartState();
}

class _LineChartState extends State<LineChart> {
  @override
  Widget build(BuildContext context) {
      SoldItemsNotifier soldItem = Provider.of<SoldItemsNotifier>(context);

      return Center(
        child: Container(
          child: SfTheme(
            data: SfThemeData(
              chartThemeData: SfChartThemeData(
                axisLabelColor: Colors.white,
                crosshairLineColor: CollectionsColors.yellow,
                crosshairLabelColor: Colors.white,
                majorGridLineColor: CollectionsColors.purple,
                plotAreaBorderColor: CollectionsColors.purple,
              ),
            ),
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: widget.isIncome
                  ? NumericAxis(
                numberFormat: NumberFormat.simpleCurrency(locale: 'th'),
              )
                  : NumericAxis(),
              series: <ChartSeries>[
                if (saleIndex == 0) ...[
                  LineSeries<SoldItem, String>(
                    dataSource: soldItem.soldList,
                    xValueMapper: (SoldItem soldItem, _) =>
                        soldItem.date.characters.getRange(0, 2).toString(),
                    yValueMapper: (SoldItem soldItem, _) => widget.isIncome
                        ? soldItem.totalIncome
                        : soldItem.totalAmountSoldProducts,
                    color: CollectionsColors.yellow,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: FontCollection.descriptionTextStyle),
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      borderColor: CollectionsColors.yellow,
                    ),
                    trendlines: <Trendline>[
                      Trendline(
                          type: TrendlineType.polynomial, color: Colors.blue)
                    ],
                  ),
                ] else if (saleIndex == 1) ...[
                  LineSeries<SalesData, String>(
                    dataSource: salesChartData,
                    xValueMapper: (SalesData sales, _) => sales.month,
                    yValueMapper: (SalesData sales, _) => sales.number,
                    color: CollectionsColors.yellow,
                    dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                        textStyle: FontCollection.descriptionTextStyle),
                    markerSettings: MarkerSettings(
                      isVisible: true,
                      shape: DataMarkerType.circle,
                      borderColor: CollectionsColors.yellow,
                    ),
                    trendlines: <Trendline>[
                      Trendline(
                          type: TrendlineType.polynomial,
                          color: Colors.blue)
                    ],
                  ),
                ]
              ],
            ),
          ),
        ),
      );

}




  final List<SalesData> salesChartData = [
    SalesData(4962, 'January'),
    SalesData(5013, 'February'),
    SalesData(4992, 'March'),
    SalesData(4986, 'April'),
    SalesData(5168, 'May'),
    SalesData(5107, 'June'),
  ];

}

class IncomeLineChart extends StatefulWidget {
  IncomeLineChart({Key? key, @required this.isIncome,})
      : super(key: key);
  final isIncome;

  @override
  _IncomeLineChartState createState() => _IncomeLineChartState();
}

class _IncomeLineChartState extends State<IncomeLineChart> {
  @override
  Widget build(BuildContext context) {
    SoldItemsNotifier soldItem = Provider.of<SoldItemsNotifier>(context);

    return Center(
      child: Container(
        child: SfTheme(
          data: SfThemeData(
            chartThemeData: SfChartThemeData(
              axisLabelColor: Colors.white,
              crosshairLineColor: CollectionsColors.yellow,
              crosshairLabelColor: Colors.white,
              majorGridLineColor: CollectionsColors.purple,
              plotAreaBorderColor: CollectionsColors.purple,
            ),
          ),
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            primaryYAxis: widget.isIncome
                ? NumericAxis(
              numberFormat: NumberFormat.simpleCurrency(locale: 'th'),
            )
                : NumericAxis(),
            series: <ChartSeries>[
              if (incomeIndex == 0) ...[
                LineSeries<SoldItem, String>(
                  dataSource: soldItem.soldList,
                  xValueMapper: (SoldItem soldItem, _) =>
                      soldItem.date.characters.getRange(0, 2).toString(),
                  yValueMapper: (SoldItem soldItem, _) =>
                  widget.isIncome
                      ? soldItem.totalIncome
                      : soldItem.totalAmountSoldProducts,
                  color: CollectionsColors.yellow,
                  dataLabelSettings: DataLabelSettings(
                      isVisible: true,
                      textStyle: FontCollection.descriptionTextStyle),
                  markerSettings: MarkerSettings(
                    isVisible: true,
                    shape: DataMarkerType.circle,
                    borderColor: CollectionsColors.yellow,
                  ),
                  trendlines: <Trendline>[
                    Trendline(
                        type: TrendlineType.polynomial, color: Colors.blue)
                  ],
                ),
              ] else
                  if (incomeIndex == 1) ...[
                    LineSeries<IncomeData, String>(
                      dataSource: incomeChartData,
                      xValueMapper: (IncomeData sales, _) => sales.month,
                      yValueMapper: (IncomeData sales, _) => sales.price,
                      color: CollectionsColors.yellow,
                      dataLabelSettings: DataLabelSettings(
                          isVisible: true,
                          textStyle: FontCollection.descriptionTextStyle),
                      markerSettings: MarkerSettings(
                        isVisible: true,
                        shape: DataMarkerType.circle,
                        borderColor: CollectionsColors.yellow,
                      ),
                      trendlines: <Trendline>[
                        Trendline(
                            type: TrendlineType.polynomial,
                            color: Colors.blue)
                      ],
                    ),
                  ]
            ],
          ),
        ),
      ),
    );
  }

  final List<IncomeData> incomeChartData = [
    IncomeData(148424.00, 'January'),
    IncomeData(157693.00, 'February'),
    IncomeData(161460.00, 'March'),
    IncomeData(172852.00, 'April'),
    IncomeData(168327.00, 'May'),
    IncomeData(170364.00, 'June'),
  ];

}


class SalesData {
  final double number;
  final String month;

  SalesData(
    this.number,
    this.month,
  );
}

class IncomeData {
  final double price;
  final String month;

  IncomeData(
    this.price,
    this.month,
  );
}
