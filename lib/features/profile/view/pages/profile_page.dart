import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/constants/app_routes.dart';
import 'package:social/core/app/constants/assets_paths.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/styles/buttons/button_icon/outline_button_icon.dart';
import 'package:social/core/app/view/themes/styles/buttons/button_types.dart';
import 'package:social/core/app/view/widgets/loading_indicator_widget.dart';

import '../../../../core/app/config/app_setting.dart';
import '../../../../core/app/view/themes/styles/decorations.dart';
import '../../controller/profile_controller.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ProfileController.to.obx(
        (profile) {
          return Padding(
            padding: Decorations.pagePaddingHorizontal,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        width: 0.50,
                        color: context.colorScheme.surface,
                      ),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Hero(
                        tag: profile!.avatarImage.toString(),
                        child: profile.avatarImage != null
                            ? CircleAvatar(
                                backgroundImage: CachedNetworkImageProvider('${AppSetting.baseUrl}/doctor/file/${profile.avatarImage}'),
                                radius: 40,
                              )
                            : SvgPicture.asset(
                                AssetPaths.avatar,
                                height: 80,
                                width: 80,
                              ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        profile.username,
                        style: context.textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            profile.expertise,
                            style: context.textTheme.labelLarge,
                          ),
                          SizedBox(
                            height: 15,
                            width: 8,
                            child: VerticalDivider(
                              color: context.colorScheme.onInverseSurface,
                            ),
                          ),
                          Text(
                            'ش.ن: ${profile.medicalNumber}',
                            style: context.textTheme.labelLarge,
                          ),
                        ],
                      ),
                      Text(profile.biography),
                      const SizedBox(height: 12),
                      OutlinedButtonIcon(
                        color: ButtonColors.surface,
                        wide: true,
                        label: const Text('ویرایش پروفایل'),
                        icon: SvgPicture.asset(
                          AssetPaths.editUnderline,
                          color: context.colorScheme.onBackground,
                        ),
                        onPressed: () => ProfileController.to.editProfile(profile),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () => Get.toNamed(AppRoutes.activity),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 9),
                    decoration: ShapeDecoration(
                      color: context.colorScheme.surface,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          AssetPaths.warning,
                          color: context.colorScheme.inverseSurface,
                        ),
                        const SizedBox(width: 4),
                        const Text('فعالیت در مجموعه'),
                        const Spacer(),
                        SvgPicture.asset(
                          AssetPaths.left,
                          color: context.colorScheme.inverseSurface,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        },
        onLoading: Center(child: LoadingIndicatorWidget(color: context.colorScheme.primary)),
      ),
    );
  }
}
