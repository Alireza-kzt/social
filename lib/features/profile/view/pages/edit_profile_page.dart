import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/colors/color_schemes.dart';
import 'package:social/core/app/view/themes/styles/decorations.dart';
import 'package:social/core/app/view/widgets/input/input.dart';

import '../../../../core/app/config/app_setting.dart';
import '../../../../core/app/constants/assets_paths.dart';
import '../../controller/edit_profile_controller.dart';
import '../../controller/upload_profile_controller.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ویرایش پروفایل')),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(Decorations.paddingHorizontal),
        child: ElevatedButton(
          onPressed: EditProfileController.to.editProfile,
          style: context.buttonThemes.elevatedButtonStyle(),
          child: const Text('ثبت تغییرات'),
        ),
      ),
      body: SingleChildScrollView(
        padding: Decorations.pagePaddingHorizontal,
        child: Theme(
          data: context.theme.copyWith(
            inputDecorationTheme: context.theme.inputDecorationTheme.copyWith(
              enabledBorder: UnderlineInputBorder(
                borderRadius: Decorations.inputBorderRadius,
                borderSide: BorderSide(color: lightColorScheme.surface, width: Decorations.inputStrokeWidth),
              ),
              disabledBorder: UnderlineInputBorder(
                borderRadius: Decorations.inputBorderRadius,
                borderSide: BorderSide(color: lightColorScheme.surfaceVariant, width: Decorations.inputStrokeWidth),
              ),
              focusedBorder: UnderlineInputBorder(
                borderRadius: Decorations.inputBorderRadius,
                borderSide: BorderSide(color: lightColorScheme.primary, width: Decorations.inputStrokeWidth),
              ),
              errorBorder: UnderlineInputBorder(
                borderRadius: Decorations.inputBorderRadius,
                borderSide: BorderSide(color: lightColorScheme.error, width: Decorations.inputStrokeWidth),
              ),
              focusedErrorBorder: UnderlineInputBorder(
                borderRadius: Decorations.inputBorderRadius,
                borderSide: BorderSide(color: lightColorScheme.primary, width: Decorations.inputStrokeWidth),
              ),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              GestureDetector(
                onTap: () => UploadProfileController.to.onFileButtonPressed(fileType: FileType.image),
                child: Column(
                  children: [
                    Hero(
                      tag: EditProfileController.to.model.avatarImage.toString(),
                      child: EditProfileController.to.model.avatarImage != null
                          ? Container(
                              height: 112,
                              width: 112,
                              decoration: BoxDecoration(
                                color: context.colorScheme.primaryContainer,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 1,
                                  color: context.colorScheme.surface,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: CachedNetworkImageProvider(
                                    '${AppSetting.baseUrl}/doctor/file/${EditProfileController.to.model.avatarImage}',
                                  ),
                                ),
                              ),
                            )
                          : SvgPicture.asset(
                              AssetPaths.avatar,
                              height: 112,
                              width: 112,
                            ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'ویرایش نمایه کاربری',
                      style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.primary),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'نام و نام خانوادگی',
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Input(
                      enabled: false,
                      controller: EditProfileController.to.usernameTextEditingController,
                      inputSize: InputSize.small(context).copyWith(
                        textStyle: context.textTheme.bodyMedium,
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'تخصص',
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Input(
                      controller: EditProfileController.to.expertiseTextEditingController,
                      inputSize: InputSize.small(context).copyWith(
                        textStyle: context.textTheme.bodyMedium,
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Text(
                      'ش.نظام پزشکی',
                      style: context.textTheme.bodyLarge,
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Input(
                      controller: EditProfileController.to.medicalNumberTextEditingController,
                      inputSize: InputSize.small(context).copyWith(
                        textStyle: context.textTheme.bodyMedium,
                        padding: const EdgeInsets.all(8.0),
                      ),
                    ),
                  ),
                ],
              ),
              // const SizedBox(height: 16),
              // Stack(
              //   children: [
              //     Row(
              //       children: [
              //         Expanded(
              //           flex: 3,
              //           child: Align(
              //             alignment: Alignment.topRight,
              //             child: Text(
              //               'بیوگرافی',
              //               style: context.textTheme.bodyLarge,
              //             ),
              //           ),
              //         ),
              //         Spacer(flex: 5)
              //       ],
              //     ),
              //     Row(
              //       children: [
              //         const Spacer(flex: 3),
              //         Expanded(
              //           flex: 5,
              //           child: Input(
              //             controller: EditProfileController.to.biographyTextEditingController,
              //             inputSize: InputSize.small(context).copyWith(
              //               textStyle: context.textTheme.bodyMedium,
              //               padding: const EdgeInsets.all(8.0),
              //             ),
              //           ),
              //         ),
              //       ],
              //     ),
              //   ],
              // ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }
}
