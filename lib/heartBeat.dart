import 'package:flutter/material.dart';
import 'package:weather_app/charts/Chart.dart';

class HeartBeat extends StatelessWidget {
  var heartBeat;

  HeartBeat(this.heartBeat);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Heart Beat"),
        backgroundColor: Colors.red[500],
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
          child: Container(
            height: 200,
            child: Chart(heartBeat),
          ),
        ),
      ),
    );
  }
}
