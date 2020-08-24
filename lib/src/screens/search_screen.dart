import 'package:corona_app/src/providers/user_provider.dart';
import 'package:corona_app/src/screens/info_screen.dart';
import 'package:corona_app/src/screens/main_screen.dart';
import 'package:corona_app/src/style/theme.dart' as Theme;
import 'package:flutter/material.dart';
import 'package:ola_like_country_picker/ola_like_country_picker.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static final routeName = "/search-screen";

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Map<String, String>> _searchResult = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.Colors.loginGradientStart,
        title: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white),
            color: Colors.white,
          ),
          child: TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            onChanged: onSearchTextChanged,
          ),
        ),
      ),
      body: CountryListView(
        showDialCode: false,
        onSelected: (country) {
          Provider.of<User>(context, listen: false).changeCountry(country.name);
          Navigator.pop(context);
        },
        countryJsonList: _searchResult.isEmpty ? countryCodes : _searchResult,
      ),
      bottomNavigationBar: GestureDetector(
        onTap: () {
          Provider.of<User>(context, listen: false).changeCountry("Worldwide");
          Navigator.pop(context);
        },
        child: Container(
          height: 50.0,
          color: Theme.Colors.loginGradientEnd,
          child: Center(
            child: Text(
              "See Worldwide cases",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onSearchTextChanged(String value) {
    _searchResult.clear();
    if (value.isEmpty) {
      setState(() {});
      return;
    }
    countryCodes.forEach((element) {
      if (element["Name"].toLowerCase().contains(value.toLowerCase()))
        setState(() {
          _searchResult.add(element);
        });
    });
  }
}
