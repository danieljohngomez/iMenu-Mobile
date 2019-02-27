import 'package:flutter/material.dart';
import 'package:imenu_mobile/custom_icons_icons.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:android_intent/android_intent.dart';
import 'dart:io' show Platform;

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Info info = new Info();
    info.address = "Address Info";
    info.schedule = "Schedule Info";
    info.phone = "123";
    info.facebook = "danieljohnqgomez";
    info.twitter = "danieljohngomez";
    info.mapLatitude = -3.823216;
    info.mapLongitude = -38.481700;
    return Container(padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Align(alignment: Alignment.centerLeft,child: Text("My Restaurant", style: TextStyle( fontSize: 20))),
            SizedBox(height: 20,),
            _buildButtons(info),
            SizedBox(height: 40,),
            Align( alignment: Alignment.centerLeft, child: Text("ADDRESS", style: TextStyle( fontSize: 16, color: Colors.black54))),
            SizedBox(height: 10,),
            Align(alignment: Alignment.centerLeft,child: Text(info.address, style: TextStyle( fontSize: 16, color: Colors.black87))),
            SizedBox(height: 20,),
            Align(alignment: Alignment.centerLeft,child: Text("SCHEDULE", style: TextStyle( fontSize: 16, color: Colors.black54))),
            SizedBox(height: 10,),
            Align(alignment: Alignment.centerLeft,child: Text(info.schedule, style: TextStyle( fontSize: 16, color: Colors.black87))),
          ],
        )
    );
  }

  Widget _buildButtons(Info info) {

    return Row(children: [
      Column(children: [
        FloatingActionButton(onPressed: () => launch("tel://${info.phone}"), child: Icon(Icons.call, size: 30,), elevation: 2,),
        SizedBox(height: 10,),
        Text("Call", style: TextStyle( fontSize: 16))
      ],),
      SizedBox(width: 20,),
      Column(children: [
        FloatingActionButton(onPressed: () => _launchMap(info), child: Icon(Icons.location_on, size: 30,), elevation: 2,),
        SizedBox(height: 10,),
        Text("Map", style: TextStyle( fontSize: 16))
      ],),
      SizedBox(width: 20,),
      Column(children: [
        FloatingActionButton(onPressed: () => _launchFacebook(info), child: Icon(CustomIcons.facebook, size: 30,), elevation: 2,),
        SizedBox(height: 10,),
        Text("Facebook", style: TextStyle( fontSize: 16))
      ],),
      SizedBox(width: 20,),
      Column(children: [
        FloatingActionButton(onPressed: () => _launchTwitter(info), child: Icon(CustomIcons.twitter, size: 30,), elevation: 2,),
        SizedBox(height: 10,),
        Text("Twitter", style: TextStyle( fontSize: 16))
      ],),
    ],);
  }

  Future _launchMap(Info info) async {
    String url = "geo:0,0?q=${info.mapLatitude},${info.mapLongitude}(My+Restaurant)";

    if (Platform.isAndroid) {
      AndroidIntent intent = AndroidIntent(
        action: 'action_view',
        data: url,
        package: "com.google.android.apps.maps",
      );
      await intent.launch();
    }
  }

  void _launchFacebook(Info info) {
    String url = "http://fb.me/${info.facebook}";
    launch(url);
  }

  void _launchTwitter(Info info) {
    String url = "http://twitter.com/${info.twitter}";
    launch(url);
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