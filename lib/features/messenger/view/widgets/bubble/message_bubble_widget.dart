import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/features/messenger/view/widgets/bubble/voice_widget.dart';
import 'package:intl/intl.dart';
import '../../../controller/voice_controller.dart';
import '../../../data/models/message_model.dart';
import '../image_message_widget.dart';
import 'file_widget.dart';

class MessagesBubbleWidget extends StatelessWidget {
  final MessagesModel message;
  final VoiceController Function(String?) voiceControllerBuilder;
  final void Function()? onTap;
  final void Function(Offset)? onLongPress;
  final void Function(String?)? onPlayVoice;

  const MessagesBubbleWidget({
    Key? key,
    required this.message,
    this.onTap,
    this.onLongPress,
    this.onPlayVoice,
    required this.voiceControllerBuilder,
  }) : super(key: key);

  VoiceController get voiceController => voiceControllerBuilder(media);

  String get timeText => DateFormat('kk:mm').format(message.time.dateTime);

  String get text => message.text;

  String get media => message.media!;

  Color bubbleFillColor(BuildContext context) {
    if (message.isOwner) {
      return context.colorScheme.primaryContainer.withOpacity(0.7);
    } else {
      return context.colorScheme.onBackground.withOpacity(0.03);
    }
  }

  Color bubbleStrokeColor(BuildContext context) {
    if (message.isOwner) {
      return context.colorScheme.onPrimaryContainer.withOpacity(0.2);
    } else {
      return context.colorScheme.onBackground.withOpacity(0.09);
    }
  }

  Color sendDateColor(BuildContext context) {
    if (message.isOwner) {
      return context.colorScheme.onPrimaryContainer.withOpacity(0.4);
    } else {
      return context.colorScheme.outline;
    }
  }

  Color subtitleColor(BuildContext context) {
    if (message.isOwner) {
      return context.colorScheme.onPrimaryContainer.withOpacity(0.6);
    } else {
      return context.colorScheme.outline;
    }
  }

  Color voiceFixColor(BuildContext context) {
    if (message.isOwner) {
      return context.colorScheme.primary;
    } else {
      return context.colorScheme.primary;
    }
  }

  BorderRadius get bubbleBoarder {
    if (message.isOwner) {
      return const BorderRadius.all(Radius.circular(13)).copyWith(bottomRight: Radius.zero);
    } else {
      return const BorderRadius.all(Radius.circular(13)).copyWith(bottomLeft: Radius.zero);
    }
  }

  TextStyle messageTextStyle(BuildContext context) {
    if (message.isOwner) {
      return context.textTheme.labelLarge!;
    } else {
      return context.textTheme.labelLarge!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            alignment: message.isOwner ? Alignment.topRight : Alignment.topLeft,
            color: Colors.transparent,
            child: Container(
              constraints: BoxConstraints(maxWidth: context.width * 0.7),
              padding: EdgeInsets.symmetric(horizontal: message.mediaType == MediaType.image ? 4 : 16, vertical: 2),
              decoration: BoxDecoration(
                borderRadius: bubbleBoarder,
                color: bubbleFillColor(context),
                border: Border.all(color: bubbleStrokeColor(context), width: 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  switch (message.mediaType) {
                    MediaType.file => FileWidget(
                        displayMediaName: message.displayMediaName,
                        fileUrl: media,
                        iconBackgroundColor: context.colorScheme.primary.withOpacity(0.1),
                        color: context.colorScheme.onBackground,
                        iconColor: context.colorScheme.primary,
                        showProgress: message.id == null,
                        subtitleColor: subtitleColor(context),
                      ),
                    MediaType.image => ImageMessageView(
                        onTap: onTap,
                        imageUrl: media,
                        borderRadius: bubbleBoarder,
                      ),
                    MediaType.audio => kIsWeb
                        ? FileWidget(
                            displayMediaName: message.displayMediaName,
                            fileUrl: media,
                            iconBackgroundColor: context.colorScheme.primary.withOpacity(0.1),
                            color: context.colorScheme.onBackground,
                            iconColor: context.colorScheme.primary,
                            showProgress: message.id == null,
                            subtitleColor: subtitleColor(context),
                          )
                        : VoiceWidget(
                            displayMediaName: message.displayMediaName,
                            voiceController: voiceController,
                            iconColor: context.colorScheme.primary,
                            iconBackgroundColor: context.colorScheme.primary.withOpacity(0.1),
                            subtitleColor: subtitleColor(context),
                          ),
                    MediaType.video => FileWidget(
                        displayMediaName: message.displayMediaName,
                        fileUrl: media,
                        iconBackgroundColor: context.colorScheme.primary.withOpacity(0.1),
                        color: context.colorScheme.onBackground,
                        iconColor: context.colorScheme.primary,
                        showProgress: message.id == null,
                        subtitleColor: subtitleColor(context),
                      ),
                    MediaType.invalid => const SizedBox(),
                  },
                  if (text.isNotEmpty)
                    SelectableText(
                      text,
                      style: messageTextStyle(context),
                    ),
                  const SizedBox(height: 4),
                  if (message.id != null)
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          timeText,
                          style: context.theme.textTheme.labelSmall?.copyWith(color: sendDateColor(context)),
                        ),
                      ],
                    )
                  else
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.access_time,
                          color: sendDateColor(context),
                          size: 12,
                        ),
                        const SizedBox(width: 2),
                        Text(
                          timeText,
                          style: context.theme.textTheme.labelSmall?.copyWith(color: sendDateColor(context)),
                        ),
                      ],
                    )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
