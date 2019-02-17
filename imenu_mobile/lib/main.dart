import 'package:flutter/material.dart';
import 'package:imenu_mobile/calendar_page.dart';
import 'package:imenu_mobile/category.dart';
import 'package:imenu_mobile/menu_model.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MaterialApp(
    title: 'iMenu',
    theme: ThemeData(
      primarySwatch: Colors.red,
    ),
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  final menu = MenuModel(menu: [
    MenuItemModel("Appetizer", categories: [
      Category("Appetizer Category 1", items: [
        CategoryItem("Appetizer 1", "", 90.0),
        CategoryItem("Appetizer 2", "", 90.0),
        CategoryItem("Appetizer 3", "", 90.0),
      ]),
      Category("Appetizer Category 2", items: [
        CategoryItem("Appetizer 4", "", 90.0),
        CategoryItem("Appetizer 5", "", 90.0),
        CategoryItem("Appetizer 6", "", 90.0),
      ]),
      Category("Appetizer Category 3", items: [
        CategoryItem("Appetizer 7", "", 90.0),
        CategoryItem("Appetizer 8", "", 90.0),
        CategoryItem("Appetizer 9", "", 90.0),
      ]),
    ]),
    MenuItemModel("Main Course", categories: [
      Category("Main Course 1", items: [
        CategoryItem("Main Course 1", "", 90.0),
        CategoryItem("Main Course 2", "", 90.0),
        CategoryItem("Main Course 3", "", 90.0),
      ]),
      Category("Main Course 2", items: [
        CategoryItem("Main Course 4", "", 90.0),
        CategoryItem("Main Course 5", "", 90.0),
        CategoryItem("Main Course 6", "", 90.0),
      ]),
      Category("Main Course 3", items: [
        CategoryItem("Main Course 7", "", 90.0),
        CategoryItem("Main Course 8", "", 90.0),
        CategoryItem("Main Course 9", "", 90.0),
      ]),
    ]),
    MenuItemModel("Dessert", categories: [
      Category("Dessert 1"),
      Category("Dessert 2"),
      Category("Dessert 3"),
    ]),
    MenuItemModel("Beverages", categories: [
      Category("Beverage 1"),
      Category("Beverage 2"),
      Category("Beverage 3"),
    ]),
  ]);

  @override
  Widget build(BuildContext context) {
    return ScopedModel<MenuModel>(
      model: menu,
      child: DefaultTabController(
          length: menu.items.length,
          initialIndex: menu.getSelectedIndex(),
          child: Scaffold(
              appBar: AppBar(
                title: Text('iMenu'),
                actions: [
                  IconButton(
                    icon: Icon(Icons.calendar_today),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CalendarView(), fullscreenDialog: true),
                      );
                    },
                  )
                ],
                bottom: TabBar(
                  tabs: buildTabs(menu),
                  onTap: (i) {
                    setState(() {
                      menu.setSelected(i);
                    });
                  },
                ),
              ),
              body: ScopedModel(model: menu, child: CategoryList()))),
    );
  }
}

List<Tab> buildTabs(MenuModel menu) {
  return menu.items.map((menuItem) => Tab(text: menuItem.name)).toList();
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        bottom: TabBar(
          tabs: const [
            Tab(text: "Main Course"),
            Tab(text: "Beverages"),
            Tab(text: "Desserts"),
          ],
          controller: DefaultTabController.of(context),
        ),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
