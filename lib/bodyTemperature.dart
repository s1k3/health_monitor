import 'package:flutter/material.dart';
import 'package:weather_app/charts/line_chart.dart';
import 'package:firebase_database/firebase_database.dart';

class BodyTemperature extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return BodyTemperatureState();
  }

}

class BodyTemperatureState extends State<BodyTemperature>{

  List<ChartData> data=[];
  int index=0;
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseReference.child("temperature").onValue.listen((Event event) {
      if (this.mounted) {
        setState(() {
          int temperature=int.parse(event.snapshot.value.toString());
          data.add(ChartData(index, temperature));
          index++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Body Temperature"),
        backgroundColor: Colors.red[500],
      ),
      body: Center(
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
      ),
    );
  }

}
