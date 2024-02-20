import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/app_routes.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/styles/decorations.dart';
import 'package:social/core/app/view/widgets/loading_indicator_widget.dart';

import '../../controller/report_overview_controller.dart';
import '../widgets/statistics_card.dart';

class ReportPage extends StatelessWidget {
  const ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ReportOverviewController.to.obx(
          (model) {
            return SingleChildScrollView(
              padding: Decorations.pagePaddingHorizontal.copyWith(top: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'گزارش فعالیت ها',
                    style: context.textTheme.headlineMedium,
                  ),
                  Text(
                    'با انتخاب هر کدوم از گزارش‌های زیر، می‌تونی اطلاعات و آمار کامل مربوط به اون قسمت رو ببینی',
                    style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
                  ),
                  const SizedBox(height: 16),
                  StatisticCard(
                    reportModel: model!.rate,
                    title: 'گزارش امتیازات',
                    subtitle: 'میانگین امتیاز',
                    unit: '',
                    subtitleTextStyle: context.textTheme.displayLarge,
                    icon: SvgPicture.asset(AssetPaths.star),
                    onPressed: () => Get.toNamed(AppRoutes.rateReport, arguments: 'rate'),
                  ),
                  const SizedBox(height: 16),
                  StatisticCard(
                    reportModel: model.financial,
                    title: 'گزارش مالی',
                    subtitle: 'کارکرد در یک هفته اخیر',
                    unit: 'تومان',
                    fractionDigits: 0,
                    icon: SvgPicture.asset(AssetPaths.money),
                    onPressed: () => Get.toNamed(AppRoutes.financialReport, arguments: 'finance'),
                  ),
                  const SizedBox(height: 16),
                  StatisticCard(
                    reportModel: model.ticket,
                    title: 'گزارش تیکت‌های پاسخ‌داده‌شده',
                    subtitle: 'کارکرد در یک هفته اخیر',
                    unit: 'تیکت',
                    fractionDigits: 0,
                    icon: SvgPicture.asset(AssetPaths.chats),
                    onPressed: () => Get.toNamed(AppRoutes.ticketReport, arguments: model.ticket),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
          onLoading: Center(child: LoadingIndicatorWidget(color: context.colorScheme.primary)),
        ),
      ),
    );
  }
}
