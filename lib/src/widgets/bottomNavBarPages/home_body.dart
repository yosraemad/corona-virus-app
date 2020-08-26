import 'dart:async';

import 'package:corona_app/src/data/corona_api.dart';
import 'package:corona_app/src/models/corona_data.dart';
import 'package:corona_app/src/models/profile.dart';
import 'package:corona_app/src/providers/user_provider.dart';
import 'package:corona_app/src/widgets/chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../style/theme.dart' as Theme;

// ignore: must_be_immutable
class HomeBody extends StatefulWidget {
  @override
  _HomeBodyState createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  CoronaData data;

  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  @override
  Widget build(BuildContext context) {
    Profile profile = Provider.of<User>(context).profile;
    if (profile == null)
      Timer(Duration(seconds: 1), () {
        setState(() {});
      });
    return FutureBuilder<CoronaData>(
      future: fetchData(Provider.of<User>(context).profile == null
          ? "Worldwide"
          : Provider.of<User>(context).profile.preferredCountry),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          data = snapshot.data;
          return NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (overscroll) {
              overscroll.disallowGlow();
              return null;
            },
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height >= 670.0
                    ? MediaQuery.of(context).size.height
                    : 670.0,
                color: Color(0xFFF8F8FF),
                child: _buildHeader(),
              ),
            ),
          );
        } else {
          return Center(
            child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation(Theme.Colors.loginGradientStart),
            ),
          );
        }
      },
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 378.0,
      width: double.infinity,
      child: Stack(
        overflow: Overflow.visible,
        alignment: Alignment.topCenter,
        children: [
          Container(
            height: 250.0,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Theme.Colors.loginGradientStart,
                  Theme.Colors.loginGradientEnd,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.0, 2.0],
                tileMode: TileMode.clamp,
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: const Radius.circular(100.0),
                bottomRight: const Radius.circular(100.0),
              ),
            ),
          ),
          Transform.translate(
            offset: const Offset(-120.0, 150.0),
            child: Image(
              width: 45,
              height: 45,
              image: AssetImage("assets/images/corona_image.png"),
            ),
          ),
          Transform.translate(
            offset: const Offset(30.0, 100.0),
            child: Image(
              width: 50,
              height: 50,
              image: AssetImage("assets/images/corona_image.png"),
            ),
          ),
          Transform.translate(
            offset: const Offset(-80.0, 50.0),
            child: Image(
              width: 120,
              height: 240,
              image: AssetImage("assets/images/coughing_man.png"),
            ),
          ),
          _covidCasesText(),
          _covidDataCards(),
        ],
      ),
    );
  }

  Widget _covidCasesText() {
    return Transform.translate(
      offset: const Offset(80.0, 110.0),
      child: Container(
        width: 180.0,
        height: double.infinity,
        child: Align(
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                "${data.name} Cases",
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "WorkSansBold",
                  fontSize: 20,
                ),
              ),
              Text(
                _formatDateTime(DateTime.now()),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "WorkSansMedium",
                  fontSize: 15,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(3),
              ),
              Text(
                data.cases.toString().replaceAllMapped(
                    RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                    (match) => '${match[1]},'),
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: "WorkSansBold",
                  fontSize: 32.5,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _covidDataCards() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Transform.translate(
        offset: Offset(0.0, 205.0),
        child: Column(
          children: [
            Card(
              elevation: 3,
              color: Colors.white,
              child: Container(
                width: 287.5,
                height: 112.5,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "CLOSED CASES",
                            style: TextStyle(
                              color: Theme.Colors.loginGradientEnd,
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 12.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7.5),
                            child: Text(
                              data.recovered.toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (match) => '${match[1]},'),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansBold",
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Transform.translate(
                              offset: const Offset(-10, -10),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2.0),
                                child: SizedBox(
                                  width: 130,
                                  height: 37.5,
                                  child:
                                      Chart(data.createRecoveredChartSeries()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.arrowDown,
                                color: Colors.green,
                                size: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "+" +
                                        data.todayRecovered
                                            .toString()
                                            .replaceAllMapped(
                                                RegExp(
                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                (match) => '${match[1]},'),
                                    style: TextStyle(
                                      fontFamily: "WorkSansMedium",
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    "Recovered",
                                    style: TextStyle(
                                      fontFamily: "WorkSansThin",
                                      fontSize: 10.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.arrowUp,
                                color: Colors.red,
                                size: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              Column(
                                children: [
                                  Text(
                                    data.recoveredPercentage + "%",
                                    style: TextStyle(
                                      fontFamily: "WorkSansMedium",
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    "Deaths",
                                    style: TextStyle(
                                      fontFamily: "WorkSansThin",
                                      fontSize: 10.0,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 3,
              color: Colors.white,
              child: Container(
                width: 287.5,
                height: 112.5,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "DEATHS",
                            style: TextStyle(
                              color: Theme.Colors.loginGradientEnd,
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 12.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7.5),
                            child: Text(
                              data.deaths.toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (match) => '${match[1]},'),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansBold",
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Transform.translate(
                              offset: const Offset(-10, -10),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2.0),
                                child: SizedBox(
                                  width: 130,
                                  height: 37.5,
                                  child: Chart(data.createDeathsChartSeries()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.arrowDown,
                                color: Colors.green,
                                size: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              Column(
                                children: [
                                  Text(
                                    data.deathPercentage + "%",
                                    style: TextStyle(
                                      fontFamily: "WorkSansMedium",
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    "Mild Condition",
                                    style: TextStyle(
                                      fontFamily: "WorkSansThin",
                                      fontSize: 10.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.arrowUp,
                                color: Colors.red,
                                size: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "+" +
                                        data.todayDeaths
                                            .toString()
                                            .replaceAllMapped(
                                                RegExp(
                                                    r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                                (match) => '${match[1]},'),
                                    style: TextStyle(
                                      fontFamily: "WorkSansMedium",
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    "Critical",
                                    style: TextStyle(
                                      fontFamily: "WorkSansThin",
                                      fontSize: 10.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 3,
              color: Colors.white,
              child: Container(
                width: 287.5,
                height: 112.5,
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ACTIVE CASES",
                            style: TextStyle(
                              color: Theme.Colors.loginGradientEnd,
                              fontFamily: "WorkSansSemiBold",
                              fontSize: 12.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 7.5),
                            child: Text(
                              data.active.toString().replaceAllMapped(
                                  RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                  (match) => '${match[1]},'),
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "WorkSansBold",
                                fontSize: 25,
                              ),
                            ),
                          ),
                          Transform.scale(
                            scale: 1.2,
                            child: Transform.translate(
                              offset: const Offset(-10, -10),
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 2.0),
                                child: SizedBox(
                                  width: 130,
                                  height: 37.5,
                                  child: Chart(data.createCasesChartSeries()),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, top: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.arrowDown,
                                color: Colors.green,
                                size: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              Column(
                                children: [
                                  Text(
                                    data.casesPercentage + "%",
                                    style: TextStyle(
                                      fontFamily: "WorkSansMedium",
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    "Mild Condition",
                                    style: TextStyle(
                                      fontFamily: "WorkSansThin",
                                      fontSize: 10.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 12.5),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                FontAwesomeIcons.arrowUp,
                                color: Colors.red,
                                size: 15,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 10.0),
                              ),
                              Column(
                                children: [
                                  Text(
                                    "+" +
                                        data.todayCases.toString().replaceAllMapped(
                                            RegExp(
                                                r'(\d{1,3})(?=(\d{3})+(?!\d))'),
                                            (match) => '${match[1]},'),
                                    style: TextStyle(
                                      fontFamily: "WorkSansMedium",
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  Text(
                                    "Critical",
                                    style: TextStyle(
                                      fontFamily: "WorkSansThin",
                                      fontSize: 10.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
