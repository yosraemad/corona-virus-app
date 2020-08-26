import 'package:corona_app/src/models/chart_model.dart';
import 'package:intl/intl.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CoronaData {
  String name;
  String flag;
  int cases;
  int todayCases;
  int deaths;
  int todayDeaths;
  int recovered;
  int todayRecovered;
  int active;
  int critical;
  List<ChartsModel> last8DaysCases = [];
  List<ChartsModel> last8DaysDeaths = [];
  List<ChartsModel> last8DaysRecovered = [];

  CoronaData.fromMap(
      Map<String, dynamic> rawjson, Map<String, dynamic> last8Days) {
    name = rawjson["country"] == null ? "Worldwide" : rawjson["country"];
    flag = rawjson["countryInfo"] == null
        ? "https://tinyurl.com/y247s3qa"
        : rawjson["countryInfo"]["flag"];
    cases = rawjson["cases"];
    todayCases = rawjson["todayCases"];
    deaths = rawjson["deaths"];
    todayDeaths = rawjson["todayDeaths"];
    recovered = rawjson["recovered"];
    todayRecovered = rawjson["todayRecovered"];
    active = rawjson["active"];
    critical = rawjson["critical"];
    Map<String, dynamic> lastCases = last8Days["cases"];
    Map<String, dynamic> lastDeaths = last8Days["deaths"];
    Map<String, dynamic> lastRecovered = last8Days["recovered"];
    lastCases.forEach((key, value) {
      last8DaysCases
          .add(ChartsModel(DateFormat("M/d/yy").parse(key), lastCases[key]));
    });
    lastDeaths.forEach((key, value) {
      last8DaysDeaths
          .add(ChartsModel(DateFormat("M/d/yy").parse(key), lastDeaths[key]));
    });
    lastRecovered.forEach((key, value) {
      last8DaysRecovered.add(
          ChartsModel(DateFormat("M/d/yy").parse(key), lastRecovered[key]));
    });
  }

  List<charts.Series<dynamic, DateTime>> createCasesChartSeries() {
    return [
      charts.Series<ChartsModel, DateTime>(
        id: "Cases",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (chart, _) => chart.date,
        measureFn: (chart, _) => chart.value,
        data: last8DaysCases,
      )
    ];
  }

  List<charts.Series<dynamic, DateTime>> createDeathsChartSeries() {
    return [
      charts.Series<ChartsModel, DateTime>(
        id: "Deaths",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (chart, _) => chart.date,
        measureFn: (chart, _) => chart.value,
        data: last8DaysDeaths,
      )
    ];
  }

  List<charts.Series<dynamic, DateTime>> createRecoveredChartSeries() {
    return [
      charts.Series<ChartsModel, DateTime>(
        id: "Recovered",
        colorFn: (_, __) => charts.MaterialPalette.red.shadeDefault,
        domainFn: (chart, _) => chart.date,
        measureFn: (chart, _) => chart.value,
        data: last8DaysRecovered,
      )
    ];
  }

  String get recoveredPercentage {
    return (last8DaysRecovered[last8DaysRecovered.length - 1].value /
                last8DaysRecovered[last8DaysRecovered.length - 2].value *
                100 -
            100)
        .toStringAsFixed(2);
  }

  String get deathPercentage {
    return (last8DaysDeaths[last8DaysDeaths.length - 1].value /
                last8DaysDeaths[last8DaysDeaths.length - 2].value *
                100 -
            100)
        .toStringAsFixed(2);
  }

  String get casesPercentage {
    return (last8DaysCases[last8DaysCases.length - 1].value /
                last8DaysCases[last8DaysCases.length - 2].value *
                100 -
            100)
        .toStringAsFixed(2);
  }
}
