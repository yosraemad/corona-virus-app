import 'package:corona_app/src/screens/main_screen.dart';
import 'package:corona_app/src/style/theme.dart' as Theme;
import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  static final routeName = "/information-screen";
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> {
  List<Widget> slides = items
      .map((item) => Container(
          padding: EdgeInsets.symmetric(horizontal: 18.0),
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Image.asset(
                  item['image'],
                  fit: BoxFit.fitWidth,
                  width: 200.0,
                  alignment: Alignment.bottomCenter,
                ),
              ),
              Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    children: <Widget>[
                      Text(
                        item['header'],
                        style: TextStyle(
                          fontSize: 40.0,
                          fontWeight: FontWeight.w300,
                          color: Color(0XFF3F3D56),
                          height: 1.2,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        item['description'],
                        style: TextStyle(
                            color: Colors.grey,
                            letterSpacing: 1.2,
                            fontSize: 16.0,
                            height: 1.3),
                        textAlign: TextAlign.center,
                      )
                    ],
                  ),
                ),
              )
            ],
          )))
      .toList();
  List<Widget> indicator() => List<Widget>.generate(slides.length, (index) {
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 3.0),
          height: 10.0,
          width: 10.0,
          decoration: BoxDecoration(
              color: _currentPage.round() == index
                  ? Theme.Colors.loginGradientEnd
                  : Theme.Colors.loginGradientEnd.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10.0)),
        );
      });

  double _currentPage = 0.0;
  final _pageViewController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageViewController,
              itemCount: slides.length,
              itemBuilder: (BuildContext context, int index) {
                _pageViewController.addListener(() {
                  setState(() {
                    _currentPage = _pageViewController.page;
                  });
                });
                return slides[index];
              },
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin: EdgeInsets.only(top: 70.0),
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: indicator(),
                      ),
                      Padding(
                        padding: EdgeInsets.all(4.0),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.popAndPushNamed(
                              context, MainScreen.routeName);
                        },
                        child: Card(
                          child: Container(
                            height: 20.0,
                            width: 60.0,
                            color: Theme.Colors.loginGradientStart,
                            child: Center(
                              child: Text(
                                "Finish",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

List items = [
  {
    "header": "Avoid Close Contact",
    "description":
        "Keep your distance from others to protect them from getting sick too.",
    "image": "assets/images/avoid_close_contact.png",
  },
  {
    "header": "Clean Your Hands Often",
    "description":
        "Wash your hands with soap and water, scrub your hands for at least 20 seconds.",
    "image": "assets/images/clean_your_hands.png",
  },
  {
    "header": "Wear a facemask when you are sick",
    "description":
        " Consider wearing a face mask when you are sick with a cough or sneezing",
    "image": "assets/images/wear_a_facemask.png",
  },
  {
    "header": "Stay at home",
    "description":
        "Staying at home will help control the spread of the virus to friends, the wider community.",
    "image": "assets/images/stay_at_home.png",
  },
];
