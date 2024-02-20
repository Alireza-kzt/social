import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import 'package:social/core/app/view/widgets/custom_app_bar/states_app_bar.dart';
import 'package:shimmer/shimmer.dart';

import '../../themes/styles/decorations.dart';
import '../shimmer_shape.dart';


class MainAppBar extends StatelessWidget implements  PreferredSizeWidget  {
  @override
  final Size preferredSize;
  final bool? glassy;
  final bool transparent;
  final bool? bottomDivider;
  final int? state;
  final bool isLoading;
  final Widget? customLeading;
  final Widget? customAction;
  final PreferredSize? bottom;
  final double? bottomSpacing;
  final Color? backgroundColor;
  final double? rightPadding;
  final Widget? centerWidget;
  final bool? reverseColor;
  final String? title;

  MainAppBar({
    Key? key,
    this.glassy = false,
    this.state,
    this.isLoading = false,
    this.transparent = false,
    this.customAction,
    this.customLeading,
    this.bottom,
    this.bottomSpacing,
    this.bottomDivider = false,
    this.backgroundColor,
    this.rightPadding,
    this.centerWidget,
    this.reverseColor,
    this.title
  })  : preferredSize = Size.fromHeight(
          Decorations.mainAppbarHeight + (bottom?.preferredSize.height ?? 0) + (bottomDivider == true ? 1 : 0),
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    // final grayColors = context.theme.extension<GrayColors>()!;
    return glassy!
        ? GlassmorphicContainer(
            width: context.width,
            height: Decorations.mainAppbarHeight + MediaQuery.of(context).viewPadding.top,
            borderRadius: 0,
            blur: 2,
            border: 0,
            linearGradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                context.colorScheme.inverseSurface,
                context.colorScheme.inverseSurface,
              ],
            ),
            borderGradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.transparent,
                Colors.transparent,
              ],
            ),
            child: content(context, backgroundColor: context.colorScheme.background),
          )
        : content(
            context,
            backgroundColor: backgroundColor ?? context.colorScheme.background,
          );
  }

  Widget content(BuildContext context, {required Color backgroundColor}) {
    return !isLoading
        ? Container(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top + 5,
              bottom: bottom == null ? 5 : 0,
              right: bottom == null ? rightPadding ?? Decorations.paddingHorizontal : 0,
              left: bottom == null ? Decorations.paddingHorizontal : 0,
            ),
            decoration: BoxDecoration(color: transparent ? Colors.transparent : backgroundColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StatesAppBar(
                  state: state,
                  customAction: customAction,
                  customLeading: customLeading,
                  centerWidget: centerWidget,
                  reverseColors: reverseColor,
                  title: title,
                ),
                SizedBox(height: bottomSpacing ?? 0),
                bottom?.child ?? const SizedBox(),
                if (bottomDivider == true) const Divider(height: 0),
              ],
            ),
          )
        : shimmerAppBar(context);
  }

  Widget shimmerAppBar(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: context.colorScheme.outline,
      highlightColor: const Color(0xFFDEDEDE),
      child: ShimmerShape(
        height: Decorations.mainAppbarHeight + MediaQuery.of(context).viewPadding.top,
        radius: 0,
      ),
    );
  }
}
