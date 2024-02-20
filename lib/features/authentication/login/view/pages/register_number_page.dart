import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/features/authentication/login/view/widgets/startup_template_widget.dart';
import '../../../../../core/app/constants/assets_paths.dart';
import '../../../../../core/app/constants/messages.dart';
import '../../../../../core/app/view/themes/styles/buttons/button_types.dart';
import '../../../../../core/app/view/themes/styles/buttons/icon_button__style.dart';
import '../../../../../core/app/view/widgets/input/input.dart';
import '../../../../../core/app/view/widgets/loading_indicator_widget.dart';
import '../../controller/register_number_controller.dart';
import '../widgets/startup_header_widget.dart';

class RegisterNumberPage extends StatelessWidget {
  const RegisterNumberPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StartupTemplateWidget(
      isScroll: true,
      header: StartupHeaderWidget(
        title: Messages.enterNumber,
        description: Messages.enterNumberDescription,
        padding: const EdgeInsets.only(bottom: 16),
        image: Image.asset(AssetPaths.phoneNumber),
        iconButton: IconButton(
          onPressed: Get.back,
          icon: SvgPicture.asset(
            AssetPaths.arrowRight,
            colorFilter: ColorFilter.mode(context.colorScheme.onSurface, BlendMode.srcIn),
          ),
          color: context.colorScheme.onSurface,
          style: IconButtonStyle.of(context).outlineStyle(color: ButtonColors.surface),
        ),
      ),
      content: Form(
        key: RegisterNumberController.to.formKey,
        child: Input(
          key: Key(Messages.numberInputHintText),
          controller: RegisterNumberController.to.phoneNumberTextEditingController,
          validator: RegisterNumberController.to.phoneNumberValidation,
          keyboardType: TextInputType.number,
          autofocus: true,
          hintText: 'شماره همراه',
          maxLength: 11,
        ),
      ),
      footer: RegisterNumberController.to.obx(
        (_) => ElevatedButton(
          style: context.buttonThemes.elevatedButtonStyle(wide: true),
          onPressed: RegisterNumberController.to.onNextStepPressed,
          child: Text(Messages.continueStep),
        ),
        onLoading: ElevatedButton(
          style: context.buttonThemes.elevatedButtonStyle(wide: true),
          onPressed: () {},
          child: const LoadingIndicatorWidget(),
        ),
        onEmpty: ElevatedButton(
          style: context.buttonThemes.elevatedButtonStyle(wide: true),
          onPressed: null,
          child: Text(Messages.continueStep),
        ),
      ),
    );
  }
}
