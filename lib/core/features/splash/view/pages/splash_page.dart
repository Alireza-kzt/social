import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import '../../../../app/constants/assets_paths.dart';
import '../../../../app/view/themes/colors/color_schemes.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.isDarkMode ? const Color(0xff1A2028) : context.colorScheme.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(flex: 372),
          Center(
            child: SvgPicture.asset(
              key: const Key('SPLASH'),
              AssetPaths.logo,
              colorFilter: ColorFilter.mode(
                context.isDarkMode ? lightColorScheme.primary : lightColorScheme.onPrimary,
                BlendMode.srcATop,
              ),
              width: 85,
            ),
          ),
          const Spacer(flex: 290),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'ایمپو دکتر',
                style: context.textTheme.labelLarge?.copyWith(color: lightColorScheme.background),
              ),
              SizedBox.square(dimension: 16, child: VerticalDivider(color: lightColorScheme.background, width: 8)),
              Text(
                'اپلیکیشن  متخصصین ایمپو',
                style: context.textTheme.labelLarge?.copyWith(color: lightColorScheme.background),
              ),
            ],
          ),
          const Spacer(flex: 56),
        ],
      ),
    );
  }
}
