import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/styles/decorations.dart';
import 'package:social/features/report/controller/report_controller.dart';
import '../../../../core/app/constants/assets_paths.dart';
import '../../../../core/app/view/widgets/loading_indicator_widget.dart';
import '../../data/models/point_model.dart';
import '../widgets/financial_card.dart';
import '../widgets/report_widget.dart';
import '../widgets/tabbar_widget.dart';

class FinancialReportPage extends StatelessWidget {
  const FinancialReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('گزارش مالی'),
        leading: IconButton(
          icon: SvgPicture.asset(AssetPaths.arrowRight, color: context.colorScheme.outline),
          onPressed: Get.back,
        ),
      ),
      body: SingleChildScrollView(
        controller: ReportController.to.scroll,
        padding: Decorations.pagePaddingHorizontal.copyWith(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(
              () => TabBarWidget<AppDateTime>(
                onTap: ReportController.to.onValueChanged,
                selectedValue: ReportController.to.selectedValue.value,
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
            ReportController.to.obx(
              (model) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ReportWidget(
                      headline: 'نمودار مالی ${ReportController.to.currentLabel}',
                      reportModel: model!.reportDetail,
                      icon: SvgPicture.asset(AssetPaths.money),
                      title: 'مجموع دریافتی',
                      unit: 'تومان',
                      fractionDigits: 0,
                      fromDate: ReportController.to.selectedValue.value,
                      toDate: AppDateTime.now(),
                      tooltipText: (PointModel point) => 'دریافتی ${"${point.dateTime.wN} - ${point.dateTime.month}/${point.dateTime.dd}"}\n${point.y.toStringAsFixed(0)} تومان',
                      caption: 'مبلغ های جدول برحسب هزار‌ تومان است.',
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'جزییات درآمد روزانه',
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 18),
                    ListView.separated(
                      separatorBuilder: (_, index) => const SizedBox(height: 8),
                      itemCount: ReportController.to.items.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) => FinancialCard(ticketFinancialOverview: ReportController.to.items[index]),
                    ),
                    const SizedBox(height: 8),
                    Obx(
                      () => Center(
                        child: LoadingIndicatorWidget(
                          isShow: ReportController.to.isPagingOnLoading.value,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
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
