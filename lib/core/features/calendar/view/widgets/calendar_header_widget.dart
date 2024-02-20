import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';

import '../../../../app/constants/messages.dart';

class CalendarHeaderWidget extends StatelessWidget {
  final Color textColor;
  final bool showDivider;
  final EdgeInsets? padding;
  final TextStyle? textStyle;

  const CalendarHeaderWidget({
    Key? key,
    required this.textColor,
    this.showDivider = true,
    this.padding,
    this.textStyle,
  }) : super(key: key);

  static List<String> jalaliWeekDay = [
    Messages.sa,
    Messages.su,
    Messages.mo,
    Messages.tu,
    Messages.we,
    Messages.th,
    Messages.fr,
  ];

  static List<String> gregorianWeekDay = [
    Messages.mo,
    Messages.tu,
    Messages.we,
    Messages.th,
    Messages.fr,
    Messages.sa,
    Messages.su,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: padding ?? const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (context.isLtr)
                for (int i = 0; i < gregorianWeekDay.length; i++)
                  Flexible(
                    flex: 1,
                    child: Text(
                      gregorianWeekDay[i],
                      textAlign: TextAlign.center,
                      style: (textStyle ?? context.textTheme.labelLarge)?.copyWith(color: textColor),
                    ),
                  )
              else
                for (int i = 0; i < jalaliWeekDay.length; i++)
                  Flexible(
                    flex: 1,
                    child: Align(
                      alignment: i == 0
                          ? Alignment.centerRight
                          : i == jalaliWeekDay.length - 1
                              ? Alignment.centerLeft
                              : Alignment.center,
                      child: Padding(
                        padding: EdgeInsets.only(left: i == 1 || i == 2 ? 8 : 0, right: i == 5 ? 8 : 0),
                        child: Text(
                          jalaliWeekDay[i],
                          textAlign: TextAlign.center,
                          style: (textStyle ?? context.textTheme.labelLarge)?.copyWith(color: textColor),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        if (showDivider) Divider(height: 1, color: context.colorScheme.surface),
      ],
    );
  }
}
