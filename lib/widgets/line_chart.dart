import 'package:csc344_project/model/soldItem.dart';
import 'package:csc344_project/notifier/solditem_notifier.dart';
import 'package:csc344_project/style/color.dart';
import 'package:csc344_project/style/font_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class LineChart extends StatelessWidget {
  LineChart({Key? key, @required this.isIncome}) : super(key: key);
  final isIncome;

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
            primaryYAxis: isIncome
                ? NumericAxis(
                    numberFormat: NumberFormat.simpleCurrency(locale: 'th'),
                  )
                : NumericAxis(),
            series: <ChartSeries>[
              LineSeries<SoldItem, String>(
                dataSource: soldItem.soldList,
                xValueMapper: (SoldItem soldItem, _) =>
                    soldItem.date.characters.getRange(0, 2).toString(),
                yValueMapper: (SoldItem soldItem, _) => isIncome
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
                  Trendline(type: TrendlineType.polynomial, color: Colors.blue)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
