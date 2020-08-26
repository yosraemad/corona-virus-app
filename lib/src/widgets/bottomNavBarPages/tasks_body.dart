import 'package:corona_app/src/models/profile.dart';
import 'package:corona_app/src/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TasksBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User user = Provider.of<User>(context);
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overscroll) {
        overscroll.disallowGlow();
        return null;
      },
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
              ),
              Image(
                image: AssetImage("assets/images/meditation.jpg"),
              ),
              Card(
                elevation: 2,
                child: CheckboxListTile(
                  tristate: false,
                  title: Text("Wash Hands"),
                  value: user.profile.washedHands,
                  onChanged: (value) {
                    user.checkWashedHands();
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Card(
                elevation: 2,
                child: CheckboxListTile(
                  tristate: false,
                  title: Text("Social Distanced"),
                  value: user.profile.socialDistanced,
                  onChanged: (value) {
                    user.checkSocialDistancing();
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Card(
                elevation: 2,
                child: CheckboxListTile(
                  tristate: false,
                  title: Text("Wore a Mask"),
                  value: user.profile.woreMask,
                  onChanged: (value) {
                    user.checkWoreMask();
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(40.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
