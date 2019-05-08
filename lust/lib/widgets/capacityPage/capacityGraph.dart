import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lust/models/capacity/percentPerHour.dart';


class CapacityGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  CapacityGraph(this.seriesList, {this.animate});

  factory CapacityGraph.withSampleData() {
    return new CapacityGraph(
      _createChartData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,

      animate: animate,
    );
  }

  static List<charts.Series<PercentPerHour, String>> _createChartData() {
    final data = [
      new PercentPerHour(10, "8"),
      new PercentPerHour(30, "10"),
      new PercentPerHour(50, "12"),
      new PercentPerHour(70, "14"),
      new PercentPerHour(90, "16"),
      new PercentPerHour(90, "18"),
      new PercentPerHour(70, "20"),
      new PercentPerHour(50, "22"),
      ];

    return [
      new charts.Series<PercentPerHour, String>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PercentPerHour percent, _) => percent.hour,
        measureFn: (PercentPerHour percent, _) => percent.percent,
        data: data,
      )
    ];
  }
}
