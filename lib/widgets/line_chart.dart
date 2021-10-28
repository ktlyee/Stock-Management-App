import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_charts/sparkcharts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class LineChart extends StatelessWidget {
  LineChart({Key? key}) : super(key: key);

  final List<SalesData> chartData = [
    SalesData('Sun', 650),
    SalesData('Mon', 345),
    SalesData('Tue', 486),
    SalesData('Wed', 389),
    SalesData('Thu', 412),
    SalesData('Fri', 593),
    SalesData('Sat', 623),
  ];

  @override
  Widget build(BuildContext context) {
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
            primaryYAxis:
                NumericAxis(numberFormat: NumberFormat.simpleCurrency(),),
            series: <ChartSeries>[
              LineSeries<SalesData, String>(
                dataSource: chartData,
                xValueMapper: (SalesData sales, _) => sales.date,
                yValueMapper: (SalesData sales, _) => sales.income,
                color: CollectionsColors.yellow,
                dataLabelSettings: DataLabelSettings(isVisible: true, textStyle: FontCollection.descriptionTextStyle),
                markerSettings: MarkerSettings(
                  isVisible: true,
                  shape: DataMarkerType.circle,
                  borderColor: CollectionsColors.yellow,
                ),
                trendlines:<Trendline>[
                  Trendline(
                      type: TrendlineType.polynomial,
                      color: Colors.blue)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.date, this.income);

  final String date;
  final int income;
}
