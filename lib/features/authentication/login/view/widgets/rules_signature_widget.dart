import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';

import '../../../../../core/app/constants/messages.dart';
import '../../../../../core/app/utils/helper/text_helper.dart';

class RulesSignatureWidget extends StatelessWidget {
  final void Function()? onTap;

  const RulesSignatureWidget({
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            Messages.loginPrivacyText.split('***').first,
            style: context.textTheme.labelSmall!.copyWith(color: context.colorScheme.inverseSurface),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                Messages.loginPrivacyText.split('***')[1],
                style: context.textTheme.labelSmall!.copyWith(color: context.colorScheme.inverseSurface),
              ),
              Container(
                height: 1,
                width: textSize(Messages.loginPrivacyText.split('***')[1], context.textTheme.labelSmall!).width,
                color: context.colorScheme.inverseSurface,
              )
            ],
          ),
          Text(
            Messages.loginPrivacyText.split('***').last,
            style: context.textTheme.labelSmall!.copyWith(color: context.colorScheme.inverseSurface),
          )
        ],
      ),
    );
  }
}
