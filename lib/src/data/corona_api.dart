import 'package:corona_app/src/models/corona_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String apiUrl = "https://disease.sh/v3/covid-19";

Future<CoronaData> fetchData(String country) async {
  http.Response response;
  if (country == "Worldwide")
    response = await http.get(apiUrl + "/all?allowNull=true");
  else
    response = await http.get(apiUrl + "/countries/$country");
  return CoronaData.fromMap(json.decode(response.body));
}
