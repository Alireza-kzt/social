import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:social/core/app/utils/extensions/context/style_shortcut.dart';
import '../../data/models/tab_model.dart';

class MainBottomNavigationBar extends StatelessWidget {
  final List<TabModel> tabs;
  final int selectedIndex;
  final Function(int index) onIndexChanged;

  const MainBottomNavigationBar({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onIndexChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          side: BorderSide(color: context.colorScheme.surfaceVariant, width: 1),
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(0), topRight: Radius.circular(0)),
        ),
      ),
      padding: const EdgeInsets.only(top: 8, bottom: 16, left: 32, right: 32),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          for (int index = 0; index < tabs.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: 4, top: 8),
              child: GestureDetector(
                onTap: () {
                  onIndexChanged(index);
                },
                onLongPress: () {
                  tabs[index].longPressAction?.call();
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    tabs[index].profileImage != null
                        ? Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: index == selectedIndex ? context.colorScheme.primary : Colors.transparent,
                                width: 1,
                              ),
                            ),
                            child: Container(
                              margin: const EdgeInsets.all(1.0),
                              width: 24,
                              height: 24,
                              decoration: BoxDecoration(
                                color: context.colorScheme.surface,
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: CachedNetworkImageProvider(tabs[index].profileImage!),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          )
                        : index == selectedIndex
                            ? SvgPicture.asset(
                                tabs[index].selectedIcon!,
                                color: context.colorScheme.primary,
                                height: 24,
                                width: 24,
                              )
                            : SvgPicture.asset(
                                tabs[index].icon!,
                                color: context.colorScheme.outline,
                                height: 24,
                                width: 24,
                              ),
                    if (tabs[index].title != null) const SizedBox(height: 4),
                    if (tabs[index].title != null)
                      Text(
                        tabs[index].title.toString(),
                        style: context.textTheme.labelSmall?.copyWith(
                          color: index == selectedIndex ? context.colorScheme.primary : context.colorScheme.outline,
                        ),
                      ),
                  ],
                ),
              ),
            )
        ],
      ),
    );
  }
}
