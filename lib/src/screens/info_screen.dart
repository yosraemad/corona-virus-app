import 'package:corona_app/src/style/theme.dart' as Theme;
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperInfoScreen extends StatelessWidget {
  static final String routeName = "/DeveloperInfoSceen";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Theme.Colors.loginGradientStart,
              Theme.Colors.loginGradientEnd
            ]),
          ),
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(padding: EdgeInsets.all(16)),
              Text(
                "About the developer",
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Text(
                "Hi! I'm Yosra, the girl who developed this app! I'm a ${(DateTime.now().difference(DateTime(2000)).inDays / 365).floor()} year old Computer Engineering student who has a passion in building stuff. I hope you liked this app and found it helpful! more features are coming in soon insha'allah!",
                softWrap: true,
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              Padding(
                padding: EdgeInsets.all(8),
              ),
              Text(
                "Where to find me:",
                style: TextStyle(fontSize: 25.0, color: Colors.white),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      _launchUrl("https://github.com/yosraemad");
                    },
                    icon: Icon(FontAwesomeIcons.github),
                    iconSize: 40,
                    color: Colors.white,
                  ),
                  IconButton(
                    onPressed: () {
                      _launchUrl("https://facebook.com/yosrational");
                    },
                    icon: Icon(FontAwesomeIcons.facebook),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      _launchUrl("https://reddit.com/u/yosrational");
                    },
                    icon: Icon(FontAwesomeIcons.reddit),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                  IconButton(
                    onPressed: () {
                      _launchUrl("https://twitter.com/yosrational");
                    },
                    icon: Icon(FontAwesomeIcons.twitter),
                    color: Colors.white,
                    iconSize: 40,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _launchUrl(String url) async {
    bool _canLaunch = await canLaunch(url);
    if (_canLaunch == true)
      await launch(url);
    else
      throw 'Could not launch $url';
  }
}
