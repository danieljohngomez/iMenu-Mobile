import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imenu_mobile/calendar_page.dart';
import 'package:intl/intl.dart';
import 'package:toast/toast.dart';

class ReservationDialog extends SimpleDialog {

  ReservationDialog(
      List<String> tables, List<ReservationTime> currentReservations, VoidCallback onReserve)
      : super(
            title: new Text("Reservation"),
            children: [ReservationWidget(tables, currentReservations, onReserve)]);
}

class ReservationWidget extends StatefulWidget {
  final List<String> tables;
  final List<ReservationTime> currentReservations;
  final VoidCallback onReserve;

  ReservationWidget(this.tables, this.currentReservations, this.onReserve);

  @override
  State<StatefulWidget> createState() {
    return ReservationState();
  }
}

class ReservationState extends State<ReservationWidget> {
  List<String> tables;
  List<ReservationTime> currentReservations;

  var formatter = new DateFormat('hh:mm aa');

  DateTime start;
  DateTime end;
  String selectedTable;

  @override
  void initState() {
    this.tables = widget.tables;
    this.currentReservations = widget.currentReservations;
    if (this.tables == null || this.tables.isEmpty) {
      this.tables = [''];
    }
    this.selectedTable = this.tables[0];
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 26.0, right: 26, top: 12, bottom: 12),
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: new Text(
                start == null ? "Select Start Time" : formatter.format(start)),
            onPressed: () => timePicker(true),
          ),
          RaisedButton(
            child: new Text(
                end == null ? "Select End Time" : formatter.format(end)),
            onPressed: () => timePicker(false),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: new Text("Table"),
          ),
          DropdownButton<String>(
            isExpanded: true,
            value: selectedTable,
            onChanged: (newVal) => {
                  setState(() {
                    selectedTable = newVal;
                  })
                },
            items: tables
                .map((s) => DropdownMenuItem(value: s, child: new Text(s)))
                .toList(),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new SimpleDialogOption(
                  child: Text("Close"),
                  onPressed: () => {Navigator.pop(context)},
                ),
                new SimpleDialogOption(
                    child: Text("Reserve"), onPressed: () => reserve()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void timePicker(bool start) {
    showTimePicker(context: context, initialTime: TimeOfDay.now())
        .then((value) {
      if (value == null) return;

      var date = start ? this.start : this.end;
      if (date == null) date = DateTime.now();

      date = new DateTime(
          date.year, date.month, date.day, value.hour, value.minute);

      setState(() {
        if (start)
          this.start = date;
        else
          this.end = date;
      });
    });
  }

  void reserve() {
    // Validate empty fields
    if (start == null || end == null || selectedTable.isEmpty) {
      showDialog(
          context: context,
          builder: (_) =>
              new AlertDialog(content: new Text("Please fill up all fields")));
      return;
    }

    // Check conflicting reservations
    var conflictingDate = currentReservations
        .where((d) => d.table == selectedTable)
        .firstWhere((d) => !(start.isAfter(d.end) || end.isBefore(d.start)),
            orElse: () => null);
    if (conflictingDate != null) {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
              content:
                  new Text("Time selected is already reserved for the table")));
      return;
    }

    FirebaseAuth.instance.currentUser().then((user){
      Firestore.instance
          .collection("reservations")
          .add({"start": start, "end": end, "table": selectedTable, "customer": user.displayName}).then((doc) {
        Toast.show("Reservation successfully added", context,
            duration: Toast.LENGTH_SHORT, gravity: Toast.BOTTOM);
        Navigator.pop(context);
        widget.onReserve();
      });
    });
  }
}
