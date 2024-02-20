import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/classes/validation.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/themes/styles/decorations.dart';
import '../../../../../core/app/constants/assets_paths.dart';
import '../../../../../core/app/constants/messages.dart';
import '../../../../../core/app/view/widgets/input/input.dart';
import '../../../../../core/app/view/widgets/loading_indicator_widget.dart';
import '../../controller/new_password_controller.dart';
import '../widgets/startup_header_widget.dart';

class NewPasswordPage extends StatelessWidget {
  const NewPasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomSheet: Material(
        color: context.colorScheme.background,
        child: Padding(
          padding: Decorations.pagePaddingHorizontal.copyWith(bottom: 16),
          child: NewPasswordController.to.obx(
            (_) => ElevatedButton(
              style: context.buttonThemes.elevatedButtonStyle(wide: true),
              onPressed: NewPasswordController.to.changePassword,
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
        ),
      ),
      body: Padding(
        padding: Decorations.pagePaddingHorizontal,
        child: Column(
          children: [
            const Spacer(flex: 2),
            StartupHeaderWidget(
              title: Messages.newPassword,
              description: Messages.enterNewPasswordDescription,
              padding: const EdgeInsets.only(bottom: 16),
            ),
            Form(
              key: NewPasswordController.to.formKey,
              child: Column(
                children: [
                  Input(
                    controller: NewPasswordController.to.password,
                    hintText: Messages.newPassword,
                    validator: Validation.passwordValidator,
                  ),
                  const SizedBox(height: 8),
                  Input(
                    controller: NewPasswordController.to.repeatPassword,
                    hintText: Messages.repeatNewPasswordInputHintText,
                    suffixIcon: SvgPicture.asset(AssetPaths.lock, color: context.colorScheme.surface),
                    validator: Validation.passwordValidator,
                  ),
                ],
              ),
            ),
            const Spacer(flex: 5),
          ],
        ),
      ),
    );
  }
}
