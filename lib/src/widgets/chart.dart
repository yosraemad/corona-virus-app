import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class Chart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;
  Chart(this.seriesList, {this.animate: false});
  @override
  Widget build(BuildContext context) {
    return charts.TimeSeriesChart(
      seriesList,
      animate: animate,
      dateTimeFactory: const charts.LocalDateTimeFactory(),
      primaryMeasureAxis: charts.NumericAxisSpec(
        tickProviderSpec: charts.BasicNumericTickProviderSpec(zeroBound: false),
        renderSpec: charts.NoneRenderSpec(),
      ),
      domainAxis: charts.DateTimeAxisSpec(renderSpec: charts.NoneRenderSpec()),
    );
  }
}
