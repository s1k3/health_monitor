import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

class HeartBeatChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  HeartBeatChart(this.seriesList, {this.animate});

  /// Creates a [TimeSeriesChart] with sample data and no transition.
  factory HeartBeatChart.withSampleData() {
    return new HeartBeatChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
    );
  }

  /// Create one series with sample hard coded data.
  static List<charts.Series<HeartBeat, DateTime>> _createSampleData() {
    final data = [
      new HeartBeat(new DateTime(2017, 9, 19), 71),
      new HeartBeat(new DateTime(2017, 9, 26), 65),
      new HeartBeat(new DateTime(2017, 10, 3), 70),
      new HeartBeat(new DateTime(2017, 10, 10), 75),
      new HeartBeat(new DateTime(2017, 10, 11), 75),
      new HeartBeat(new DateTime(2017, 10, 12), 76),
      new HeartBeat(new DateTime(2017, 10, 13), 72),
    ];

    return [
      new charts.Series<HeartBeat, DateTime>(
        id: 'Sales',
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        domainFn: (HeartBeat sales, _) => sales.time,
        measureFn: (HeartBeat sales, _) => sales.sales,
        data: data,
      )
    ];
  }
}

/// Sample time series data type.
class HeartBeat {
  final DateTime time;
  final int sales;

  HeartBeat(this.time, this.sales);
}
