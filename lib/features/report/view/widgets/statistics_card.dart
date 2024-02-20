import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/colors/color_schemes.dart';
import 'package:social/core/app/view/themes/styles/buttons/button_types.dart';

import '../../../../core/app/view/themes/styles/buttons/button_icon/outline_button_icon.dart';
import '../../data/models/report_detail_model.dart';

class StatisticCard extends StatelessWidget {
  final ReportDetailModel reportModel;
  final String title, subtitle, unit;
  final Widget icon;
  final int fractionDigits;
  final TextStyle? subtitleTextStyle;
  final void Function()? onPressed;

  const StatisticCard({
    super.key,
    required this.reportModel,
    required this.title,
    required this.subtitle,
    required this.unit,
    required this.icon,
    this.onPressed,
    this.fractionDigits = 1,
    this.subtitleTextStyle,
  });

  double get _maxHeight {
    double max = 0;

    for (var bar in reportModel.activities) {
      if (bar.y > max) {
        max = bar.y;
      }
    }

    return max;
  }

  LinearGradient get _barsGradient => LinearGradient(
        colors: [
          lightColorScheme.primary.withOpacity(0.1),
          lightColorScheme.primary,
        ],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  List<BarChartGroupData> get barGroups => [
        for (var bar in reportModel.activities)
          BarChartGroupData(
            x: bar.x,
            barsSpace: 24,
            barRods: [
              BarChartRodData(
                toY: bar.y,
                color: lightColorScheme.surface,
                width: 19,
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                gradient: bar.y == _maxHeight ? _barsGradient : null,
              )
            ],
          ),
      ];

  FlBorderData get borderData => FlBorderData(show: false);

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
      );

  Widget getTitles(double value, TitleMeta meta) {
    for (var bar in reportModel.activities) {
      if (value == bar.x) {
        return SideTitleWidget(
          axisSide: meta.axisSide,
          space: bar.label.length.toDouble() * 4,
          child: Text(
            bar.label,
            style: Get.theme.textTheme.bodySmall,
            textAlign: TextAlign.justify,
          ),
        );
      }
    }

    return SideTitleWidget(axisSide: meta.axisSide, space: 4, child: const Text(''));
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
        decoration: ShapeDecoration(
          color: context.colorScheme.surfaceVariant,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                icon,
                const SizedBox(width: 8),
                Text(title, style: context.textTheme.labelMedium),
                const Spacer(),
                OutlinedButtonIcon(
                  onPressed: onPressed,
                  icon: const Icon(Icons.remove_red_eye_outlined),
                  label: const Text('مشاهده'),
                  color: ButtonColors.surface,
                  size: ButtonSizes.small,
                )
              ],
            ),
            const Divider(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subtitle,
                        style: context.textTheme.labelMedium?.copyWith(
                          color: context.colorScheme.outline,
                        ),
                      ),
                      Text(
                        '${reportModel.total.toStringAsFixed(fractionDigits)} $unit',
                        style: subtitleTextStyle ?? context.textTheme.headlineMedium,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  flex: 4,
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: BarChart(
                      BarChartData(
                        barGroups: barGroups,
                        borderData: borderData,
                        titlesData: titlesData,
                        barTouchData: BarTouchData(enabled: false),
                        gridData: const FlGridData(show: false),
                        alignment: BarChartAlignment.spaceBetween,
                      ),
                      swapAnimationDuration: const Duration(milliseconds: 150), // Optional
                      swapAnimationCurve: Curves.linear, // Optional
                    ),
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
