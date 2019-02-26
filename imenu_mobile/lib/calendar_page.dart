import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:intl/intl.dart';
import 'package:scoped_model/scoped_model.dart';

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
      floatingActionButton: FloatingActionButton(onPressed: ()=> {},
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
          formatter.format(reservation),
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
