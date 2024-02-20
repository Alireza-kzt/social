import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/features/calendar/view/widgets/calendar_header_widget.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../../../../app/view/themes/styles/decorations.dart';
import '../../controller/date_picker_controller.dart';
import 'month_calendar_widget.dart';

class CalendarPage extends StatelessWidget {
  final DatePickerController datePickerController;

  const CalendarPage({super.key, required this.datePickerController});

  static showBottomSheet(DatePickerController controller) => Get.bottomSheet(
        CalendarPage(datePickerController: controller),
        isScrollControlled: true,
        ignoreSafeArea: false,
        persistent: false,
      );

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(height: 10),
            Divider(
              thickness: 2,
              endIndent: context.width * 0.4,
              indent: context.width * 0.4,
            ),
            SizedBox(height: 12),
            Padding(
              padding: Decorations.pagePaddingHorizontal,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AssetPaths.calendar,
                        width: 20,
                        height: 20,
                        color: context.colorScheme.onBackground,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'فیلتر کردن تاریخ',
                        style: context.textTheme.titleMedium,
                      )
                    ],
                  ),
                  Text(
                    'لطفا تاریخ شروع و پایان را انتخاب کنید',
                    style: context.textTheme.labelLarge?.copyWith(color: context.colorScheme.outline),
                  ),
                  SizedBox(height: 12.0),
                ],
              ),
            ),
            CalendarHeaderWidget(textColor: context.colorScheme.outline),
            Expanded(
              child: GetBuilder<DatePickerController>(
                  init: Get.put(datePickerController),
                  builder: (_) {
                    return ScrollablePositionedList.builder(
                      itemScrollController: datePickerController.itemScrollController,
                      initialScrollIndex: datePickerController.initialIndex,
                      initialAlignment: datePickerController.initialAlignment,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                      shrinkWrap: true,
                      itemCount: datePickerController.calendarItems.length,
                      itemBuilder: (_, monthIndex) => Padding(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: MonthCalendarWidget(
                          listOfDay: datePickerController.calendarItems[monthIndex],
                          onDatePressed: datePickerController.onDatePressed,
                          isSelected: datePickerController.isInRange,
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),
        bottomSheet: Material(
          child: Padding(
            padding: Decorations.pagePaddingHorizontal.copyWith(top: 8.0, bottom: 16),
            child: Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: context.buttonThemes.textButtonStyle(wide: true),
                    onPressed: datePickerController.onCancel,
                    child: Text('انصراف'),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    style: context.buttonThemes.elevatedButtonStyle(wide: true),
                    onPressed: datePickerController.onSubmit,
                    child: Text('انتخاب تاریخ'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
