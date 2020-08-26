import 'package:corona_app/src/providers/user_provider.dart';
import 'package:corona_app/src/screens/info_screen.dart';
import 'package:corona_app/src/screens/information_screen.dart';
import 'package:corona_app/src/screens/search_screen.dart';
import 'package:corona_app/src/style/theme.dart' as Theme;
import 'package:corona_app/src/widgets/bottomNavBarPages/home_body.dart';
import 'package:corona_app/src/widgets/bottomNavBarPages/info_body.dart';
import 'package:corona_app/src/widgets/bottomNavBarPages/news_body.dart';
import 'package:corona_app/src/widgets/bottomNavBarPages/tasks_body.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

//TODO: percentages

class MainScreen extends StatefulWidget {
  static final String routeName = "/main-screen";
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  int _currentIndex;

  final List<Widget> _children = [
    HomeBody(),
    TasksBody(),
    NewsBody(),
    InfoBody(),
  ];
  @override
  void initState() {
    _currentIndex = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
        future: Provider.of<User>(context).fetchUser(),
        builder: (context, snapshot) {
          return Scaffold(
            key: _scaffoldKey,
            drawer: Drawer(
              child: ListView(
                children: [
                  DrawerHeader(
                    child: Image.asset(
                      "assets/images/header.png",
                      fit: BoxFit.fill,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                    ),
                  ),
                  ListTile(
                    title: Text("Home"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, MainScreen.routeName);
                    },
                  ),
                  ListTile(
                    title: Text("About Us"),
                    onTap: () {
                      Navigator.popAndPushNamed(
                          context, DeveloperInfoScreen.routeName);
                    },
                  ),
                  ListTile(
                    title: Text("Instructions"),
                    onTap: () {
                      Navigator.popAndPushNamed(
                          context, InformationScreen.routeName);
                    },
                  ),
                ],
              ),
            ),
            extendBodyBehindAppBar: true,
            extendBody: true,
            appBar: _currentIndex == 0
                ? AppBar(
                    elevation: 0.0,
                    backgroundColor: Colors.transparent,
                    leading: IconButton(
                      padding: EdgeInsets.only(left: 20.0),
                      icon: Icon(
                        FontAwesomeIcons.bars,
                        color: Colors.white,
                      ),
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      onPressed: () {
                        _scaffoldKey.currentState.openDrawer();
                      },
                    ),
                    actions: [
                      IconButton(
                        padding: EdgeInsets.only(right: 20.0),
                        icon: Icon(
                          FontAwesomeIcons.search,
                          color: Colors.white,
                        ),
                        highlightColor: Colors.transparent,
                        splashColor: Colors.transparent,
                        onPressed: () {
                          Navigator.pushNamed(context, SearchScreen.routeName);
                        },
                      ),
                    ],
                  )
                : null,
            body: _children[_currentIndex],
            bottomNavigationBar: FloatingNavbar(
              onTap: (int val) {
                setState(() {
                  _currentIndex = val;
                });
              },
              currentIndex: _currentIndex,
              backgroundColor: Colors.transparent,
              unselectedItemColor: Colors.black,
              selectedItemColor: Theme.Colors.loginGradientStart,
              selectedBackgroundColor: Colors.transparent,
              borderRadius: 40,
              items: [
                FloatingNavbarItem(
                    icon: FontAwesomeIcons.chartPie, title: "Stats"),
                FloatingNavbarItem(
                    icon: FontAwesomeIcons.check, title: "Tasks"),
                FloatingNavbarItem(
                    icon: FontAwesomeIcons.newspaper, title: "News"),
                FloatingNavbarItem(
                    icon: FontAwesomeIcons.infoCircle, title: "Info"),
              ],
            ),
          );
        });
  }
}
