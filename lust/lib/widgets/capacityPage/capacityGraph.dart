import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lust/models/percentPerHour.dart';


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
    return new charts.OrdinalComboChart(seriesList,
        animate: animate,
        // Configure the default renderer as a bar renderer.
        defaultRenderer: new charts.BarRendererConfig(
            groupingType: charts.BarGroupingType.grouped, strokeWidthPx: 2.0),
        // Custom renderer configuration for the line series. This will be used for
        // any series that does not define a rendererIdKey.
        customSeriesRenderers: [
          new charts.LineRendererConfig(
            // ID used to link series to this renderer.
              customRendererId: 'customLine')
        ]);
  }

  static List<charts.Series<PercentPerHour, String>> _createChartData() {
    final dataA = [
      new PercentPerHour(17, "8"),
      new PercentPerHour(35, "10"),
      new PercentPerHour(13, "12"),
      new PercentPerHour(7, "14"),
      new PercentPerHour(22, "16"),
      new PercentPerHour(42, "18"),
      new PercentPerHour(87, "20"),
      new PercentPerHour(69, "22"),
      ];

    var hour = CapacityTime.getTimeForCapacityGraph();
    print('hour in capacity ' + hour.toString());
    return [
      new charts.Series<PercentPerHour, String>(
        id: 'Other',
        colorFn: (PercentPerHour percent, __) => percent.hour == hour.toString()
              ? charts.MaterialPalette.red.shadeDefault
            : charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PercentPerHour percent, _) => percent.hour,
        measureFn: (PercentPerHour percent, _) => percent.percent,
        data: dataA,
      ),
//      new charts.Series<PercentPerHour, String>(
//        id: 'Current',
//        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
//        domainFn: (PercentPerHour percent, _) => percent.hour,
//        measureFn: (PercentPerHour percent, _) => percent.percent,
//        data: dataB,
//      )..setAttribute(charts.rendererIdKey, 'customLine'),

    ];
  }
}
