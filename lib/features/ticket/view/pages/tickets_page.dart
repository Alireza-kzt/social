import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/styles/buttons/button_icon/outline_button_icon.dart';
import 'package:social/core/app/view/widgets/custom_app_bar/main_app_bar.dart';
import 'package:social/core/app/view/widgets/loading_indicator_widget.dart';
import 'package:social/features/ticket/controller/reject_ticket_controller.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../../core/app/view/themes/styles/buttons/impo_buttons.dart';
import '../../../../core/app/view/themes/styles/decorations.dart';
import '../../controller/closed_ticket_controller.dart';
import '../../controller/open_ticket_controller.dart';
import '../../controller/ticket_interface.dart';
import '../../controller/tickets_controller.dart';
import '../widgets/chip_widget.dart';
import '../widgets/ticket_list_tile.dart';

class TicketsPage extends StatelessWidget {
  const TicketsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(customAction: const SizedBox(height: 45)),
      body: Padding(
        padding: Decorations.pagePaddingHorizontal.copyWith(top: 12),
        child: Column(
          children: [
            Obx(
              () => Row(
                children: [
                  Expanded(
                    child: ChipWidget(
                      isSelected: TicketsController.to.ticketsState.value == TicketsState.open,
                      title: 'باز',
                      onTap: () => TicketsController.to.onChangeTab(TicketsState.open),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChipWidget(
                      isSelected: TicketsController.to.ticketsState.value == TicketsState.closed,
                      title: 'بسته',
                      onTap: () => TicketsController.to.onChangeTab(TicketsState.closed),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ChipWidget(
                      isSelected: TicketsController.to.ticketsState.value == TicketsState.reject,
                      title: 'رد شده',
                      onTap: () => TicketsController.to.onChangeTab(TicketsState.reject),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 32),
            Expanded(
              child: PageView(
                controller: TicketsController.to.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  for (TicketInterface controller in [OpenTicketsController.to, ClosedTicketsController.to, RejectTicketsController.to])
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              controller.title,
                              style: context.textTheme.headlineSmall,
                            ),
                            if (controller is! OpenTicketsController)
                              Obx(
                                () => controller.isFiltered.value
                                    ? DateFilterChip(
                                        dateRange: controller.dateRange.value,
                                        onCancel: controller.onInit,
                                      )
                                    : OutlinedButtonIcon(
                                        onPressed: controller.selectDateRange,
                                        color: ButtonColors.surface,
                                        label: const Text('انتخاب تاریخ'),
                                        icon: SvgPicture.asset(AssetPaths.calendarMonth, color: context.colorScheme.onBackground),
                                      ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: controller.obx(
                            (tickets) {
                              return RefreshIndicator(
                                onRefresh: () => Future(() => TicketsController.to.initTickets()),
                                child: ListView.builder(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  controller: controller.scroll,
                                  itemCount: tickets!.items.length,
                                  padding: const EdgeInsets.only(top: 12, bottom: 32),
                                  itemBuilder: (_, index) => Column(
                                    children: [
                                      TicketListTile(
                                        ticketModel: tickets.items[index],
                                        onTicketPress: TicketsController.to.openTickets,
                                      ),
                                      Obx(
                                        () => Center(
                                          child: controller.isPaginationLoading.value && index == tickets.items.length - 1
                                              ? Padding(
                                                  padding: const EdgeInsets.only(top: 16.0),
                                                  child: LoadingIndicatorWidget(color: context.colorScheme.primary),
                                                )
                                              : const Divider(height: 32),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            onLoading: Center(child: LoadingIndicatorWidget(color: context.colorScheme.primary)),
                            onEmpty: Center(
                              child: RefreshIndicator(
                                onRefresh: () => Future(() => TicketsController.to.initTickets()),
                                child: SingleChildScrollView(
                                  physics: const AlwaysScrollableScrollPhysics(),
                                  child: SizedBox(
                                    height: context.height / 2,
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Image.asset(AssetPaths.ticketsEmptyState, width: context.width * 0.3),
                                        const SizedBox(
                                          height: 16,
                                          width: double.infinity,
                                        ),
                                        Text(controller.emptyText, style: context.textTheme.bodyMedium),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateFilterChip extends StatelessWidget {
  final void Function()? onCancel;
  final (DateTime, DateTime) dateRange;

  const DateFilterChip({
    super.key,
    this.onCancel,
    required this.dateRange,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onCancel,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: ShapeDecoration(
          color: context.colorScheme.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              AssetPaths.calendarMonth,
              color: context.colorScheme.onBackground,
              width: 20,
              height: 20,
            ),
            const SizedBox(width: 4),
            Text(
              'از ${dateRange.$1.toJalali().formatter.d} ${dateRange.$1.toJalali().formatter.mN} تا ${dateRange.$2.toJalali().formatter.d} ${dateRange.$2.toJalali().formatter.mN}',
              style: context.textTheme.bodyMedium,
            ),
            SizedBox(
              height: 18,
              child: VerticalDivider(
                width: 16,
                color: context.colorScheme.outline,
              ),
            ),
            SvgPicture.asset(AssetPaths.close),
          ],
        ),
      ),
    );
  }
}
