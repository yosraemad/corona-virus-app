import 'package:corona_app/src/data/corona_api.dart';
import 'package:corona_app/src/models/chart_model.dart';
import 'package:corona_app/src/models/corona_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Testing Last 8 days data for Worldwide", () async {
    CoronaData data = await fetchData("Worldwide");
    print(data.last8DaysCases[0].date);
    expect(data.last8DaysCases is List<ChartsModel>, true);
  });
  test("Testing Last 8 days data for a Country", () async {
    CoronaData data = await fetchData("USA");
    print(data.last8DaysCases[0].date);
    expect(data.last8DaysCases is List<ChartsModel>, true);
  });
}
