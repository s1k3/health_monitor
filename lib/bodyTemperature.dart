import 'package:flutter/material.dart';
import 'package:weather_app/charts/line_chart.dart';
import 'package:weather_app/models/chart_data.dart';

class BodyTemperature extends StatefulWidget {
  List<ChartData> data;
  BodyTemperature(this.data);

  @override
  State<StatefulWidget> createState() {
    return BodyTemperatureState(data);
  }
}

class BodyTemperatureState extends State<BodyTemperature> {
  List<ChartData> data;
  BodyTemperatureState(this.data);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Temperature"),
        backgroundColor: Colors.red[500],
      ),
      body: _getPage(),
    );
  }

  _getPage() {
    Widget widget = Center(
      child: Container(
        height: 400,
        child: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Container(
            height: 200,
            child: LineChart.withData(data),
          ),
        ),
      ),
    );
    if (this.data.length > 1) {
      return widget;
    }
    return Center(child: CircularProgressIndicator());
  }
}
