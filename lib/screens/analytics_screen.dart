// import 'package:flutter/material.dart';
// import 'package:kokzaki_admin_panel/helper/colors.dart';
// // import 'package:kokzaki_admin_panel/helper/colors.dart';
// // import 'package:fl_chart/fl_chart.dart';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:kokzaki_admin_panel/helper/colors.dart';

// class AnayticsScreen extends StatefulWidget {
//   const AnayticsScreen({super.key});

//   @override
//   State<AnayticsScreen> createState() => _AnayticsScreenState();
// }

// class _AnayticsScreenState extends State<AnayticsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(
//       children: [
//         const SizedBox(
//           height: 50,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             const RevenueContainers(
//               text: 'Total Revenue',
//               subText: '\$80K',
//               percentText: '12%',
//               icon: Icons.arrow_circle_up,
//               color: Color(0xff263C81),
//               iconsColor: Colors.green,
//             ),
//             const RevenueContainers(
//               text: 'Total Sales Registered',
//               subText: '603',
//               percentText: '56%',
//               icon: Icons.arrow_circle_down,
//               color: Colors.blue,
//               iconsColor: Colors.red,
//             ),
//             RevenueContainers(
//               text: 'Total Sales',
//               subText: '\$4067',
//               percentText: '43%',
//               icon: Icons.arrow_circle_up,
//               color: primaryColor,
//               iconsColor: Colors.green,
//             )
//           ],
//         )
//       ],
//     ));
//   }
// }

// ignore: must_be_immutable
class AnalyticsScreen extends StatelessWidget {
  AnalyticsScreen({
    super.key,
    Color? line1Color1,
    Color? line1Color2,
    Color? line2Color1,
    Color? line2Color2,
  })  : line1Color1 = line1Color1 ?? Colors.orange,
        line1Color2 = line1Color2 ?? Colors.orange,
        line2Color1 = line2Color1 ?? Colors.black,
        line2Color2 = line2Color2 ?? Colors.black {
    minSpotX = spots.first.x;
    maxSpotX = spots.first.x;
    minSpotY = spots.first.y;
    maxSpotY = spots.first.y;

    for (final spot in spots) {
      if (spot.x > maxSpotX) {
        maxSpotX = spot.x;
      }

      if (spot.x < minSpotX) {
        minSpotX = spot.x;
      }

      if (spot.y > maxSpotY) {
        maxSpotY = spot.y;
      }

      if (spot.y < minSpotY) {
        minSpotY = spot.y;
      }
    }
  }

  final Color line1Color1;
  final Color line1Color2;
  final Color line2Color1;
  final Color line2Color2;

  final spots = const [
    FlSpot(0, 1),
    FlSpot(2, 5),
    FlSpot(4, 3),
    FlSpot(6, 5),
  ];

  final spots2 = const [
    FlSpot(0, 3),
    FlSpot(2, 1),
    FlSpot(4, 2),
    FlSpot(6, 1),
  ];

