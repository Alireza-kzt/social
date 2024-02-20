import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import '../../../../app/constants/assets_paths.dart';
import '../../../../app/constants/messages.dart';
import '../../controller/notification_controller.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  static Future showBottomSheet() => Get.bottomSheet(
        const NotificationPage(),
        isScrollControlled: true,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16).copyWith(top: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            OutlinedButton(
              style: context.buttonThemes.outlineButtonStyle(wide: true),
              onPressed: Get.back,
              child: Text(Messages.notNow),
            ),
            const SizedBox(height: 8),
            ElevatedButton(
              style: context.buttonThemes.elevatedButtonStyle(wide: true),
              onPressed: NotificationController.requestPermission,
              child: Text(Messages.notificationPermission),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Image.asset(
                AssetPaths.notificationCoverImage,
                fit: BoxFit.fitWidth,
                width: context.width,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0).copyWith(top: 12),
              child: FittedBox(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Divider(height: 0, thickness: 3, endIndent: context.width * 0.38, indent: context.width * 0.38),
                    const SizedBox(height: 24),
                    Text(
                      Messages.notificationPermissionTitle,
                      style: context.textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 8),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        SvgPicture.asset(
                          AssetPaths.edit,
                          colorFilter: ColorFilter.mode(context.colorScheme.primary, BlendMode.srcIn),
                          width: 18,
                          height: 18,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          Messages.notificationValueForPermission2,
                          style: context.textTheme.labelLarge,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
