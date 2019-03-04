import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
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
  DateModel dateModel = new DateModel(DateTime.now(), []);

  @override
  Widget build(BuildContext context) {
    var day =
        DateTime(dateModel.date.year, dateModel.date.month, dateModel.date.day);
    var dayAfter = day.add(Duration(days: 1));
    Firestore.instance
        .collection("reservations")
        .where("date", isGreaterThanOrEqualTo: day, isLessThan: dayAfter)
        .getDocuments()
        .then((documents) {
      List<DateTime> reservations =
          documents.documents.map((d) => d["date"] as DateTime).toList();
      print("Found ${documents.documents.length} reservations for ${day.day}");
      dateModel.setReservations(reservations);
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
      var reservationEnd = reservation.add(Duration(minutes: 30));
      var ui = Card(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: new Text(
          "${formatter.format(reservation)} - ${formatter.format(reservationEnd)}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.black87),
        ),
      ));
      reservationsUi.add(ui);
    }
    return ListView(
      children: reservationsUi,
      shrinkWrap: true,
    );
  }

  _reserve() {
    var now = TimeOfDay.now();
    showTimePicker(context: context, initialTime: now).then((time) {
      if (time != null) {
        var date = dateModel.date;
        date = new DateTime(
            date.year, date.month, date.day, time.hour, time.minute);
        var conflictingDate = dateModel.reservations
            .firstWhere((d) => date.difference(d).inMinutes <= 30, orElse: () => null);
        if (conflictingDate != null) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Time selected is already reserved")));
          return;
        }

        Toast.show("Adding reservation...", context, duration: Toast.LENGTH_SHORT, gravity:  Toast.BOTTOM);
        Firestore.instance
            .collection("reservations")
            .add({"date": date}).then((doc) {
          Scaffold.of(context).showSnackBar(
              SnackBar(content: Text("Reservation successfully added")));
          setState(() {});
        });
      }
    });
  }
}

class DateModel extends Model {
  DateTime date;
  List<DateTime> reservations;
  bool reservationsLoaded = false;

  DateModel(this.date, this.reservations);

  void setDate(DateTime date) {
    this.date = date;
    this.reservations = [];
    this.reservationsLoaded = false;
    notifyListeners();
  }

  void setReservations(List<DateTime> reservations) {
    this.reservations = reservations;
    this.reservationsLoaded = true;
    notifyListeners();
  }
}
