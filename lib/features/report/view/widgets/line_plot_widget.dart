import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/colors/color_schemes.dart';

import '../../data/models/point_model.dart';

class LinePlotWidget extends StatelessWidget {
  final List<PointModel> points;
  final String Function(PointModel point) tooltipText;
  final int fractionDigits;

  List<Color> gradientColors = [
    lightColorScheme.primary.withOpacity(0.2),
    lightColorScheme.primary.withOpacity(0.0),
  ];

  LinePlotWidget({super.key, required this.points, required this.tooltipText, this.fractionDigits = 1});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 64.0, left: 20),
          child: AspectRatio(
            aspectRatio: 1.65,
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    final style = Get.textTheme.labelSmall?.copyWith(color: Get.theme.colorScheme.outline);

    for (var point in points) {
      if (value == point.x * -1) {
        return SideTitleWidget(
          axisSide: meta.axisSide,
          space: 4,
          child: Text(point.label, style: style),
        );
      }
    }

    return SideTitleWidget(axisSide: meta.axisSide, space: 4, child: const Text(''));
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    // if (value == value.roundToDouble()) {
    //   return Text(
    //     value.ceil().toString(),
    //     textAlign: TextAlign.center,
    //     style: Get.textTheme.labelSmall?.copyWith(color: Get.theme.colorScheme.outline),
    //   );
    // } else {
    //   return const SizedBox();
    // }

    return Text(
      value.toStringAsFixed(fractionDigits),
      textAlign: TextAlign.center,
      style: Get.textTheme.labelSmall?.copyWith(color: Get.theme.colorScheme.outline),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      // maxX: 0,
      // minX: points.length.toDouble(),

      lineTouchData: LineTouchData(
        touchTooltipData: LineTouchTooltipData(
          tooltipBgColor: Get.theme.colorScheme.primary,
          tooltipRoundedRadius: 8,
          tooltipPadding: const EdgeInsets.all(8.0),
          getTooltipItems: (lineBarSpots) => lineBarSpots
              .map(
                (spot) => spot.x == points.first.x - 0.5 || spot.x == points.last.x + 0.5
                    ? null
                    : LineTooltipItem(
                        tooltipText(points.firstWhere((element) => element.x * -1 == spot.x.toInt())),
                        Get.theme.textTheme.labelMedium!.copyWith(color: Get.theme.colorScheme.background),
                        textAlign: TextAlign.center,
                        textDirection: TextDirection.rtl,
                      ),
              )
              .toList(),
        ),
        getTouchedSpotIndicator: (LineChartBarData barData, List<int> spotIndexes) {
          return spotIndexes.map((spotIndex) {
            final spot = barData.spots[spotIndex];
            if (spot.x == points.first.x + 0.5 || spot.x == points.last.x - 0.5) {
              return null;
            }
            return TouchedSpotIndicatorData(
              const FlLine(strokeWidth: 0),
              FlDotData(
                getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                  radius: 8,
                  color: Get.theme.colorScheme.primary,
                ),
              ),
            );
          }).toList();
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          axisNameWidget: const ColoredBox(color: Colors.red),
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: leftTitleWidgets,
            reservedSize: 40,
          ),
        ),
      ),
      gridData: const FlGridData(show: false),
      borderData: FlBorderData(show: false),
      lineBarsData: [
        LineChartBarData(
          spots: [
            // FlSpot(points.first.x * -1 + 0.5, points.first.y),
            for (var pont in points) FlSpot(pont.x.toDouble() * -1, pont.y),
            // FlSpot(points.last.x * -1 - 0.5, points.last.y),
          ],
          isCurved: true,
          color: Get.context?.colorScheme.primary,
          barWidth: 1,
          isStrokeCapRound: true,
          dotData: const FlDotData(show: false),
          curveSmoothness: 0,
          preventCurveOverShooting: true,
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors,
              stops: const [0.5, 1.0],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ],
    );
  }
}

