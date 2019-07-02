import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_database/firebase_database.dart';

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
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    databaseReference.once().then((DataSnapshot snapshot) {
      if (this.mounted) {
        setState(() {
          temperature = snapshot.value["temperature"];
          heart_beat = snapshot.value["heart_beat"];
          loading = 0;
        });
      }
    });
    databaseReference.child("temperature").onValue.listen((Event event) {
      if (this.mounted) {
        setState(() {
          temperature = event.snapshot.value;
        });
      }
    });
    databaseReference.child("heart_beat").onValue.listen((Event event) {
      if (this.mounted) {
        setState(() {
          heart_beat = event.snapshot.value;
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
    return ListView(
      children: <Widget>[
        ListTile(
          leading: Icon(FontAwesomeIcons.heartbeat,
              color: Colors.red[700], size: 35),
          title: Text('Heart Beat'),
          subtitle: Text("$heart_beat/sec"),
        ),
        Divider(
          color: Colors.black38,
          height: 1,
        ),
        ListTile(
          leading: Icon(FontAwesomeIcons.thermometerHalf,
              color: Colors.red[700], size: 35),
          title: Text('Body Temperature'),
          subtitle: Text("$temperature"),
        )
      ],
    );
  }
}
