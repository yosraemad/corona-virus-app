import 'package:corona_app/src/models/profile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User with ChangeNotifier {
  Profile profile;
  Future<SharedPreferences> _preferences = SharedPreferences.getInstance();
  String _formatDateTime(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  Future<void> fetchUser() async {
    SharedPreferences preferences = await _preferences;
    //Comparing last opened with last midnight to set the tasks to false everyday
    String lastOpened =
        preferences.getString('last_opened') ?? _formatDateTime(DateTime.now());
    DateTime now = DateTime.now();
    if (now.difference(DateFormat('dd/MM/yyyy').parse(lastOpened)).inMinutes >
        now.difference(DateTime(now.year, now.month, now.day)).inMinutes) {
      preferences.setBool('social_distanced', false);
      preferences.setBool('washed_hands', false);
      preferences.setBool('wore_mask', false);
      preferences.setString('last_opened', _formatDateTime(DateTime.now()));
    }
    String country = preferences.getString('prefered_country') ?? "Worldwide";
    bool socialDistanced = preferences.getBool('social_distanced') ?? false;
    bool washedHands = preferences.getBool('washed_hands') ?? false;
    bool woreMask = preferences.getBool('wore_mask') ?? false;
    profile = Profile(
      preferredCountry: country,
      socialDistanced: socialDistanced,
      washedHands: washedHands,
      woreMask: woreMask,
    );
  }

  void changeCountry(String country) async {
    profile.preferredCountry = country;
    notifyListeners();
    SharedPreferences preferences = await _preferences;
    preferences.setString('prefered_country', country);
  }

  void checkSocialDistancing() async {
    profile.socialDistanced = !profile.socialDistanced;
    notifyListeners();
    SharedPreferences preferences = await _preferences;
    preferences.setBool('social_distanced', profile.socialDistanced);
  }

  void checkWashedHands() async {
    profile.washedHands = !profile.washedHands;
    notifyListeners();
    SharedPreferences preferences = await _preferences;
    preferences.setBool('washed_hands', profile.washedHands);
  }

  void checkWoreMask() async {
    profile.woreMask = !profile.woreMask;
    notifyListeners();
    SharedPreferences preferences = await _preferences;
    preferences.setBool('wore_mask', profile.woreMask);
  }
}
