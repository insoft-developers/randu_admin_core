import 'package:buzz/charts/chatdemo.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:pie_chart/pie_chart.dart' as chart;
import 'Widgets/comuntitle.dart';
import 'Widgets/sizebox.dart';
import 'appstaticdata/staticdata.dart';
import 'charts/chart1.dart';
import 'charts/chart2.dart';
import 'charts/chart3.dart';
import 'charts/chart4.dart';
import 'charts/chart5.dart';
import 'charts/chart6.dart';
import 'comunbottombar.dart';
import 'provider/proviercolors.dart';

class ChartPage extends StatefulWidget {
  const ChartPage({super.key});

  @override
  State<ChartPage> createState() => _ChartPageState();
}

class _ChartPageState extends State<ChartPage> {
  final List<ChartData1> chartData = [
    ChartData1('David', 25, const Color(0xffF9C80E)),
    ChartData1('Steve', 38, const Color(0xffF86624)),
    ChartData1('Jack', 34, const Color(0xff2BB2FE)),
    ChartData1('Others', 52, appMainColor)
  ];
  @override
  Widget build(BuildContext context) {
    return Consumer<ColorNotifire>(
      builder: (context, value, child) {
        return Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: notifire!.getbgcolor,
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if (constraints.maxWidth < 600) {
                // Mobile layout
                return SizedBox(
                  height: 900,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        const ComunTitle(title: 'Chart', path: "Widgets"),
                        _buildTotalSale(),
                        _buildTotalProject(),
                        _buildTotalProduct(),
                        _buildMonthlyHistory(),
                        _buildOrderStatus(),
                        _buildSkillStatus(),
                        _buildCryptoPrice(),
                        _buildCryptoAnnotation(),
                        Container(
                          padding: const EdgeInsets.all(padding),
                          margin: const EdgeInsets.all(padding),
                          width: constraints.maxWidth,
                          decoration: BoxDecoration(
                            color: notifire!.getcontiner,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Table(
                                  children: [
                                    container2Chart(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                            padding: const EdgeInsets.all(padding),
                            margin: const EdgeInsets.all(padding),
                            decoration: BoxDecoration(
                              color: notifire!.getcontiner,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: _buildchart01()),
                        Container(
                            padding: const EdgeInsets.all(padding),
                            margin: const EdgeInsets.all(padding),
                            decoration: BoxDecoration(
                              color: notifire!.getcontiner,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  "Overview Product",
                                  style: mainTextStyle.copyWith(
                                      fontSize: 17,
                                      color: notifire!.getMainText),
                                ),
                                _buildchart02(constraints.maxHeight),
                              ],
                            )),
                        _buildchart03(),
                        _buildchart04(),
                        const SizeBoxx(),
                        const ComunBottomBar(),
                      ],
                    ),
                  ),
                );
              } else if (constraints.maxWidth < 1200) {
                if (constraints.maxWidth < 900) {
                  return SizedBox(
                    height: 1000,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const ComunTitle(title: 'Chart', path: "Widgets"),
                          _buildTotalSale(),
                          _buildTotalProject(),
                          _buildTotalProduct(),
                          _buildMonthlyHistory(),
                          _buildOrderStatus(),
                          _buildSkillStatus(),
                          _buildCryptoPrice(),
                          _buildCryptoAnnotation(),
                          Container(
                            padding: const EdgeInsets.all(padding),
                            margin: const EdgeInsets.all(padding),
                            width: constraints.maxWidth,
                            decoration: BoxDecoration(
                              color: notifire!.getcontiner,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Table(
                                    children: [
                                      container2Chart(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                              padding: const EdgeInsets.all(padding),
                              margin: const EdgeInsets.all(padding),
                              decoration: BoxDecoration(
                                color: notifire!.getcontiner,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: _buildchart01()),
                          Container(
                              padding: const EdgeInsets.all(padding),
                              margin: const EdgeInsets.all(padding),
                              decoration: BoxDecoration(
                                color: notifire!.getcontiner,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Column(
                                children: [
                                  Text(
                                    "Overview Product",
                                    style: mainTextStyle.copyWith(
                                        fontSize: 17,
                                        color: notifire!.getMainText),
                                  ),
                                  _buildchart02(constraints.maxHeight),
                                ],
                              )),
                          _buildchart03(),
                          _buildchart04(),
                          const SizeBoxx(),
                          const ComunBottomBar(),
                        ],
                      ),
                    ),
                  );
                } else {
                  return SizedBox(
                    height: 1000,
                    width: double.infinity,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const ComunTitle(title: 'Chart', path: "Widgets"),
                          Row(
                            children: [
                              Expanded(child: _buildTotalSale()),
                              Expanded(child: _buildTotalProject()),
                              Expanded(child: _buildTotalSale()),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(child: _buildMonthlyHistory()),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 3, child: _buildSkillStatus()),
                              Expanded(flex: 4, child: _buildOrderStatus()),
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(flex: 4, child: _buildCryptoPrice()),
                              Expanded(
                                  flex: 3, child: _buildCryptoAnnotation()),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.all(padding),
                            margin: const EdgeInsets.all(padding),
                            width: constraints.maxWidth < 600
                                ? 600
                                : constraints.maxWidth,
                            decoration: BoxDecoration(
                              color: notifire!.getcontiner,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Table(
                                    children: [
                                      container2Chart(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                  flex: 4,
                                  child: Container(
                                      padding: const EdgeInsets.all(padding),
                                      margin: const EdgeInsets.all(padding),
                                      decoration: BoxDecoration(
                                        color: notifire!.getcontiner,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: _buildchart01())),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                      padding: const EdgeInsets.all(padding),
                                      margin: const EdgeInsets.all(padding),
                                      decoration: BoxDecoration(
                                        color: notifire!.getcontiner,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Overview Product",
                                            style: mainTextStyle.copyWith(
                                                fontSize: 17,
                                                color: notifire!.getMainText),
                                          ),
                                          const SizedBox(
                                            height: 40,
                                          ),
                                          _buildchart02(constraints.maxWidth),
                                        ],
                                      ))),
                            ],
                          ),
                          Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(child: _buildchart03()),
                                Expanded(child: _buildchart04()),
                              ]),
                          const SizeBoxx(),
                          const ComunBottomBar(),
                        ],
                      ),
                    ),
                  );
                }

                // Tablet layout
              } else {
                // Website layout
                return SizedBox(
                  height: 1000,
                  width: double.infinity,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const ComunTitle(title: 'Chart', path: "Widgets"),
                        Row(
                          children: [
                            Expanded(child: _buildTotalSale()),
                            Expanded(child: _buildTotalProject()),
                            Expanded(child: _buildTotalProduct()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(child: _buildMonthlyHistory()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 3, child: _buildSkillStatus()),
                            Expanded(flex: 4, child: _buildOrderStatus()),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(flex: 4, child: _buildCryptoPrice()),
                            Expanded(flex: 3, child: _buildCryptoAnnotation()),
                          ],
                        ),
                        Container(
                          padding: const EdgeInsets.all(padding),
                          margin: const EdgeInsets.all(padding),
                          width: constraints.maxWidth < 1000
                              ? 600
                              : constraints.maxWidth,
                          decoration: BoxDecoration(
                            color: notifire!.getcontiner,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Table(
                                  children: [
                                    container2Chart(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                                flex: 4,
                                child: Container(
                                    padding: const EdgeInsets.all(padding),
                                    margin: const EdgeInsets.all(padding),
                                    decoration: BoxDecoration(
                                      color: notifire!.getcontiner,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: _buildchart01())),
                            Expanded(
                                flex: 3,
                                child: Container(
                                    padding: const EdgeInsets.all(padding),
                                    margin: const EdgeInsets.all(padding),
                                    decoration: BoxDecoration(
                                      color: notifire!.getcontiner,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Overview Product",
                                          style: mainTextStyle.copyWith(
                                              fontSize: 17,
                                              color: notifire!.getMainText),
                                        ),
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        _buildchart02(constraints.maxWidth),
                                      ],
                                    ))),
                          ],
                        ),
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(child: _buildchart03()),
                              Expanded(child: _buildchart04()),
                            ]),
                        const SizeBoxx(),
                        const ComunBottomBar(),
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        );
      },
    );
  }

  Widget _buildTotalSale() {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        // height: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: notifire!.getcontiner,
          boxShadow: boxShadow,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Total Sale",
                  style: mainTextStyle.copyWith(
                      fontSize: 17, color: notifire!.getMainText)),
            ),
            const Chart2(
              bgcolor: Color(0xffc7c2ff),
              bordercolor: Color(0xff7d70ff),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalProject() {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        // height: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: notifire!.getcontiner,
          boxShadow: boxShadow,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Total Project",
                  style: mainTextStyle.copyWith(
                      fontSize: 17, color: notifire!.getMainText)),
            ),
            const Chart2(
              bgcolor: Color(0xfffcaec2),
              bordercolor: Color(0xfff73265),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTotalProduct() {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        // height: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: notifire!.getcontiner,
          boxShadow: boxShadow,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Total Product",
                  style: mainTextStyle.copyWith(
                      fontSize: 17, color: notifire!.getMainText)),
            ),
            const Chart2(
              bgcolor: Color(0xffb8e3a6),
              bordercolor: Color(0xff5bbf32),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMonthlyHistory() {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        // height: 390,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: notifire!.getcontiner,
          boxShadow: boxShadow,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Monthly History",
                  style: mainTextStyle.copyWith(
                      fontSize: 17, color: notifire!.getMainText)),
            ),
            const Chart3(),
          ],
        ),
      ),
    );
  }

  Widget _buildSkillStatus() {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        // height: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: notifire!.getcontiner,
          boxShadow: boxShadow,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Live Product",
                  style: mainTextStyle.copyWith(
                      fontSize: 17, color: notifire!.getMainText)),
            ),
            const Chart7(),
          ],
        ),
      ),
    );
  }

  Widget _buildchart01() {
    return Column(
      children: [
        Text(
          "Total Income",
          style: mainTextStyle.copyWith(
              fontSize: 17, color: notifire!.getMainText),
        ),
        SfCircularChart(
          annotations: [
            CircularChartAnnotation(
              widget: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "\$ 75.5K",
                      style: TextStyle(
                        color: notifire!.getMainText,
                        // fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      alignment: Alignment.center,
                      height: 20,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.green.shade50,
                        borderRadius: BorderRadius.circular(3),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.only(left: 5, right: 5),
                        child: Text(
                          "+10%",
                          style: TextStyle(
                            color: Color(0xff1A9882),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
          margin: EdgeInsets.zero,
          palette: const [
            Color(0xff883DCF),
            Color(0xffF86624),
            Color(0xffF9C80E),
            Color(0xff2BB2FE),
          ],
          series: <CircularSeries>[
            DoughnutSeries<ChartData1, String>(
                startAngle: 0,
                cornerStyle: CornerStyle.bothCurve,
                dataSource: chartData,
                xValueMapper: (ChartData1 data, _) => data.x,
                yValueMapper: (ChartData1 data, _) => data.y,
                innerRadius: "90"),
          ],
        ),
      ],
    );
  }

  Widget _buildOrderStatus() {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        // height: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: notifire!.getcontiner,
          boxShadow: boxShadow,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Skill Status",
                  style: mainTextStyle.copyWith(
                      fontSize: 17, color: notifire!.getMainText)),
            ),
            const Chart4(),
          ],
        ),
      ),
    );
  }

  final pilateColor = appMainColor;
  final cyclingColor = const Color(0xffF98550);
  final quickWorkoutColor = Colors.red;
  final betweenSpace = 0.2;

  Widget _buildchart04() {
    return Container(
      margin: const EdgeInsets.all(padding),
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: notifire!.getcontiner,
        boxShadow: boxShadow,
      ),
      child: Column(
        children: [
          Text("Acquisition Channels",
              style: mainTextStyle.copyWith(
                  fontSize: 17, color: notifire!.getMainText)),
          const SizedBox(
            height: 40,
          ),
          Table(
            children: [
              const TableRow(children: [
                SizedBox(
                  height: 6,
                ),
              ]),
              chart1221(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCryptoPrice() {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        // height: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: notifire!.getcontiner,
          boxShadow: boxShadow,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text("Cryptocurrency Prices",
                  style: mainTextStyle.copyWith(
                      fontSize: 17, color: notifire!.getMainText)),
            ),
            const Chart5(),
          ],
        ),
      ),
    );
  }

  Widget _buildCryptoAnnotation() {
    return Padding(
      padding: const EdgeInsets.all(padding),
      child: Container(
        height: 350,
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: notifire!.getcontiner,
          boxShadow: boxShadow,
        ),
        child: const Chart1(),
      ),
    );
  }

  Map<String, double> dataMap = {
    "In Progress": 50,
    "Finished": 35,
    "Unfinished": 15,
  };
  List<Color> colorList = [
    const Color(0xffF86624),
    const Color(0xff22CAAD),
    const Color(0xffEB3D4D),
  ];

  Widget _buildchart02(size) {
    return size > 600
        ? chart.PieChart(
            dataMap: dataMap,
            colorList: colorList,
            chartRadius: 240,
            ringStrokeWidth: 24,
            animationDuration: const Duration(seconds: 3),
            chartValuesOptions: const chart.ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
            legendOptions: const chart.LegendOptions(
              showLegends: false,
            ),
            baseChartColor: Colors.white,
          )
        : chart.PieChart(
            dataMap: dataMap,
            colorList: colorList,
            chartRadius: size / 2.4,
            centerText: "Budget",
            ringStrokeWidth: 24,
            animationDuration: const Duration(seconds: 3),
            chartValuesOptions: const chart.ChartValuesOptions(
              showChartValuesInPercentage: true,
            ),
            legendOptions: const chart.LegendOptions(
              showLegends: false,
            ),
            baseChartColor: Colors.white,
          );
  }

  TableRow container2Chart() {
    return TableRow(
      children: [
        Column(
          children: [
            Text(
              "Sales Report",
              style: mainTextStyle.copyWith(
                  fontSize: 17, color: notifire!.getMainText),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: AspectRatio(
                aspectRatio: 2,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceBetween,
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: leftTitles,
                          interval: 5,
                          reservedSize: 20,
                        ),
                      ),
                      rightTitles: const AxisTitles(),
                      topTitles: const AxisTitles(),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: bottomTitles,
                          reservedSize: 20,
                        ),
                      ),
                    ),
                    barTouchData: BarTouchData(enabled: false),
                    borderData: FlBorderData(show: false),
                    gridData: const FlGridData(show: false),
                    barGroups: [
                      generateGroupData(0, 2, 3, 2),
                      generateGroupData(1, 2, 5, 1.7),
                      generateGroupData(2, 1.3, 3.1, 2.8),
                      generateGroupData(3, 3.1, 4, 3.1),
                      generateGroupData(4, 0.8, 3.3, 3.4),
                      generateGroupData(5, 2, 5.6, 1.8),
                      generateGroupData(6, 1.3, 3.2, 2),
                      generateGroupData(7, 2.3, 3.2, 3),
                      generateGroupData(8, 2, 4.8, 2.5),
                      generateGroupData(9, 1.2, 3.2, 2.5),
                      generateGroupData(10, 1, 4.8, 3),
                      generateGroupData(11, 2, 4.4, 2.8),
                    ],
                    maxY: 11 + (betweenSpace * 3),
                    extraLinesData: ExtraLinesData(
                      horizontalLines: [
                        HorizontalLine(
                          y: 3.3,
                          color: notifire!.getMaingey,
                          strokeWidth: 1,
                          dashArray: [20, 4],
                        ),
                        HorizontalLine(
                          y: 8,
                          color: Colors.red,
                          strokeWidth: 1,
                          dashArray: [20, 4],
                        ),
                        HorizontalLine(
                          y: 11,
                          color: Colors.amber,
                          strokeWidth: 1,
                          dashArray: [20, 4],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  final List<ChartData2> chartData2 = [
    ChartData2('David', 50, const Color(0xff22CAAD)),
    ChartData2('David', 60, const Color(0xffF9C80E)),
    ChartData2('Steve', 85, const Color(0xffF86624)),
    ChartData2('Jack', 70, const Color(0xff2BB2FE)),
    ChartData2('Others', 90, appMainColor)
  ];

  Widget _buildchart03() {
    return Container(
      margin: const EdgeInsets.all(padding),
      padding: const EdgeInsets.all(padding),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        color: notifire!.getcontiner,
        boxShadow: boxShadow,
      ),
      child: Column(
        children: [
          Text("Monthly Report",
              style: mainTextStyle.copyWith(
                  fontSize: 17, color: notifire!.getMainText)),
          SfCircularChart(
            series: <CircularSeries>[
              RadialBarSeries<ChartData2, String>(
                trackColor: notifire!.getMaingey,
                cornerStyle: CornerStyle.bothCurve,
                dataSource: chartData2,
                maximumValue: 100,
                innerRadius: '15%',
                pointColorMapper: (ChartData2 data, _) => data.color,
                gap: '10%',
                xValueMapper: (ChartData2 data, _) => data.x,
                yValueMapper: (ChartData2 data, _) => data.y,
              ),
            ],
          ),
        ],
      ),
    );
  }

  BarChartGroupData generateGroupData(
    int x,
    double pilates,
    double quickWorkout,
    double cycling,
  ) {
    return BarChartGroupData(
      x: x,
      groupVertically: true,
      barRods: [
        BarChartRodData(
          fromY: 0,
          toY: pilates,
          color: pilateColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout,
          color: quickWorkoutColor,
          width: 5,
        ),
        BarChartRodData(
          fromY: pilates + betweenSpace + quickWorkout + betweenSpace,
          toY: pilates + betweenSpace + quickWorkout + betweenSpace + cycling,
          color: cyclingColor,
          width: 5,
        ),
      ],
    );
  }

  Widget leftTitles(double value, TitleMeta meta) {
    var style = const TextStyle(color: Colors.transparent, fontSize: 10);
    String text;
    if (value == 0) {
      text = '0';
    } else {
      text = '${value.toInt()}0k';
    }
    return SideTitleWidget(
      angle: AppUtils().degreeToRadian(value < 0 ? -45 : 45),
      axisSide: meta.axisSide,
      space: 4,
      child: Text(
        text,
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget bottomTitles(double value, TitleMeta meta) {
    var style = TextStyle(fontSize: 10, color: notifire!.getMainText);
    String text;
    switch (value.toInt()) {
      case 0:
        text = 'JAN';
        break;
      case 1:
        text = 'FEB';
        break;
      case 2:
        text = 'MAR';
        break;
      case 3:
        text = 'APR';
        break;
      case 4:
        text = 'MAY';
        break;
      case 5:
        text = 'JUN';
        break;
      case 6:
        text = 'JUL';
        break;
      case 7:
        text = 'AUG';
        break;
      case 8:
        text = 'SEP';
        break;
      case 9:
        text = 'OCT';
        break;
      case 10:
        text = 'NOV';
        break;
      case 11:
        text = 'DEC';
        break;
      default:
        text = '';
    }
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(text, style: style),
    );
  }
}

class ChartData1 {
  ChartData1(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}

class ChartData2 {
  ChartData2(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
