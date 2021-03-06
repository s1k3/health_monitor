import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:weather_app/models/chart_data.dart';

class DashBoardChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  DashBoardChart(this.seriesList, {this.animate});

  /// Creates a [LineChart] with sample data and no transition.
  factory DashBoardChart.withSampleData(var bodyTemperature,var heartBeat) {
    return new DashBoardChart(
      _createChart(bodyTemperature,heartBeat),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.LineChart(seriesList,
        animate: animate,
        primaryMeasureAxis: charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
        domainAxis: charts.NumericAxisSpec(renderSpec: new charts.NoneRenderSpec()),
        customSeriesRenderers: [
          new charts.LineRendererConfig(
            // ID used to link series to this renderer.
              customRendererId: 'customArea',
              includeArea: false,

              stacked: true),
        ]);
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<ChartData, int>> _createChart(var bodyTemperature,var heartBeat) {

    return [
      new charts.Series<ChartData, int>(
        id: 'Desktop',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (ChartData data, _) => data.index,
        measureFn: (ChartData data, _) => data.value,
        data: bodyTemperature,
      )
      // Configure our custom bar target renderer for this series.
        ..setAttribute(charts.rendererIdKey, 'customArea'),
      new charts.Series<ChartData, int>(
        id: 'Tablet',
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (ChartData data, _) => data.index,
        measureFn: (ChartData data, _) => data.value,
        data: heartBeat,
      ),
    ];
  }
}
