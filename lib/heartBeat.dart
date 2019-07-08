import 'package:flutter/material.dart';
import 'package:weather_app/charts/line_chart.dart';
import 'package:weather_app/models/chart_data.dart';

class HeartBeat extends StatefulWidget {
  List<ChartData> data;
  HeartBeat(this.data);

  @override
  State<StatefulWidget> createState() {
    return HeartBeatState(data);
  }
}

class HeartBeatState extends State<HeartBeat> {
  List<ChartData> data;
  HeartBeatState(this.data);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heart Beat"),
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
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
