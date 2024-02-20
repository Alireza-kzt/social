import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/styles/decorations.dart';
import '../../../../core/app/constants/assets_paths.dart';
import '../../../../core/app/view/widgets/loading_indicator_widget.dart';
import '../../controller/ticket_report_controller.dart';
import '../../data/models/point_model.dart';
import '../widgets/report_widget.dart';
import '../widgets/tabbar_widget.dart';

class TicketReportPage extends StatelessWidget {
  const TicketReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('گزارش  تیکت ها'),
        leading: IconButton(
          icon: SvgPicture.asset(AssetPaths.arrowRight, color: context.colorScheme.outline),
          onPressed: Get.back,
        ),
      ),
      body: SingleChildScrollView(
        padding: Decorations.pagePaddingHorizontal.copyWith(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => TabBarWidget<AppDateTime>(
                onTap: TicketReportController.to.onValueChanged,
                selectedValue: TicketReportController.to.selectedValue.value,
                tabs: [
                  (
                    label: 'هفتگی',
                    value: AppDateTime.today().addDays(-6),
                  ),
                  (
                    label: 'ماهانه',
                    value: AppDateTime.today().addMonths(-1),
                  ),
                  (
                    label: '3 ماهه',
                    value: AppDateTime.today().addMonths(-3),
                  ),
                ],
              ),
            ),
            TicketReportController.to.obx(
              (model) {
                return Column(
                  children: [
                    const SizedBox(height: 16),
                    ReportWidget(
                      headline: 'تعداد تیکت ${TicketReportController.to.currentLabel}',
                      reportModel: model!.ticket,
                      icon: SvgPicture.asset(AssetPaths.chats),
                      title: 'تعداد تیکت',
                      unit: 'تیکت',
                      fractionDigits: 0,
                      fromDate: TicketReportController.to.selectedValue.value,
                      toDate: AppDateTime.now(),
                      tooltipText: (PointModel point) => '${point.y.toStringAsFixed(0)} تیکت',
                    ),
                    const SizedBox(height: 16),
                  ],
                );
              },
              onLoading: Center(
                child: LoadingIndicatorWidget(
                  color: context.colorScheme.primary,
                  padding: EdgeInsets.only(top: context.height * 0.3),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
