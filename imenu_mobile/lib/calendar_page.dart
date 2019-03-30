import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:imenu_mobile/reservation_dialog.dart';
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:toast/toast.dart';

class CalendarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarViewState();
  }
}

class CalendarViewState extends State<CalendarView> {
  DateTime currentDateTime = DateTime.now();

  DateModel dateModel = new DateModel(DateTime.now(), []);

  DateTime toDateTime(Timestamp t) {
    return new DateTime.fromMillisecondsSinceEpoch(t.millisecondsSinceEpoch);
  }

  @override
  Widget build(BuildContext context) {
    var day = DateTime(
        dateModel.date.year, dateModel.date.month, dateModel.date.day);
    var dayAfter = day.add(Duration(days: 1));
    Firestore.instance
        .collection("reservations")
        .where("start", isGreaterThanOrEqualTo: day)
        .getDocuments()
        .then((documents) {
      List<ReservationTime> reservations = documents.documents
          .where((d) => toDateTime(d["end"]).isBefore(dayAfter) )
          .map((d) =>
              new ReservationTime(toDateTime(d["start"]), toDateTime(d["end"]), d["table"]))
          .toList();
      print("Found ${documents.documents.length} reservations for ${day.day}");
      dateModel.setReservations(reservations);
    });

    Firestore.instance.collection("tables").getDocuments().then((tableDoc) {
      List<String> tables = tableDoc.documents.map((doc) => "" + doc["name"]).toList();
      dateModel.setTables(tables);
    });

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => _reserve(),
          child: Icon(Icons.add),
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              CalendarCarousel(
                onDayPressed: (DateTime date, List<dynamic> u) {
                  this.setState(() => dateModel.setDate(date));
                },
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
                thisMonthDayBorderColor: Colors.grey,
                weekFormat: false,
                height: 420.0,
                selectedDateTime: dateModel.date,
                daysHaveCircularBorder: true,
              ),
              SizedBox(
                height: 20,
              ),
              ScopedModel<DateModel>(
                  model: dateModel,
                  child: ScopedModelDescendant<DateModel>(
                      builder: (context, child, model) =>
                          _buildReservations(model)))
            ],
          ),
        ));
  }

  Widget _buildReservations(DateModel dateModel) {
    if (!dateModel.reservationsLoaded) return CircularProgressIndicator();
    if (dateModel.reservations.isEmpty && dateModel.reservationsLoaded)
      return Text(
        "No reservations for this day",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black38),
      );
    var formatter = new DateFormat('hh:mm aa');

    List<Widget> reservationsUi = [];
    for (var reservation in dateModel.reservations) {
      var ui = Card(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Text(
          "${formatter.format(reservation.start)} - ${formatter.format(reservation.end)}, Table: ${reservation.table}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ));
      reservationsUi.add(ui);
    }
    return Expanded(
      child: ListView(
        children: reservationsUi,
      ),
    );
  }

  _reserve() {
    showDialog(context: context, builder: (_) => new ReservationDialog(dateModel.tables, dateModel.reservations, () {
      setState(() {

      });
    }));
  }

}

class DateModel extends Model {
  DateTime date;
  List<ReservationTime> reservations;
  bool reservationsLoaded = false;
  bool tablesLoaded = false;
  List<String> tables;

  DateModel(this.date, this.reservations);

  void setDate(DateTime date) {
    this.date = date;
    this.reservations = [];
    this.reservationsLoaded = false;
    notifyListeners();
  }

  void setReservations(List<ReservationTime> reservations) {
    this.reservations = reservations;
    this.reservationsLoaded = true;
    notifyListeners();
  }

  void setTables(List<String> tables) {
    this.tables = tables;
    this.tablesLoaded = true;
  }

}

class ReservationTime {
  DateTime start;
  DateTime end;
  String table;

  ReservationTime(this.start, this.end, this.table);
}
