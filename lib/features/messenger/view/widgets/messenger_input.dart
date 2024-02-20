import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/packages/chat_composer/lib/chat_composer.dart';

import '../../../../core/app/view/themes/styles/decorations.dart';

class MessengerInput extends StatelessWidget {
  final void Function() onSendPressed;
  final void Function() onAttachFileAddPressed;
  final TextEditingController messageTextEditingController;
  final Function(String?)? onRecordEnd;

  const MessengerInput({
    Key? key,
    required this.onSendPressed,
    required this.messageTextEditingController,
    required this.onAttachFileAddPressed,
    this.onRecordEnd,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        kIsWeb
            ? Padding(
                padding: Decorations.pagePaddingHorizontal.copyWith(top: 8, bottom: 8),
                child: Row(
                  children: [
                    IconButton(
                      onPressed: onSendPressed,
                      icon: RotatedBox(
                        quarterTurns: 2,
                        child: SvgPicture.asset(
                          AssetPaths.sendComment,
                          color: context.colorScheme.onPrimary,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: context.colorScheme.primary,
                        padding: EdgeInsets.all(12.0),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: messageTextEditingController,
                        maxLines: 3,
                        minLines: 1,
                        style: context.textTheme.bodyLarge,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'پیامت رو بنویس...',
                          hintTextDirection: TextDirection.rtl,
                          hintStyle: context.textTheme.bodyLarge!.copyWith(color: context.colorScheme.outlineVariant),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: IconButton(
                              onPressed: onAttachFileAddPressed,
                              icon: SvgPicture.asset(AssetPaths.addFile, color: context.colorScheme.primary),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Directionality(
                textDirection: TextDirection.ltr,
                child: ChatComposer(
                  maxRecordLength: Duration(minutes: 60),
                  // enabledBorder: context.theme.inputDecorationTheme.enabledBorder,
                  // focusedBorder: context.theme.inputDecorationTheme.focusedBorder,
                  cancelText: 'برای انصراف بکشید',
                  recordIconColor: context.colorScheme.onPrimary,
                  onReceiveText: onSendPressed,
                  onRecordEnd: (String? path) => onRecordEnd?.call(path),
                  controller: messageTextEditingController,
                  textStyle: context.textTheme.bodyLarge,
                  keyboardType: TextInputType.multiline,
                  backgroundColor: context.colorScheme.background,
                  sendButtonBackgroundColor: context.colorScheme.primary,
                  composerColor: context.colorScheme.background,
                  textFieldDecoration: InputDecoration(
                    hintText: 'پیامت رو بنویس...',
                    hintTextDirection: TextDirection.rtl,
                    hintStyle: context.textTheme.bodyLarge!.copyWith(color: context.colorScheme.outlineVariant),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                    prefixIcon: IconButton(
                      onPressed: onAttachFileAddPressed,
                      icon: SvgPicture.asset(AssetPaths.addFile, color: context.colorScheme.primary),
                    ),
                  ),
                ),
              )
      ],
    );
  }
}
