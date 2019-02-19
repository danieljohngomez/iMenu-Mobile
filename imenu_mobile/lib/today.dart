import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

class TodayPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TodayPageState();
  }
}

class TodayPageState extends State<TodayPage> {
  TodayModel todayModel;

  TodayPageState() {
    todayModel = new TodayModel([], "No reservations for today");
    Firestore.instance
        .collection('tables')
        .snapshots()
        .listen((data) => _mapDocuments(data));
  }

  void _mapDocuments(QuerySnapshot data) {
    todayModel.tables = [];
    data.documents.forEach((doc) =>
        todayModel.setTables(data.documents.map((doc) =>
            Table(doc["number"], doc["occupied"])).toList( )));
  }

  @override
  Widget build(BuildContext context) {
    return ScopedModel(model: todayModel, child: TableList());
  }
}

class TableList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<TodayModel>(builder: (context, child, model) {
      List<Widget> children = _buildTables(model);
      children.addAll(_buildReservations(model.reservation));
      return new ListView(padding: EdgeInsets.all(16), children: children);
    });
  }

  List<Widget> _buildTables(TodayModel model) {
    List<Widget> widgets = [
      Text(
        "Tables",
        style: TextStyle(fontSize: 18, color: Colors.black87),
      ),
      new SizedBox(height: 10),
    ];

    widgets.addAll(model.tables.map(
      (table) => Card(
            child: Column(
              children: <Widget>[
                new SizedBox(height: 20),
                new Text(
                  "#${table.number}",
                  style: TextStyle(
                      fontSize: 40,
                      color: (table.occupied) ? Colors.red : Colors.green),
                ),
                new SizedBox(height: 10),
                new Text(
                  (table.occupied) ? "Occupied" : "Vacant",
                  style: TextStyle(
                      fontSize: 18,
                      color: (table.occupied) ? Colors.red : Colors.green),
                ),
                new SizedBox(height: 20)
              ],
            ),
          ),
    ));
    return widgets;
  }

  List<Widget> _buildReservations(String reservation) {
    return [
      new SizedBox(height: 20),
      Text(
        "Reservations",
        style: TextStyle(fontSize: 18, color: Colors.black87),
      ),
      new SizedBox(height: 20),
      Text(
        reservation,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 16, color: Colors.black38),
      )
    ];
  }
}

class TodayModel extends Model {
  List<Table> tables = [];
  String reservation;

  TodayModel(this.tables, this.reservation);

  void setReservation(String reservation) {
    this.reservation = reservation;
    notifyListeners();
  }

  void setTables(List<Table> tables ) {
    this.tables = tables;
    notifyListeners();
  }

  void upsertTable(Table table) {
    if (tables.isEmpty) {
      tables.add(table);
      notifyListeners();
      return;
    }

    var iterator = tables.where((t) => t.number == table.number);
    if (iterator.length <= 0) {
      tables.add(table);
      notifyListeners();
      return;
    }
    iterator.forEach((_t) {
      _t.occupied = table.occupied;
      notifyListeners();
    });
  }
}

class Table {
  int number;
  bool occupied = false;

  Table(int number, bool occupied) {
    this.number = number;
    this.occupied = occupied == null ? false : occupied;
  }

}
