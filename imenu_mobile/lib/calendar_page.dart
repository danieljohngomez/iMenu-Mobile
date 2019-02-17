import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;

class CalendarView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CalendarViewState();
  }
}

class CalendarViewState extends State<CalendarView> {
  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              CalendarCarousel(
                onDayPressed: (DateTime date, List<dynamic> u) {
                  this.setState(() => _currentDate = date);
                },
                weekendTextStyle: TextStyle(
                  color: Colors.red,
                ),
                thisMonthDayBorderColor: Colors.grey,
                weekFormat: false,
                height: 420.0,
                selectedDateTime: _currentDate,
                daysHaveCircularBorder: true,
              ),
              SizedBox(height: 20,),
              buildReservations(),
            ],
          ),
        ));
  }
}

Widget buildReservations() {
  return Text("No reservations for this day", style: TextStyle(fontSize: 18),);
}