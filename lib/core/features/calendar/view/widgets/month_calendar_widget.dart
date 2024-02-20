import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';
import 'day_calendar_widget.dart';

class MonthCalendarWidget extends StatelessWidget {
  final List<Jalali> listOfDay;
  final Function(Jalali date)? onDatePressed;
  final bool Function(Jalali date) isSelected;

  const MonthCalendarWidget({
    Key? key,
    required this.listOfDay,
    this.onDatePressed,
    required this.isSelected,
  }) : super(key: key);

  Jalali get firstDay => listOfDay.first;

  String get monthName => firstDay.formatter.mN;

  List<Widget> get calendarItemWidget {
    int weekDayNoOfFirstDay = firstDay.weekDay;
    List<Widget> dayWidgets = [for (int i = 0; i < weekDayNoOfFirstDay - 1; i++) const SizedBox.shrink()];

    for (var day in listOfDay) {
      dayWidgets.add(
        DayCalendarWidget(
          date: day,
          onDatePressed: onDatePressed,
          isSelected: isSelected(day),
        ),
      );
    }

    return dayWidgets;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          monthName,
          style: context.textTheme.titleMedium,
        ),
        const SizedBox(height: 16),
        GridView.count(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 0.6,
          crossAxisSpacing: 8,
          mainAxisSpacing: 4,
          crossAxisCount: 7,
          shrinkWrap: true,
          children: calendarItemWidget,
        )
      ],
    );
  }
}
