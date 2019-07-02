import 'package:flutter/material.dart';
import 'package:flutter_sparkline/flutter_sparkline.dart';


class Chart extends StatefulWidget {
  var data;

  Chart(this.data);

  @override
  ChartState createState() => ChartState(this.data);
}

class ChartState extends State<Chart> {
  var data;

  ChartState(this.data);

  @override
  Widget build(BuildContext context) {
    return Sparkline(
      data: data,
      lineColor: Colors.red[500],
      pointsMode: PointsMode.all,
      pointSize: 15.0,
      lineWidth: 6,
      pointColor: Colors.red[700],
    );
  }
}