  late double minSpotX;
  late double maxSpotX;
  late double minSpotY;
  late double maxSpotY;

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      color: line1Color1,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );

    final intValue = reverseY(value, minSpotY, maxSpotY).toInt();

    if (intValue == (maxSpotY + minSpotY)) {
      return Text('', style: style);
    }

    return Padding(
      padding: const EdgeInsets.only(right: 6),
      child: Text(
        intValue.toString(),
        style: style,
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget rightTitleWidgets(double value, TitleMeta meta) {
    final style = TextStyle(
      color: line2Color2,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
    final intValue = reverseY(value, minSpotY, maxSpotY).toInt();

    if (intValue == (maxSpotY + minSpotY)) {
      return Text('', style: style);
    }

    return Text(intValue.toString(), style: style, textAlign: TextAlign.right);
  }

  Widget topTitleWidgets(double value, TitleMeta meta) {
    if (value % 1 != 0) {
      return Container();
    }
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Text(value.toInt().toString(), style: style),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const RevenueContainers(
                text: 'Total Revenue',
                subText: '\$80K',
                percentText: '12%',
                icon: Icons.arrow_circle_up,
                color: Color(0xff263C81),
                iconsColor: Colors.green,
              ),
              const RevenueContainers(
                text: 'Total Sales Registered',
                subText: '603',
                percentText: '56%',
                icon: Icons.arrow_circle_down,
                color: Colors.blue,
                iconsColor: Colors.red,
              ),
              RevenueContainers(
                text: 'Total Sales',
                subText: '\$4067',
                percentText: '43%',
                icon: Icons.arrow_circle_up,
                color: primaryColor,
                iconsColor: Colors.green,
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 22, bottom: 20),
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.white)]),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Users Sales and Visit Data ',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 19,
                              fontFamily: 'Hind'),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: secondaryColor,
                                      borderRadius: BorderRadius.circular(3)),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Direct Link',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Hind',
                                      color: Color(0xffA3A3A3)),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Row(
                              children: [
                                Container(
                                  height: 10,
                                  width: 10,
                                  decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.circular(3)),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text(
                                  'Affiliate Link',
                                  style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Hind',
                                      color: Color(0xffA3A3A3)),
                                )
                              ],
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  AspectRatio(
                    aspectRatio: 3.5,
                    child: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(enabled: false),
                        lineBarsData: [
                          LineChartBarData(
                            gradient: LinearGradient(
                              colors: [
                                line1Color1,
                                line1Color2,
                              ],
                            ),
                            spots: reverseSpots(spots, minSpotY, maxSpotY),
                            isCurved: true,
                            isStrokeCapRound: true,
                            barWidth: 10,
                            belowBarData: BarAreaData(
                              show: false,
                            ),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) =>
                                  FlDotCirclePainter(
                                radius: 12,
                                color: Colors.transparent,
                                strokeColor: Colors.black,
                              ),
                            ),
                          ),
                          LineChartBarData(
                            gradient: LinearGradient(
                              colors: [
                                line2Color1,
                                line2Color2,
                              ],
                            ),
                            spots: reverseSpots(spots2, minSpotY, maxSpotY),
                            isCurved: true,
                            isStrokeCapRound: true,
                            barWidth: 10,
                            belowBarData: BarAreaData(
                              show: false,
                            ),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) =>
                                  FlDotCirclePainter(
                                radius: 12,
                                color: Colors.transparent,
                                strokeColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                        minY: 0,
                        maxY: maxSpotY + minSpotY,
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: leftTitleWidgets,
                              reservedSize: 38,
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: rightTitleWidgets,
                              reservedSize: 30,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              getTitlesWidget: topTitleWidgets,
                            ),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          checkToShowHorizontalLine: (value) {
                            final intValue =
                                reverseY(value, minSpotY, maxSpotY).toInt();

                            if (intValue == (maxSpotY + minSpotY).toInt()) {
                              return false;
                            }

                            return true;
                          },
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            left: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.transparent),
                            right: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  AspectRatio(
                    aspectRatio: 3.5,
                    child: LineChart(
                      LineChartData(
                        lineTouchData: LineTouchData(enabled: false),
                        lineBarsData: [
                          // LineChartBarData(
                          //   gradient: LinearGradient(
                          //     colors: [
                          //       line1Color1,
                          //       line1Color2,
                          //     ],
                          //   ),
                          //   spots: reverseSpots(spots, minSpotY, maxSpotY),
                          //   isCurved: true,
                          //   isStrokeCapRound: true,
                          //   barWidth: 10,
                          //   belowBarData: BarAreaData(
                          //     show: false,
                          //   ),
                          //   dotData: FlDotData(
                          //     show: true,
                          //     getDotPainter: (spot, percent, barData, index) =>
                          //         FlDotCirclePainter(
                          //       radius: 12,
                          //       color: Colors.transparent,
                          //       strokeColor: Colors.black,
                          //     ),
                          //   ),
                          // ),
                          LineChartBarData(
                            gradient: LinearGradient(
                              colors: [
                                line2Color1,
                                line2Color2,
                              ],
                            ),
                            spots: reverseSpots(spots2, minSpotY, maxSpotY),
                            isCurved: true,
                            isStrokeCapRound: true,
                            barWidth: 10,
                            belowBarData: BarAreaData(
                              show: false,
                            ),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter: (spot, percent, barData, index) =>
                                  FlDotCirclePainter(
                                radius: 12,
                                color: Colors.transparent,
                                strokeColor: Colors.black,
                              ),
                            ),
                          ),
                        ],
                        minY: 0,
                        maxY: maxSpotY + minSpotY,
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: leftTitleWidgets,
                              reservedSize: 38,
                            ),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              getTitlesWidget: rightTitleWidgets,
                              reservedSize: 30,
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 32,
                              getTitlesWidget: topTitleWidgets,
                            ),
                          ),
                        ),
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          checkToShowHorizontalLine: (value) {
                            final intValue =
                                reverseY(value, minSpotY, maxSpotY).toInt();

                            if (intValue == (maxSpotY + minSpotY).toInt()) {
                              return false;
                            }

                            return true;
                          },
                        ),
                        borderData: FlBorderData(
                          show: true,
                          border: const Border(
                            left: BorderSide(color: Colors.black),
                            top: BorderSide(color: Colors.black),
                            bottom: BorderSide(color: Colors.transparent),
                            right: BorderSide(color: Colors.transparent),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  double reverseY(double y, double minX, double maxX) {
    return (maxX + minX) - y;
  }

  List<FlSpot> reverseSpots(List<FlSpot> inputSpots, double minY, double maxY) {
    return inputSpots.map((spot) {
      return spot.copyWith(y: (maxY + minY) - spot.y);
    }).toList();
  }
}

class RevenueContainers extends StatelessWidget {
  const RevenueContainers(
      {super.key,
      required this.text,
      required this.subText,
      required this.percentText,
      required this.icon,
      required this.iconsColor,
      required this.color});
  final String text;
  final String subText;
  final String percentText;
  final IconData icon;
  final Color color;
  final Color iconsColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: 250,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              text,
              style: TextStyle(
                  fontFamily: 'Hind', fontSize: 14, color: whiteColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                subText,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: whiteColor,
                  fontFamily: 'Hind',
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      percentText,
                      style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Hind'),
                    ),
                    const Text(
                      'Total Revenue this month',
                      style: TextStyle(color: Colors.white60, fontSize: 12),
                    )
                  ],
                ),
                Icon(
                  icon,
                  color: iconsColor,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';
// import 'package:syncfusion_flutter_charts/sparkcharts.dart';

// class AnalyticsScreen extends StatefulWidget {
//   const AnalyticsScreen({super.key});

//   @override
//   State<AnalyticsScreen> createState() => _AnalyticsScreenState();
// }

// class _AnalyticsScreenState extends State<AnalyticsScreen> {
//   List<_SalesData> data = [
//     _SalesData('Jan', 35),
//     _SalesData('Feb', 28),
//     _SalesData('Mar', 34),
//     _SalesData('Apr', 32),
//     _SalesData('May', 40)
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Column(children: [
//       //Initialize the chart widget
//       SfCartesianChart(
//           primaryXAxis: CategoryAxis(),
//           // Chart title
//           title: ChartTitle(
//             text: 'Half yearly sales analysis',
//           ),
//           // Enable legend
//           legend: const Legend(isVisible: true),
//           // Enable tooltip
//           tooltipBehavior: TooltipBehavior(enable: true),
//           series: <ChartSeries<_SalesData, String>>[
//             LineSeries<_SalesData, String>(
//                 dataSource: data,
//                 xValueMapper: (_SalesData sales, _) => sales.year,
//                 yValueMapper: (_SalesData sales, _) => sales.sales,
//                 name: 'Sales',
//                 // Enable data label
//                 dataLabelSettings: const DataLabelSettings(isVisible: true))
//           ]),
//       Expanded(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           //Initialize the spark charts widget
//           child: SfSparkLineChart.custom(
//             //Enable the trackball
//             trackball: const SparkChartTrackball(
//                 activationMode: SparkChartActivationMode.tap),
//             //Enable marker
//             marker: const SparkChartMarker(
//                 displayMode: SparkChartMarkerDisplayMode.all),
//             //Enable data label
//             labelDisplayMode: SparkChartLabelDisplayMode.all,
//             xValueMapper: (int index) => data[index].year,
//             yValueMapper: (int index) => data[index].sales,
//             dataCount: 5,
//           ),
//         ),
//       )
//     ]));
//   }
// }

// class _SalesData {
//   _SalesData(this.year, this.sales);

//   final String year;
//   final double sales;
// }
