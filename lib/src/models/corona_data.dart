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

  CoronaData.fromMap(Map<String, dynamic> rawjson) {
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
    if (name == null) {
      name = "Worldwide";
      flag = "https://tinyurl.com/y247s3qa";
    }
  }
}
