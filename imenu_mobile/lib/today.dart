import 'package:flutter/material.dart';

class TodayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodayPageState();
  }

}

class TodayPageState extends State<TodayPage> {

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text("Tables", style: TextStyle(fontSize: 18, color: Colors.black87),),
        new SizedBox( height: 10),
        Card(
          child: Column(
            children: <Widget>[
              new SizedBox( height: 20),
              new Text("#16", style: TextStyle(fontSize: 40, color: Colors.green),),
              new SizedBox( height: 10),
              new Text("Vacant", style: TextStyle(fontSize: 18, color: Colors.green),),
              new SizedBox( height: 20)
            ],
          ),
        ),
        Card(
          child: Column(
            children: <Widget>[
              new SizedBox( height: 20),
              new Text("#17", style: TextStyle(fontSize: 40, color: Colors.red),),
              new SizedBox( height: 10),
              new Text("Occuppied", style: TextStyle(fontSize: 18, color: Colors.red),),
              new SizedBox( height: 20)
            ],
          ),
        ),
        new SizedBox( height: 20),
        Text("Reservations", style: TextStyle(fontSize: 18, color: Colors.black87),),
        new SizedBox( height: 20),
        Text("No reservations today", textAlign:TextAlign.center, style: TextStyle(fontSize: 16, color: Colors.black38),),
      ],
    );
  }

}