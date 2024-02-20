import 'package:flutter/material.dart';
import 'package:social/features/ticket/view/widgets/chip_widget.dart';

class TabBarWidget<T> extends StatelessWidget {
  final List<({String label, T value})> tabs;
  final T selectedValue;
  final void Function(T value)? onTap;

  const TabBarWidget({
    super.key,
    required this.tabs,
    required this.selectedValue,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Row(
        children: [
          for (var tab in tabs)
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(right: tabs.indexOf(tab) == 0 ? 0.0 : 8.0),
                child: ChipWidget(
                  isSelected: selectedValue == tab.value,
                  title: tab.label,
                  onTap: () => onTap?.call(tab.value),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
