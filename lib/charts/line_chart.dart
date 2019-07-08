import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:weather_app/models/chart_data.dart';
class LineChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  LineChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory LineChart.withData(var data) {
    return new LineChart(
      _createChart(data),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(
        seriesList,
        animate: animate,
        domainAxis: charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ChartData, int>> _createChart(var data) {
    return [
      new charts.Series<ChartData, int>(
        id: 'value',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (ChartData value, _) => value.index,
        measureFn: (ChartData value, _) => value.value,
        data: data,
      )
    ];
  }
}
/// Sample linear data type.