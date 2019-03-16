import 'dart:io' show Platform;

import 'package:android_intent/android_intent.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imenu_mobile/custom_icons_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return new InfoPageState();
  }

}

class InfoPageState extends State<InfoPage> {

  Info info;

  @override
  void initState() {
    Firestore.instance.document("restaurant/info").get().then((doc) {
      setState(() {
        info = new Info();
        info.address = doc["address"];
        info.schedule = doc["schedule"];
        info.phone = doc["phone"];
        info.facebook = doc["facebook"];
        info.twitter = doc["twitter"];
        info.mapLatitude = doc["location"].latitude;
        info.mapLongitude = doc["location"].longitude;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (info == null)
      return Center(child: CircularProgressIndicator());

    return Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Text("My Restaurant", style: TextStyle(fontSize: 20))),
            SizedBox(
              height: 20,
            ),
            _buildButtons(info),
            SizedBox(
              height: 40,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("ADDRESS",
                    style: TextStyle(fontSize: 16, color: Colors.black54))),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(info.address,
                    style: TextStyle(fontSize: 16, color: Colors.black87))),
            SizedBox(
              height: 20,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text("SCHEDULE",
                    style: TextStyle(fontSize: 16, color: Colors.black54))),
            SizedBox(
              height: 10,
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text(info.schedule,
                    style: TextStyle(fontSize: 16, color: Colors.black87))),
          ],
        ));
  }


  Widget _buildButtons(Info info) {
    return Row(
      children: [
        Column(
          children: [
            FloatingActionButton(
              onPressed: () => launch("tel://${info.phone}"),
              child: Icon(
                Icons.call,
                size: 30,
              ),
              elevation: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Call", style: TextStyle(fontSize: 16))
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            FloatingActionButton(
              onPressed: () => _launchMap(info),
              child: Icon(
                Icons.location_on,
                size: 30,
              ),
              elevation: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Map", style: TextStyle(fontSize: 16))
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            FloatingActionButton(
              onPressed: () => launch(info.facebook),
              child: Icon(
                CustomIcons.facebook,
                size: 30,
              ),
              elevation: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Facebook", style: TextStyle(fontSize: 16))
          ],
        ),
        SizedBox(
          width: 20,
        ),
        Column(
          children: [
            FloatingActionButton(
              onPressed: () => launch(info.twitter),
              child: Icon(
                CustomIcons.twitter,
                size: 30,
              ),
              elevation: 2,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Twitter", style: TextStyle(fontSize: 16))
          ],
        ),
      ],
    );
  }

  Future _launchMap(Info info) async {
    String url =
        "geo:0,0?q=${info.mapLatitude},${info.mapLongitude}(My+Restaurant)";

    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: url,
        package: "com.google.android.apps.maps",
      );
      await intent.launch();
    }
  }

}

class Info {
  String address;
  String schedule;
  String phone;
  double mapLongitude;
  double mapLatitude;
  String facebook;
  String twitter;
}
