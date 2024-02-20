import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

enum PinState { error, success, normal }

class PinWidget extends StatelessWidget {
  final ValueChanged<String>? onCompleted;
  final ValueChanged<String>? onChanged;
  final PinState state;
  final TextEditingController? controller;
  final int length;
  final bool obscureText;
  final bool readOnly;
  final double size;
  final PinCodeFieldShape pinCodeFieldShape;
  final Color? activeColor;
  final Color? fillColor;

  const PinWidget({
    Key? key,
    this.onCompleted,
    this.onChanged,
    this.state = PinState.normal,
    this.controller,
    this.length = 5,
    this.obscureText = false,
    this.readOnly = false,
    this.size = 50,
    this.pinCodeFieldShape = PinCodeFieldShape.box,
    this.activeColor,
    this.fillColor,
  }) : super(key: key);

  Color boarderColor(PinState state) {
    switch (state) {
      case PinState.normal:
        return activeColor ?? Get.theme.colorScheme.primary;
      case PinState.error:
        return Get.theme.colorScheme.error;
      case PinState.success:
        return const Color.fromRGBO(84, 215, 113, 1);
      default:
        return activeColor ?? Get.theme.colorScheme.primary;
    }
  }

  Color innerColor(PinState state) {
    switch (state) {
      case PinState.normal:
        return fillColor ?? Get.theme.scaffoldBackgroundColor;
      case PinState.error:
        return Get.theme.colorScheme.error.withOpacity(0.1);
      case PinState.success:
        return const Color.fromRGBO(84, 215, 113, 1).withOpacity(0.1);
      default:
        return Get.theme.scaffoldBackgroundColor;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: PinCodeTextField(
        readOnly: readOnly,
        enablePinAutofill: true,
        controller: controller,
        keyboardType: TextInputType.number,
        textStyle: context.textTheme.titleMedium,
        showCursor: false,
        length: length,
        obscureText: obscureText,
        obscuringWidget: obscureText
            ? Container(
                height: 16,
                width: 16,
                decoration: BoxDecoration(color: context.colorScheme.onSurfaceVariant, shape: BoxShape.circle),
              )
            : null,
        animationType: AnimationType.fade,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        pinTheme: PinTheme(
          activeColor: boarderColor(state),
          disabledColor: Get.theme.colorScheme.surface,
          inactiveColor: Get.theme.colorScheme.surface,
          selectedColor: boarderColor(state),
          borderWidth: 1,
          shape: pinCodeFieldShape,
          borderRadius: BorderRadius.circular(16),
          fieldHeight: size,
          fieldWidth: size,
          inactiveFillColor: innerColor(state),
          selectedFillColor: innerColor(state),
          activeFillColor: innerColor(state),
        ),
        animationDuration: const Duration(milliseconds: 300),
        onCompleted: onCompleted,
        onChanged: onChanged ?? (_) {},
        enableActiveFill: true,
        appContext: context,
      ),
    );
  }
}
