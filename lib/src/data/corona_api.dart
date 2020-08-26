import 'package:corona_app/src/models/corona_data.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

final String apiUrl = "https://disease.sh/v3/covid-19";

Future<CoronaData> fetchData(String country) async {
  http.Response response;
  http.Response last8DaysResponse;
  Map<String, dynamic> last8Days;
  if (country == "Worldwide") {
    response = await http.get(apiUrl + "/all?allowNull=true");
    last8DaysResponse = await http.get(apiUrl + "/historical/all?lastdays=4");
    last8Days = json.decode(last8DaysResponse.body);
  } else {
    response = await http.get(apiUrl + "/countries/$country");
    last8DaysResponse =
        await http.get(apiUrl + "/historical/$country?lastdays=4");
    last8Days = json.decode(last8DaysResponse.body)["timeline"];
  }
  return CoronaData.fromMap(json.decode(response.body), last8Days);
}
