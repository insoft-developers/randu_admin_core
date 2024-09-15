import 'dart:math' as math;
import 'package:buzz/appstaticdata/staticdata.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUtils {
  factory AppUtils() {
    return _singleton;
  }

  AppUtils._internal();
  static final AppUtils _singleton = AppUtils._internal();

  double degreeToRadian(double degree) {
    return degree * math.pi / 180;
  }

  double radianToDegree(double radian) {
    return radian * 180 / math.pi;
  }

  Future<bool> tryToLaunchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      return await launchUrl(uri);
    }
    return false;
  }
}

TableRow chart1221() {
  return TableRow(
    children: [
      SizedBox(
        height: 270,
        child: SfCartesianChart(
            primaryXAxis: const DateTimeAxis(),
            series: <CartesianSeries>[
              LineSeries<SalesData, DateTime>(
                  color: appMainColor,
                  dataSource: chartData1,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales),
              LineSeries<SalesData, DateTime>(
                  color: const Color(0xffF86624),
                  dataSource: chartData2,
                  xValueMapper: (SalesData sales, _) => sales.year,
                  yValueMapper: (SalesData sales, _) => sales.sales),
            ]),
      ),
    ],
  );
}

class SalesData {
  SalesData(this.year, this.sales);
  final DateTime year;
  final double sales;
}

final List<SalesData> chartData1 = [
  SalesData(DateTime(2010), 25),
  SalesData(DateTime(2011), 20),
  SalesData(DateTime(2012), 34),
  SalesData(DateTime(2013), 32),
  SalesData(DateTime(2014), 40),
  SalesData(DateTime(2014), 25),
  SalesData(DateTime(2014), 40),
];
final List<SalesData> chartData2 = [
  SalesData(DateTime(2010), 40),
  SalesData(DateTime(2011), 32),
  SalesData(DateTime(2012), 25),
  SalesData(DateTime(2013), 28),
  SalesData(DateTime(2014), 37),
  SalesData(DateTime(2014), 35),
  SalesData(DateTime(2014), 40),
];
