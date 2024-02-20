import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';

import '../../../constants/app_routes.dart';
import '../../../constants/assets_paths.dart';
import '../../themes/theme.dart';
import '../circle_button_widget.dart';

class StatesAppBar extends StatelessWidget {
  final int? state;
  final Widget? customAction;
  final Widget? customLeading;
  final Widget? centerWidget;
  final bool? reverseColors;
  final String? title;

  const StatesAppBar({
    Key? key,
    this.state,
    this.customAction,
    this.customLeading,
    this.centerWidget,
    this.reverseColors,
    this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return checkCurrentState(context);
  }

  Widget checkCurrentState(BuildContext context) {
    switch (state) {
      case 1:
        return state1(context);
      case 2:
        return state2(context);
      case 3:
        return state3(context);
      case 4:
        return state4(context);
      case 5:
        return state5(context);
      default:
        return centerWidget == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  customLeading ?? rightItems(context, backIcon: false, logoType: true),
                  customAction ?? leftItems(context, isTransparent: false, reverseColors: reverseColors),
                ],
              )
            : centerWidget!;
    }
  }

  Widget state1(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rightItems(context, backIcon: true, logoType: false,title: title),
        leftItems(context, isTransparent: false, reverseColors: reverseColors)
      ],
    );
  }

  Widget state2(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rightItems(context, backIcon: false, logoType: true),
        leftItems(context, isTransparent: false, reverseColors: reverseColors)
      ],
    );
  }

  Widget state3(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rightItems(context, backIcon: true, logoType: false),
        leftItems(context, isTransparent: true, reverseColors: reverseColors)
      ],
    );
  }

  Widget state4(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        rightItems(context, backIcon: true, logoType: false),
        customLeading!
        // leftItems(context, isTransparent: true, reverseColors: reverseColors)
      ],
    );
  }

  Widget state5(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        rightItems(context, backIcon: false, logoType: false,title: title),
        leftItems(context, isTransparent: false, reverseColors: reverseColors)
      ],
    );
  }

  Widget rightItems(BuildContext context,
      {required bool backIcon, required bool logoType,String? title,bool? reverseColor}) {
    return Row(
      children: [
        backIcon
            ? SvgPicture.asset(
                AssetPaths.arrowRight,
                colorFilter: ColorFilter.mode(context.colorScheme.outline, BlendMode.srcIn),
              )
            : const SizedBox.shrink(),
        const SizedBox(width: 8),
        logoType
            ? SvgPicture.asset(
                AssetPaths.logoType,
                width: 59,
                height: 24,
                colorFilter: ColorFilter.mode(
                    reverseColors ?? false ? context.colorScheme.background : context.colorScheme.primary, BlendMode.srcIn),
              )
            : const SizedBox.shrink(),
        title != null ?
            Text(
          title,
          style: context.textTheme.titleSmall,
        )
            : const SizedBox.shrink()
      ],
    );
  }

  Widget leftItems(BuildContext context, {required bool isTransparent, bool? reverseColors}) {
    // final grayColors = context.theme.extension<GrayColors>()!;

    bool reverse = reverseColors ?? false;
    Color primeColor = reverse ? context.colorScheme.background : context.colorScheme.primary;
    Color accentColor = reverse ? context.colorScheme.primary : context.colorScheme.background;
    Color userBackColor = reverse ? context.colorScheme.background.withOpacity(.9) : context.colorScheme.primary;
    Color? homeBackColor = reverse ? Colors.transparent : context.colorScheme.surfaceVariant;
    Color homeBorderColor = reverse ? context.colorScheme.background.withOpacity(.2) : Colors.transparent;

    return Row(
      children: [
        CircleButton(
          color: isTransparent ? Colors.transparent : homeBackColor,
          onTap: ImpoTheme.changeTheme,
          border: Border.all(color: homeBorderColor, width: 1, strokeAlign: BorderSide.strokeAlignInside),
          child: SvgPicture.asset(
            AssetPaths.home,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              primeColor,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 8),
        CircleButton(
          color: isTransparent ? Colors.transparent : userBackColor,
          child: SvgPicture.asset(
            AssetPaths.user,
            width: 24,
            height: 24,
            colorFilter: ColorFilter.mode(
              isTransparent ? primeColor : accentColor,
              BlendMode.srcIn,
            ),
          ),
          onTap: () {},
        ),
      ],
    );
  }
}
