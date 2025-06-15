import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class PieChartDemo extends StatelessWidget {
  final List<_ChartData> data = [
    _ChartData('Food', 300),
    _ChartData('Travel', 150),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Pie Chart Demo")),
      body: Center(
        child: SfCircularChart(
          legend: Legend(isVisible: true),
          series: <PieSeries<_ChartData, String>>[
            PieSeries<_ChartData, String>(
              dataSource: data,
              xValueMapper: (_ChartData data, _) => data.category,
              yValueMapper: (_ChartData data, _) => data.amount,
              dataLabelSettings: DataLabelSettings(isVisible: true),
            )
          ],
        ),
      ),
    );
  }
}

class _ChartData {
  final String category;
  final double amount;

  _ChartData(this.category, this.amount);
}
