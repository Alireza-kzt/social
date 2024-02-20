import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shamsi_date/shamsi_date.dart';
import '../../../../app/view/widgets/check_box/check_radio_widget.dart';

class DayCalendarWidget extends StatelessWidget {
  final Jalali date;
  final bool isSelected;
  final Function(Jalali date)? onDatePressed;

  DayCalendarWidget({
    Key? key,
    required this.date,
    required this.onDatePressed,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onDatePressed?.call(date),
      behavior: HitTestBehavior.translucent,
      child: Column(
        children: [
          Text(
            date.day.toString(),
            style: context.textTheme.bodyMedium,
          ),
          const SizedBox(height: 4),
          CheckRadioWidget(isSelected: isSelected),
        ],
      ),
    );
  }
}
