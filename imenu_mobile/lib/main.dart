import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:imenu_mobile/calendar_page.dart';
import 'package:imenu_mobile/category.dart';
import 'package:imenu_mobile/info_page.dart';
import 'package:imenu_mobile/login_page.dart';
import 'package:imenu_mobile/today.dart';

void main() async {
  runApp(AppWidget());
}

class AppWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AppState();
  }
}

class AppState extends State<AppWidget> {
  int _selectedPage = 0;

  @override
  void initState() {
    FirebaseAuth.instance.currentUser().then((user) {
      setState(() {
        if (user == null)
          _selectedPage = 1;
        else
          _selectedPage = 2;
      });
    }).catchError((error) => print(error));
  }

  Widget getPage() {
    if (_selectedPage == 0)
      return Container(
          color: Colors.red,
          child: Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
          )));
    if (_selectedPage == 1)
      return Scaffold(body: LoginScreen3());
    else
      return DefaultTabController(
        length: 3,
        initialIndex: 0,
        child: MainPage(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'iMenu',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: getPage(),
    );
  }
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
    DrawerItem("Sign Out", Icon(Icons.close)),
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
          if (i == 3) {
            var app =
                context.rootAncestorStateOfType(new TypeMatcher<AppState>());
            FirebaseAuth.instance.signOut().whenComplete(() {
              app.initState();
            });
            return;
          }
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
