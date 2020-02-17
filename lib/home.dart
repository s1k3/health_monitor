import 'package:flutter/material.dart';
import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/heartBeat.dart';
import 'package:weather_app/dashboard.dart';
import 'package:weather_app/bodyTemperature.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:weather_app/models/chart_data.dart';

class Home extends StatefulWidget {
  @override
  HomeState createState() => HomeState();
}

class HomeState extends State<Home> {
  int currentPage = 0;
  List<ChartData> temperatures = [ChartData(0, 0)];
  List<ChartData> heart_beats = [ChartData(0, 0)];
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    super.initState();
    databaseReference.child("temperature").limitToLast(30).once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,value) {
        setState(() {
          temperatures.add(ChartData(temperatures.length, value['value']));
        });
      });
    });
    databaseReference.child("heartbeat").limitToLast(30).once().then((DataSnapshot snapshot){
      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,value) {
        setState(() {
          heart_beats.add(ChartData(heart_beats.length, value['value']));
        });
      });
    });
    databaseReference.child("temperature").onChildChanged.listen((Event event) async {
      if (this.mounted) {
        setState(() {
          int value = event.snapshot.value["value"];
          temperatures.add(ChartData(temperatures.length, value));
          List<ChartData> temp = [];
          if (temperatures.length > 30) {
            for (int i = 1; i < temperatures.length; i++) {
              temp.add(ChartData(i - 1, temperatures[i].value));
            }
            temperatures = temp;
          }
        });
      }
    });
    databaseReference.child("heartbeat").onChildChanged.listen((Event event) async {
      if (this.mounted) {
        setState(() {
          int value = event.snapshot.value["value"];
          heart_beats.add(ChartData(heart_beats.length, value));
          List<ChartData> temp = [];
          if (heart_beats.length > 30) {
            for (int i = 1; i < heart_beats.length; i++) {
              temp.add(ChartData(i - 1, heart_beats[i].value));
            }
            heart_beats = temp;
          }
        });
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Welcome to Flutter',
      home: Scaffold(
        body: Center(
          child: _getPage(currentPage),
        ),
        bottomNavigationBar: FancyBottomNavigation(
          tabs: [
            TabData(iconData: Icon(FontAwesomeIcons.th).icon, title: "Home"),
            TabData(
                iconData: Icon(FontAwesomeIcons.heartbeat).icon,
                title: "Heart Beat"),
            TabData(
                iconData: Icon(FontAwesomeIcons.thermometerHalf).icon,
                title: "Temperature")
          ],
          onTabChangedListener: (position) {
            setState(() {
              currentPage = position;
            });
          },
          barBackgroundColor: Colors.red[500],
          activeIconColor: Colors.white,
          inactiveIconColor: Colors.white,
          circleColor: Colors.red[700],
          textColor: Colors.white,
        ),
      ),
    );
  }

  _getPage(int page) {
    switch (page) {
      case 0:
        return Dashboard(temperatures, heart_beats);
      case 1:
        return HeartBeat(heart_beats);
      case 2:
        return BodyTemperature(temperatures);
    }
  }
}
