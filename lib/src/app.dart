import 'package:corona_app/src/providers/user_provider.dart';
import 'package:corona_app/src/screens/info_screen.dart';
import 'package:corona_app/src/screens/information_screen.dart';
import 'package:corona_app/src/screens/main_screen.dart';
import 'package:corona_app/src/screens/search_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<User>(
      create: (context) => User(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          visualDensity: VisualDensity.compact,
        ),
        title: "Covid19 App",
        home: MainScreen(),
        routes: {
          MainScreen.routeName: (context) => MainScreen(),
          SearchScreen.routeName: (context) => SearchScreen(),
          DeveloperInfoScreen.routeName: (context) => DeveloperInfoScreen(),
          InformationScreen.routeName: (context) => InformationScreen(),
        },
      ),
    );
  }
}
