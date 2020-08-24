import 'package:corona_app/src/screens/info_screen.dart';
import 'package:corona_app/src/style/theme.dart' as Theme;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (notification) {
        notification.disallowGlow();
        return null;
      },
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Text(
                "Symptoms",
                style: TextStyle(
                  fontFamily: "WorkSansBold",
                  fontSize: 20.0,
                ),
              ),
              Container(
                height: 200,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image(
                      image: AssetImage("assets/images/high_fever.png"),
                    ),
                    Image(
                      image: AssetImage("assets/images/cough.png"),
                    ),
                    Image(
                      image: AssetImage("assets/images/sore_throat.png"),
                    ),
                  ],
                ),
              ),
              Text(
                "Prevention",
                style: TextStyle(
                  fontFamily: "WorkSansBold",
                  fontSize: 20.0,
                ),
              ),
              Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Image(
                      image: AssetImage("assets/images/wash_hands.png"),
                    ),
                    Image(
                      image: AssetImage("assets/images/wear_a_mask.png"),
                    ),
                    Image(
                      image: AssetImage("assets/images/avoid_contact.png"),
                    ),
                    Image(
                      image: AssetImage("assets/images/cover_cough.png"),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(40),
              ),
              Card(
                child: ListTile(
                  title: Text(
                    "About the developer",
                    style: TextStyle(
                      fontFamily: "WorkSansBold",
                    ),
                  ),
                  trailing: Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black,
                  ),
                  onTap: () {
                    Navigator.of(context)
                        .pushNamed(DeveloperInfoScreen.routeName);
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.all(30.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
