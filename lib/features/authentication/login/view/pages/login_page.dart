import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/classes/validation.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import '../../../../../core/app/constants/assets_paths.dart';
import '../../../../../core/app/constants/messages.dart';
import '../../../../../core/app/view/themes/styles/decorations.dart';
import '../../../../../core/app/view/widgets/input/input.dart';
import '../../controller/login_controller.dart';
import '../../../../../core/app/view/widgets/loading_indicator_widget.dart';
import '../widgets/startup_header_widget.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomSheet: Material(
        color: context.colorScheme.background,
        child: Padding(
          padding: Decorations.pagePaddingHorizontal.copyWith(bottom: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextButton(
                onPressed: LoginController.to.forgotPassword,
                style: context.buttonThemes.textButtonStyle(wide: true),
                child: Text(Messages.forgotPassword),
              ),
              const SizedBox(height: 8),
              LoginController.to.obx(
                (_) => ElevatedButton(
                  style: context.buttonThemes.elevatedButtonStyle(wide: true),
                  onPressed: LoginController.to.setIdentity,
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
            ],
          ),
        ),
      ),
      body: Padding(
        padding: Decorations.pagePaddingHorizontal,
        child: Column(
          children: [
            const Spacer(),
            StartupHeaderWidget(
              title: Messages.welcomeMessage,
              description: Messages.welcomeDescription,
              padding: const EdgeInsets.only(bottom: 16),
              // image: Container(height: double.infinity),
            ),
            Form(
              key: LoginController.to.formKey,
              child: Column(
                children: [
                  Input(
                    controller: LoginController.to.userIdentityTextEditingController,
                    validator: Validation.requiredTextField,
                    keyboardType: TextInputType.number,
                    autofocus: true,
                    hintText: Messages.numberInputHintText,
                    maxLength: 11,
                  ),
                  const SizedBox(height: 8),
                  Input(
                    validator: Validation.passwordValidator,
                    controller: LoginController.to.passwordTextEditingController,
                    hintText: Messages.password,
                    suffixIcon: SvgPicture.asset(
                      AssetPaths.lock,
                      color: context.colorScheme.surface,
                    ),
                  ),
                  // const Spacer(flex: 2)
                ],
              ),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
