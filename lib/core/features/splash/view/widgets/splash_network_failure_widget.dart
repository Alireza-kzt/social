import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import '../../../../app/view/widgets/loading_indicator_widget.dart';
import '../../../../app/constants/assets_paths.dart';
import '../../../../app/constants/messages.dart';
import '../../../../app/view/themes/styles/decorations.dart';

class SplashNetworkFailureWidget extends StatelessWidget {
  final StateMixin state;
  final Function() onRetry;

  const SplashNetworkFailureWidget({super.key, required this.onRetry, required this.state});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: Decorations.paddingHorizontal),
      color: context.colorScheme.background,
      child: Wrap(
        children: [
          const SizedBox(height: 8, width: double.infinity),
          Center(
            child: SizedBox(
              width: 54,
              child: Divider(
                color: context.colorScheme.surface,
                thickness: 2,
                height: 0,
              ),
            ),
          ),
          const SizedBox(height: 16, width: double.infinity),
          Row(
            children: [
              SvgPicture.asset(AssetPaths.close),
              const SizedBox(height: 16, child: VerticalDivider(width: 16)),
              Text(
                Messages.splashNetworkFailure,
                style: context.textTheme.labelLarge,
              ),
            ],
          ),
          const SizedBox(height: 6, width: double.infinity),
          Text(
            Messages.splashNetworkFailureDes,
            style: context.textTheme.labelMedium,
          ),
          const SizedBox(height: 45, width: double.infinity),
          state.obx(
            (_) => ElevatedButton(
              style: context.buttonThemes.elevatedButtonStyle(wide: true),
              onPressed: onRetry,
              child: const Text('تلاش مجدد'),
            ),
            onLoading: ElevatedButton(
              style: context.buttonThemes.elevatedButtonStyle(wide: true),
              onPressed: onRetry,
              child: const LoadingIndicatorWidget(),
            ),
          ),
          const SizedBox(height: 24, width: double.infinity),
        ],
      ),
    );
  }
}
