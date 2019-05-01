import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lust/models/capacity/percentPerHour.dart';

class CapacityWidget extends StatefulWidget {
  @override
  _CapacityWidgetState createState() => new _CapacityWidgetState();
}

class _CapacityWidgetState extends State<CapacityWidget> {

  final _title = "Capacity";

  List<charts.Series<PercentPerHour, String>> _createChartData() {
    final data = [
      new PercentPerHour("10", 8),
      new PercentPerHour("20", 9),
      new PercentPerHour("30", 10),
      new PercentPerHour("40", 11),
      new PercentPerHour("50", 12),
      new PercentPerHour("60", 13),
      new PercentPerHour("70", 14),
      new PercentPerHour("80", 15),
      new PercentPerHour("90", 16),
      new PercentPerHour("100", 17),
      new PercentPerHour("90", 18),
      new PercentPerHour("80", 19),
      new PercentPerHour("70", 20),
      new PercentPerHour("60", 21),
      new PercentPerHour("50", 22),
      new PercentPerHour("40", 23),
    ];

    return [
      new charts.Series<PercentPerHour, String>(
          id: 'Statistics',
          domainFn: (PercentPerHour rolls, _) => rolls.percent,
          measureFn: (PercentPerHour rolls, _) => rolls.hour,
          data: data,
          // Set a label accessor to control the text of the bar label.
          labelAccessorFn: (PercentPerHour rolls, _) =>
          '${rolls.percent.toString()}: ${rolls.hour.toString()}\%')
    ];
  }

  @override
  Widget build(BuildContext context) {

    var chart = new charts.BarChart(
      _createChartData(),
      animate: true,
      vertical: false,
      barRendererDecorator: new charts.BarLabelDecorator<String>(),
      // Hide domain axis.
      domainAxis:
      new charts.OrdinalAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    )



    return Scaffold(
        appBar: AppBar(
          title: Text(_title),
        ),
        body: Center(
          child: Text('M'),
        ));
  } // build



}
