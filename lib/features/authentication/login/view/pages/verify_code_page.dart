import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:intl/intl.dart';
import '../../../../../core/app/constants/assets_paths.dart';
import '../../../../../core/app/constants/messages.dart';
import '../../../../../core/app/view/themes/styles/buttons/button_types.dart';
import '../../../../../core/app/view/themes/styles/buttons/icon_button__style.dart';
import '../../../../../core/app/view/widgets/animations/position_animations.dart';
import '../../../../../core/app/view/widgets/loading_indicator_widget.dart';
import '../../controller/resend_code_controller.dart';
import '../../controller/verify_code_controller.dart';
import '../widgets/pin_widget.dart';
import '../widgets/startup_header_widget.dart';
import '../widgets/startup_template_widget.dart';

class VerifyCodePage extends StatelessWidget {
  const VerifyCodePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StartupTemplateWidget(
      isScroll: false,
      header: StartupHeaderWidget(
        title: Messages.verifyPhoneNumber
            .replaceAll('@platform', GetUtils.isEmail(VerifyCodeController.to.username) ? Messages.email : Messages.phoneNumber),
        description: (GetUtils.isEmail(VerifyCodeController.to.username)
                ? Messages.verifyEmailDescription.trParams({'user': VerifyCodeController.to.username})
                : Messages.verifyPhoneNumberDescription)
            .replaceAll('***', VerifyCodeController.to.username),
        image: Image.asset(AssetPaths.verify),
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
      content: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Obx(
              () => PinWidget(
                length: 6,
                controller: VerifyCodeController.to.pinController,
                onChanged: VerifyCodeController.to.onPinChanged,
                state: VerifyCodeController.to.pinState.value,
                onCompleted: VerifyCodeController.to.setIdentity,
              ),
            ),
          ),
        ],
      ),
      footer: Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Obx(
          () {
            if (ResendCodeController.to.timeOut.value == 0) {
              return PositionAnimations.bottom(
                animationController: ResendCodeController.to.resendButtonController,
                curve: Curves.easeOutBack,
                child: ElevatedButton(
                  style: context.buttonThemes.elevatedButtonStyle(size: ButtonSizes.small),
                  onPressed: ResendCodeController.to.resendCode,
                  child: Text(Messages.notReceiveCode),
                ),
              );
            } else {
              return ResendCodeController.to.obx(
                (_) => Obx(
                  () => Text(
                    '${Messages.notReceiveCode}(00:${NumberFormat("00").format(ResendCodeController.to.timeOut.value)})',
                    style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.onSurface),
                  ),
                ),
                onLoading: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 56),
                  child: LoadingIndicatorWidget(),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
