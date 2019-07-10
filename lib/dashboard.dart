import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weather_app/charts/dashboard_chart.dart';
import 'package:weather_app/models/chart_data.dart';

class Dashboard extends StatefulWidget {
  List<ChartData> bodyTemperature = [];
  List<ChartData> heartBeat = [];

  Dashboard(this.bodyTemperature, this.heartBeat);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return DashBoardState(bodyTemperature, heartBeat);
  }
}

class DashBoardState extends State<Dashboard> {
  final databaseReference = FirebaseDatabase.instance.reference();
  List<ChartData> bodyTemperature = [];
  List<ChartData> heartBeat = [];

  DashBoardState(this.bodyTemperature, this.heartBeat);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        backgroundColor: Colors.red[500],
      ),
      body: _getPage(),
    );
  }

  _getPage(){
    Widget widget=Padding(
      padding: EdgeInsets.all(12),
      child: ListView(
        children: <Widget>[
          InformationWidget("Body Temperature", "${bodyTemperature.last.value}\u1d52C", Icon(FontAwesomeIcons.thermometerHalf)),
          InformationWidget("Heart Beat", "${heartBeat.last.value} BPS", Icon(FontAwesomeIcons.heartbeat)),
          Card(
            elevation: 4,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text("Body Temperature",
                          style: TextStyle(color: Colors.blue,fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 15,
                      ),
                      Text("VS",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500)),
                      SizedBox(
                        width: 15,
                      ),
                      Text("Heart Beat", style: TextStyle(color: Colors.red,fontWeight: FontWeight.w500)),
                    ],
                  ),
                  Container(
                    height: 150,
                    child: DashBoardChart.withSampleData(
                        bodyTemperature, heartBeat),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
    if(this.bodyTemperature.length>1&&this.heartBeat.length>1){
      return Scrollbar(child: widget);
    }
    return Center(
      child: CircularProgressIndicator(),
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
                    style: TextStyle(color: Colors.teal[500], fontSize: 16,fontWeight: FontWeight.w500)),
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
