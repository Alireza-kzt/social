import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import '../../../../../core/app/constants/messages.dart';

class OrDividerWidget extends StatelessWidget {
  const OrDividerWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const Divider(),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: context.colorScheme.background,
            shape: BoxShape.circle,
          ),
          child: Text(Messages.or, style: context.textTheme.labelLarge),
        )
      ],
    );
  }
}
