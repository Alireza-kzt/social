import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';

import '../../data/models/point_model.dart';
import '../../data/models/report_detail_model.dart';
import 'line_plot_widget.dart';

class ReportWidget extends StatelessWidget {
  final ReportDetailModel reportModel;
  final Widget icon;
  final AppDateTime fromDate, toDate;
  final String unit, title, headline;
  final int fractionDigits;
  final String? caption;
  final String Function(PointModel) tooltipText;

  const ReportWidget({
    super.key,
    required this.reportModel,
    required this.icon,
    required this.fromDate,
    required this.toDate,
    required this.unit,
    required this.title,
    this.fractionDigits = 1,
    required this.headline,
    required this.tooltipText,
    this.caption,
  });

  // get points {
  //   List<PointModel> list = [];
  //
  //   for (int i = 0; i < reportModel.activities.length; i++) {
  //     final inv = reportModel.activities.inverse;
  //     var p = reportModel.activities[i];
  //     p.x = inv[i].x;
  //   list.add(p);
  //   }
  //
  //   return list;
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: context.colorScheme.surfaceVariant,
        shape: RoundedRectangleBorder(
          side: BorderSide(width: 1, color: context.colorScheme.surface),
          borderRadius: const BorderRadius.all(Radius.circular(16)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, right: 8),
            child: Text(
              headline,
              style: context.textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: 18),
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 6.0),
                          child: SizedBox(
                            width: 24,
                            height: 24,
                            child: icon,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '$title از ${fromDate.month}/${fromDate.day} تا ${toDate.month}/${toDate.day}',
                              style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.onInverseSurface),
                            ),
                            Text('${reportModel.total.toStringAsFixed(fractionDigits)} $unit',
                                style: context.textTheme.headlineMedium),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   children: [
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.end,
                    //       children: [
                    //         Text('پیشرفت هفتگی',
                    //             style: context.textTheme.labelMedium?.copyWith(color: context.colorScheme.onInverseSurface)),
                    //         Text(
                    //           '+۲.۳۶٪',
                    //           style: context.textTheme.headlineMedium?.copyWith(
                    //             color: const Color(0xFF039500),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //     const SizedBox(width: 4),
                    //     SvgPicture.asset(
                    //       AssetPaths.arrowDropDownCircle,
                    //       height: 28,
                    //       width: 28,
                    //       color: const Color(0xFF039500),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              LinePlotWidget(
                points: reportModel.activities,
                fractionDigits: fractionDigits,
                tooltipText: tooltipText,
              ),
            ],
          ),
          if (caption != null) const Divider(height: 16),
          if (caption != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 10, right: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.info_rounded,
                    color: context.colorScheme.outline,
                    size: 16,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    caption!,
                    style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.outline),
                  )
                ],
              ),
            ),
        ],
      ),
    );
  }
}
