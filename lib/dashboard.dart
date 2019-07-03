import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weather_app/charts/dashboard_chart.dart';

class Dashboard extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashBoardState();
  }
}

class DashBoardState extends State<Dashboard> {
  int temperature = 0;
  int heart_beat = 0;
  int loading = 1;
  int temperatureIndex=0;
  int heartIndex=0;

  final databaseReference = FirebaseDatabase.instance.reference();
  List<DashBoardChartData> bodyTemperature = [];
  List<DashBoardChartData> heartBeat = [];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseReference.once().then((DataSnapshot snapshot) {
      if (this.mounted) {
        setState(() {
          temperature = snapshot.value["temperature"];
          heart_beat = snapshot.value["heart_beat"];
          bodyTemperature.add(DashBoardChartData(temperatureIndex, temperature));
          temperatureIndex++;
          heartBeat.add(DashBoardChartData(heartIndex, heart_beat));
          heartIndex++;
          loading = 0;
        });
      }
    });
    databaseReference.child("temperature").onValue.listen((Event event) {
      if (this.mounted) {
        setState(() {
          temperature = event.snapshot.value;
          bodyTemperature.add(DashBoardChartData(temperatureIndex, temperature));
          temperatureIndex++;
        });
      }
    });
    databaseReference.child("heart_beat").onValue.listen((Event event) {
      if (this.mounted) {
        setState(() {
          heart_beat = event.snapshot.value;
          heartBeat.add(DashBoardChartData(heartIndex, heart_beat));
          heartIndex++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.red[500],
      ),
      body: _getBody(),
    );
  }

  _getBody() {
    if (loading == 1) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    return Padding(
      padding: EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          InformationWidget("Body Temperature", "$temperature \u1d52 C",
              Icon(FontAwesomeIcons.thermometerHalf)),
          InformationWidget("Heart Beat", "$heart_beat BPS",
              Icon(FontAwesomeIcons.heartbeat)),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("Body Temperature",
                          style: TextStyle(color: Colors.blue)),
                      SizedBox(
                        width: 15,
                      ),
                      Text("VS"),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Heart Beat", style: TextStyle(color: Colors.red)),
                    ],
                  ),
                  Container(
                    height: 220,
                    child: DashBoardChart.withSampleData(
                        bodyTemperature, heartBeat),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class InformationWidget extends StatelessWidget {
  String title;
  String information;
  Icon icon;

  InformationWidget(this.title, this.information, this.icon);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(this.title,
                    style: TextStyle(color: Colors.teal[500], fontSize: 16)),
                SizedBox(
                  height: 10,
                ),
                Text(this.information,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 26,
                    )),
              ],
            ),
            Icon(
              icon.icon,
              color: Colors.red[400],
              size: 48,
            )
          ],
        ),
      ),
    );
  }
}
