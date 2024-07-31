import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_weather_app/models/location.dart';

import '../models/settings.dart';

class HourlyLineChart extends StatefulWidget {
  final Location location;
  final String type;
  const HourlyLineChart({super.key, required this.location, required this.type});

  @override
  State<HourlyLineChart> createState() => _HourlyLineChartState();
}

class _HourlyLineChartState extends State<HourlyLineChart> {
  @override
  void initState() {
    super.initState();
  }

  List<int> showingTooltipOnSpots = [0, 3, 6, 9, 12];

  List<FlSpot> get allSpots => [
    FlSpot(0, widget.location.weatherData?.hourly[0].toMap()[widget.type] ?? 0.0),
    FlSpot(1, widget.location.weatherData?.hourly[1].toMap()[widget.type] ?? 0.0),
    FlSpot(2, widget.location.weatherData?.hourly[2].toMap()[widget.type] ?? 0.0),
    FlSpot(3, widget.location.weatherData?.hourly[3].toMap()[widget.type] ?? 0.0),
    FlSpot(4, widget.location.weatherData?.hourly[4].toMap()[widget.type] ?? 0.0),
    FlSpot(5, widget.location.weatherData?.hourly[5].toMap()[widget.type] ?? 0.0),
    FlSpot(6, widget.location.weatherData?.hourly[6].toMap()[widget.type] ?? 0.0),
    FlSpot(7, widget.location.weatherData?.hourly[7].toMap()[widget.type] ?? 0.0),
    FlSpot(8, widget.location.weatherData?.hourly[8].toMap()[widget.type] ?? 0.0),
    FlSpot(9, widget.location.weatherData?.hourly[9].toMap()[widget.type] ?? 0.0),
    FlSpot(10, widget.location.weatherData?.hourly[10].toMap()[widget.type] ?? 0.0),
    FlSpot(11, widget.location.weatherData?.hourly[11].toMap()[widget.type] ?? 0.0),
    FlSpot(12, widget.location.weatherData?.hourly[12].toMap()[widget.type] ?? 0.0),
  ];

  Widget bottomTitleWidgets(double value, TitleMeta meta, double chartWidth) {
    String time;
    switch (value.toInt()) {
      case 0:
        time = widget.location.weatherData?.hourly[0].dtFormattedTime ?? '-';
        break;
      case 3:
        time = widget.location.weatherData?.hourly[3].dtFormattedTime ?? '-';
      case 6:
        time = widget.location.weatherData?.hourly[6].dtFormattedTime ?? '-';
        break;
      case 9:
        time = widget.location.weatherData?.hourly[9].dtFormattedTime ?? '-';
        break;
      case 12:
        time = widget.location.weatherData?.hourly[12].dtFormattedTime ?? '-';
        break;
      default:
        return Container();
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(time, style: TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontFamily: 'Inter',
            fontSize: 10,
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lineBarsData = [
      LineChartBarData(
        showingIndicators: showingTooltipOnSpots,
        spots: allSpots,
        isCurved: true,
        barWidth: 2,
        shadow: const Shadow(
          blurRadius: 0,
        ),
        belowBarData: BarAreaData(
          show: false,
        ),
        dotData: const FlDotData(show: false),
        color: Colors.white,
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return AspectRatio(
      aspectRatio: 2.5,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 24,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return LineChart(
            LineChartData(
              showingTooltipIndicators: showingTooltipOnSpots.map((index) {
                return ShowingTooltipIndicators([
                  LineBarSpot(
                    tooltipsOnBar,
                    lineBarsData.indexOf(tooltipsOnBar),
                    tooltipsOnBar.spots[index],
                  ),
                ]);
              }).toList(),
              lineTouchData: LineTouchData(
                enabled: true,
                handleBuiltInTouches: false,
                touchCallback:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return;
                  }
                  if (event is FlTapUpEvent) {
                    final spotIndex = response.lineBarSpots!.first.spotIndex;
                    setState(() {
                      if (showingTooltipOnSpots.contains(spotIndex)) {
                        showingTooltipOnSpots.remove(spotIndex);
                      } else {
                        showingTooltipOnSpots.add(spotIndex);
                      }
                    });
                  }
                },
                mouseCursorResolver:
                    (FlTouchEvent event, LineTouchResponse? response) {
                  if (response == null || response.lineBarSpots == null) {
                    return SystemMouseCursors.basic;
                  }
                  return SystemMouseCursors.click;
                },
                getTouchedSpotIndicator:
                    (LineChartBarData barData, List<int> spotIndexes) {
                  return spotIndexes.map((index) {
                    return TouchedSpotIndicatorData(
                      const FlLine(
                        color: Colors.white70,
                      ),
                      FlDotData(
                        show: true,
                        getDotPainter: (spot, percent, barData, index) =>
                            FlDotCirclePainter(
                              radius: 4,
                              strokeWidth: 1,
                              strokeColor: Colors.white,
                              color: Colors.purple,
                            ),
                      ),
                    );
                  }).toList();
                },
                touchTooltipData: LineTouchTooltipData(
                  getTooltipColor: (touchedSpot) => Colors.deepPurple[400]!,
                  tooltipRoundedRadius: 8,
                  tooltipPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 4),
                  getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
                    return lineBarsSpot.map((lineBarSpot) {
                      return LineTooltipItem(
                        "${lineBarSpot.y.round()}${widget.type == 'temp' ? (
                            Settings.system == 'metric' ? '°C' : '°F') : (Settings.system == 'metric' ? 'm/s' : 'm/h')
                        }",
                        const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      );
                    }).toList();
                  },
                ),
              ),
              lineBarsData: lineBarsData,
              minY: 0,
              titlesData: FlTitlesData(
                leftTitles: const AxisTitles(
                  axisNameWidget: Text(''),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      return bottomTitleWidgets(
                        value,
                        meta,
                        constraints.maxWidth,
                      );
                    },
                    reservedSize: 24,
                  ),
                ),
                rightTitles: const AxisTitles(
                  axisNameWidget: Text(''),
                ),
                topTitles: const AxisTitles(
                  axisNameWidget: Text(''),
                ),
              ),
              gridData: const FlGridData(show: false),
              borderData: FlBorderData(
                show: false,
                border: Border.all(
                  color: Colors.grey,
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}