import 'package:flutter/material.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import '../../../../../core/app/view/themes/styles/decorations.dart';
import 'startup_header_widget.dart';

class StartupTemplateWidget extends StatelessWidget {
  final StartupHeaderWidget header;
  final Widget content;
  final Widget? footer;
  final bool? resizeToAvoidBottomInset;
  final bool? isScroll;
  final String? backgroundImage;
  final Color? backgroundColor;
  final Widget? bottomNavigationBar;
  final bool useIntrinsicHeight;

  const StartupTemplateWidget({
    Key? key,
    required this.header,
    required this.content,
    this.resizeToAvoidBottomInset,
    this.footer,
    this.isScroll = false,
    this.backgroundImage,
    this.backgroundColor,
    this.bottomNavigationBar,
    this.useIntrinsicHeight = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: backgroundImage != null ? DecorationImage(image: AssetImage(backgroundImage!), fit: BoxFit.cover) : null,
      ),
      child: Scaffold(
        bottomNavigationBar: bottomNavigationBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        backgroundColor: backgroundImage != null ? Colors.transparent : backgroundColor,
        body: SafeArea(
          child: Padding(
            padding: Decorations.pagePaddingHorizontal.copyWith(bottom: 18),
            child: isScroll!
                ? SingleChildScrollView(child: useIntrinsicHeight ? IntrinsicHeight(child: body()) : body())
                : useIntrinsicHeight
                    ? IntrinsicHeight(child: body())
                    : body(),
          ),
        ),
        bottomSheet: footer != null
            ? Material(
                color: backgroundColor ?? context.colorScheme.background,
                child: Padding(
                  padding: Decorations.pagePaddingHorizontal.copyWith(bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 10 : 10),
                  child: footer,
                ),
              )
            : null,
      ),
    );
  }

  Widget body() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        header,
        content,
      ],
    );
  }
}
