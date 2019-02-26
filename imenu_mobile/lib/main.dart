import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:imenu_mobile/calendar_page.dart';
import 'package:imenu_mobile/category.dart';
import 'package:imenu_mobile/info_page.dart';
import 'package:imenu_mobile/menu_model.dart';
import 'package:imenu_mobile/today.dart';
import 'package:scoped_model/scoped_model.dart';

void main() {
  runApp(MaterialApp(
      title: 'iMenu',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: MainPage(),
      )));
}

class DrawerItem {
  String title;
  Icon icon;

  DrawerItem(this.title, this.icon);
}

class MainPage extends StatefulWidget {
  final drawerItems = [
    DrawerItem("Home", Icon(Icons.home)),
    DrawerItem("Today", Icon(Icons.view_day)),
    DrawerItem("Calendar", Icon(Icons.calendar_today)),
  ];
  final List<Widget> pages = [HomePage(), TodayPage(), CalendarView()];


  @override
  State<StatefulWidget> createState() {
    return MainState();
  }
}

class MainState extends State<MainPage> {
  int _selectedDrawerIndex = 0;

  List<Widget> _buildDrawerChildren() {
    List<Widget> children = [];
    children.add(UserAccountsDrawerHeader(
      accountName: Text("My Restaurant"),
      accountEmail: Text("iMenu"),
    ));
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var drawerItem = widget.drawerItems[i];
      children.add(ListTile(
        title: Text(drawerItem.title),
        leading: drawerItem.icon,
        selected: i == _selectedDrawerIndex,
        onTap: () {
          setState(() {
            _selectedDrawerIndex = i;
            Navigator.pop(context);
          });
        },
      ));
    }
    return children;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: _buildDrawerChildren(),
        ),
      ),
      body: widget.pages[_selectedDrawerIndex],
    );
  }
}

class DrawerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return DrawerState();
  }
}

class DrawerState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            child: Text(
              'iMenu',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            decoration: BoxDecoration(
              color: Colors.redAccent,
            ),
          ),
          ListTile(
            title: Text("Home"),
            onTap: () async {
              Navigator.pop(context);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => HomePage()));
            },
          ),
          ListTile(
            title: Text("Today"),
          ),
          ListTile(
            title: Text("Calendar"),
          ),
        ],
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    print('create');
    return HomePageState([MenuPage(), InfoPage()]);
  }
}

class HomePageState extends State<HomePage> {
  int _selectedTabIndex = 0;

  List<Widget> tabs;

  HomePageState(this.tabs);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedTabIndex,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(kToolbarHeight),
          child: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(text: "Menu"),
                Tab(text: "Info"),
              ],
              onTap: (i) {
                setState(() {
                  _selectedTabIndex = i;
                });
              },
            ),
          ),
        ),
        body: tabs[_selectedTabIndex],
      ),
    );
  }
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
