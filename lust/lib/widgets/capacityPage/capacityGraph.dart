import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lust/models/percentPerHour.dart';
import 'package:lust/widgets/utils/timeHandler.dart';
import 'package:lust/models/library.dart';

class CapacityGraph extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  final Library library;

  CapacityGraph(this.seriesList, this.library, {this.animate});

  factory CapacityGraph.withSampleData() {
    var lib = Library.withSampleData();
    return new CapacityGraph(
      // DateTime.now() only to fulfill the requirements
      _createChartData(lib.getOccupancyPercentPerHour(DateTime.now())),
      Library.withSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(seriesList,
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

  /// Helper class to create the list of chart.Series out of an array of percentPerHour
  static List<charts.Series<PercentPerHour, String>> _createChartData(
      occupancyPercentPerHour) {
    final data = occupancyPercentPerHour;

    var hour = TimeHandler.makeHourEven(DateTime
        .now()
        .hour);
    print('hour in capacity ' + hour.toString());
    return [
      new charts.Series<PercentPerHour, String>(
        id: 'Other',
        colorFn: (PercentPerHour percent, __) => percent.hour == hour.toString()
              ? charts.MaterialPalette.red.shadeDefault
            : charts.MaterialPalette.blue.shadeDefault,
        domainFn: (PercentPerHour percent, _) => percent.hour,
        measureFn: (PercentPerHour percent, _) => percent.percent,
        data: data,
      ),
    ];
  }
}
