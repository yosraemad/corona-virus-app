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
  List<int> last8DaysCases = [];
  List<int> last8DaysDeaths = [];
  List<int> last8DaysRecovered = [];

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
      last8DaysCases.add(lastCases[key]);
    });
    lastDeaths.forEach((key, value) {
      last8DaysDeaths.add(lastDeaths[key]);
    });
    lastRecovered.forEach((key, value) {
      last8DaysRecovered.add(lastRecovered[key]);
    });
  }
}
