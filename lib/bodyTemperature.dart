import 'package:flutter/material.dart';
import 'package:weather_app/charts/Chart.dart';

class BodyTemperature extends StatelessWidget {
  var temperature;

  BodyTemperature(this.temperature);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Temperature"),
        backgroundColor: Colors.red[500],
      ),
      body: Center(
        child: Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Container(
              height: 200,
              child: Chart(temperature),
            ),
        ),
      ),
    );
  }
}
