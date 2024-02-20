import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';

class StartupHeaderWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final String? backgroundImage;
  final EdgeInsets? padding;
  final Widget? topImage;
  final Widget? bottomImage;
  final Widget? iconButton;
  final Widget? image;
  final Widget? progress;
  final double? imageHeight;

  const StartupHeaderWidget({
    super.key,
    this.title,
    this.description,
    this.padding,
    this.iconButton,
    this.image,
    this.progress,
    this.topImage,
    this.bottomImage,
    this.backgroundImage,
    this.imageHeight,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Positioned(
          top: -Get.mediaQuery.padding.top,
          left: -16,
          right: -16,
          child: Container(
            width: 500,
            height: imageHeight ?? 350,
            decoration: BoxDecoration(
              image: backgroundImage != null
                  ? DecorationImage(
                      image: AssetImage(backgroundImage!),
                      fit: BoxFit.fitWidth,
                    )
                  : null,
            ),
          ),
        ),
        Padding(
          padding: padding ?? EdgeInsets.zero,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              iconButton != null ? RotatedBox(quarterTurns: context.isLtr ? 2 : 0, child: iconButton) : const SizedBox(),
              topImage ?? const SizedBox(height: 20),
              Align(
                alignment: Alignment.center,
                child: image,
              ),
              bottomImage ?? const SizedBox(height: 20),
              if (title != null)
                Text(
                  title!,
                  style: context.textTheme.headlineMedium,
                ),
              if (description != null) const SizedBox(height: 4),
              if (description != null)
                Text(
                  description!,
                  style: context.textTheme.bodyMedium!.copyWith(color: context.colorScheme.onSurfaceVariant),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
