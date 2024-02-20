import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/widgets/loading_indicator_widget.dart';

import '../../../../core/app/constants/assets_paths.dart';
import '../../../../core/app/view/themes/styles/decorations.dart';
import '../../controller/activation_profile_controller.dart';
import '../../data/models/setting_model.dart';
import '../widgets/switch_list_title.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('فعالیت شما'),
        leading: IconButton(
          icon: SvgPicture.asset(AssetPaths.arrowRight, color: context.colorScheme.outline),
          onPressed: Get.back,
        ),
      ),
      body: ActivationProfileController.to.obx(
        (setting) {
          return SingleChildScrollView(
            padding: Decorations.pagePaddingHorizontal.copyWith(top: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('از این قسمت می‌تونی وضعیت خودت رو در اپلیکیشن ایمپو کاربران مشخص کنی', style: context.textTheme.bodyMedium),
                const SizedBox(height: 24),
                SettingSwitchListTile(
                  isDisable: setting!.activity.value == ActivityStatus.disable,
                  value: setting.isOnline,
                  onChanged: ActivationProfileController.to.onActivitySwitch,
                  title: 'آنلاین/آفلاین',
                  description:
                      'با انتخاب حالت آنلاین ، اسم شما بصورت تصادفی و پیشفرض در کلینیک نمایش داده می‌شود اما با انتخاب حالت آفلاین، کاربر باید نام شما را در قسمت تغییر مشاور جستجو کند تا بتواند شما را انتخاب کند',
                ),
                SettingSwitchListTile(
                  isDisable: setting.activation.value == ActivityStatus.disable,
                  value: setting.isActive,
                  onChanged: ActivationProfileController.to.onActivationSwitch,
                  title: 'فعال/غیرفعال',
                  description:
                      'با روشن کردن این دکمه نام شما در  قسمت کلینیک اپلیکیشن ایمپو به کاربران نمایش داده می‌شود اما درصورتیکه بخواهید برای چندساعت یا چند روز در اپلیکیشن فعالیتی نداشته باشید باید این دکمه را به حالت غیرفعال تغییر دهید',
                ),
              ],
            ),
          );
        },
        onLoading: Center(child: LoadingIndicatorWidget(color: context.colorScheme.primary)),
      ),
    );
  }
}
