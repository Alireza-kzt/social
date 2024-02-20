import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/classes/app_datetime.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/styles/decorations.dart';
import 'package:social/core/app/view/widgets/loading_indicator_widget.dart';
import '../../controller/report_controller.dart';
import '../../data/models/point_model.dart';
import '../widgets/comment_model.dart';
import '../widgets/report_widget.dart';
import '../widgets/tabbar_widget.dart';

class RatingReportPage extends StatelessWidget {
  const RatingReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('گزارش امتیازات'),
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
                tabs: ReportController.to.tabs,
              ),
            ),
            ReportController.to.obx(
              (model) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    ReportWidget(
                      headline: 'نمودار امتیاز ${ReportController.to.currentLabel}',
                      reportModel: model!.reportDetail,
                      icon: SvgPicture.asset(AssetPaths.star),
                      title: 'میانگین امتیاز',
                      unit: 'امتیاز',
                      fromDate: ReportController.to.selectedValue.value,
                      toDate: AppDateTime.now(),
                      tooltipText: (PointModel point) => 'میانگین: ${point.y.toStringAsFixed(1)}',
                    ),
                    const SizedBox(height: 18),
                    Text(
                      'نظر کاربران',
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 18),
                    ListView.separated(
                      separatorBuilder: (_, index) => const SizedBox(height: 8),
                      itemCount: ReportController.to.items.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (_, index) => CommentWidget(
                        commentModel: ReportController.to.items[index],
                        onTap: ReportController.to.openChat,
                      ),
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
