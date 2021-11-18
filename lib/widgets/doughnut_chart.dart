import 'package:csc344_project/notifier/product_notifier.dart';
import 'package:csc344_project/style/color.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class DoughnutChart extends StatefulWidget {
  const DoughnutChart({Key? key}) : super(key: key);

  @override
  _DoughnutChartState createState() => _DoughnutChartState();
}

class _DoughnutChartState extends State<DoughnutChart> {
  List<ChartData> chartData = [];
  List colors = [
    CollectionsColors.deepPurple,
    CollectionsColors.purple,
    CollectionsColors.yellow,
    CollectionsColors.darkGrey,
    CollectionsColors.lightPurple,
  ];

  @override
  void initState() {
    ProductNotifier productNotifier =
        Provider.of<ProductNotifier>(context, listen: false);

    for (int i = 0; i < 5; i++) {
      final product = productNotifier.amountOfProductSold[i];
      chartData.add(
        ChartData(product.productName, product.totalAmount, colors[i]),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
            pointColorMapper: (ChartData data, _) => data.color,
            xValueMapper: (ChartData data, _) => data.x,
            yValueMapper: (ChartData data, _) => data.y,
          )
        ])));
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final int y;
  final Color color;
}
