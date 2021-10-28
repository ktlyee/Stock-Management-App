import 'package:csc344_project/style/color.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class DoughnutChart extends StatefulWidget {
  const DoughnutChart({Key? key}) : super(key: key);

  @override
  _DoughnutChartState createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  @override
  Widget build(BuildContext context) {
    final List<ChartData> chartData = [
      ChartData('Cabbage', 30, CollectionsColors.deepPurple),
      ChartData('Cucumber', 20, CollectionsColors.purple),
      ChartData('Carrot', 25, CollectionsColors.yellow),
      ChartData('Pumpkin', 10, Color(0xFFFFE38E)),
      ChartData('tomato', 10, CollectionsColors.darkGrey),
      ChartData('Thai Basil', 5, CollectionsColors.lightPurple),
    ];

    return Center(
        child: Container(
            child: SfCircularChart(
                legend: Legend(
                  isVisible: true,
                  position: LegendPosition.right,
                ),
                series: <CircularSeries>[
                  DoughnutSeries<ChartData, String>(
                      dataSource: chartData,
                      pointColorMapper:(ChartData data,  _) => data.color,
                      xValueMapper: (ChartData data, _) => data.x,
                      yValueMapper: (ChartData data, _) => data.y
                  )
                ]
            )
        )
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}
