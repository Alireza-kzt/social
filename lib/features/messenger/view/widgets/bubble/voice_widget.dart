import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import '../../../../../core/app/view/themes/styles/decorations.dart';
import '../../../controller/voice_controller.dart';
import 'download_progress_widget.dart';

class VoiceWidget extends StatelessWidget {
  final VoiceController voiceController;
  final Color? iconColor;
  final Color? iconBackgroundColor;
  final Color? subtitleColor;
  final String? displayMediaName;

  const VoiceWidget({
    Key? key,
    required this.voiceController,
    this.iconColor,
    this.iconBackgroundColor,
    this.displayMediaName, this.subtitleColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FileResponse>(
      stream: voiceController.fileStream,
      builder: (context, snapshot) {
        SchedulerBinding.instance.addPostFrameCallback((_) {
          if(voiceController.audioState.value != AudioState.ready) {
            if (snapshot.hasError) {
              voiceController.audioState.value = AudioState.error;
            } else if (!snapshot.hasData || snapshot.data is DownloadProgress) {
              voiceController.audioState.value = AudioState.loading;
            } else {
              voiceController.audioState.value = AudioState.prepare;
              FileInfo fileInfo = snapshot.data as FileInfo;
              voiceController.preparePlayer(file: fileInfo.file).then((_) => voiceController.audioState.value = AudioState.ready);
            }
          }
        });

        return Padding(
          padding: const EdgeInsets.only(top: 16.0),
          child: Obx(
            () {
              switch (voiceController.audioState.value) {
                case AudioState.error:
                  return IconButton(
                    onPressed: null,
                    icon: const Icon(Icons.error, size: 32),
                    color: context.colorScheme.onPrimary,
                  );
                case AudioState.loading:
                case AudioState.prepare:
                  return Row(
                    children: [
                      const Spacer(),
                      const SizedBox(width: 8),
                      DownloadProgressWidget(
                        isLoading: true,
                        progressColor: context.colorScheme.onPrimary,
                        innerColor: iconColor ?? Colors.white30,
                      ),
                    ],
                  );
                case AudioState.ready:
                  return Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                displayMediaName ?? '',
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textDirection: TextDirection.ltr,
                                style: Get.context!.textTheme.labelSmall!.copyWith(color: context.colorScheme.onBackground),
                              ),
                              const SizedBox(height: 2),
                              Builder(builder: (context) {
                                return Text(
                                  voiceController.size.value,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Decorations.subtitle.copyWith(color: subtitleColor),
                                );
                              }),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        style: ElevatedButton.styleFrom(backgroundColor: iconBackgroundColor),
                        onPressed: voiceController.onVoiceTap,
                        color: iconColor ?? context.colorScheme.onPrimary,
                        icon: Icon(
                          voiceController.playState.value == PlayState.play ? Icons.pause_rounded : Icons.play_arrow_rounded,
                          size: 32,
                        ),
                      ),
                    ],
                  );
              }
            },
          ),
        );
      },
    );
  }
}
