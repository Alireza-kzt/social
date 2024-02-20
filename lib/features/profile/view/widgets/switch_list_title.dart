import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingSwitchListTile extends StatelessWidget {
  final String title;
  final String description;
  final void Function(bool) onChanged;
  final bool value;
  final bool isDisable;

  const SettingSwitchListTile({
    super.key,
    required this.title,
    required this.description,
    required this.onChanged,
    required this.value,
    required this.isDisable,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: isDisable ? 0.5 : 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: context.textTheme.titleMedium),
              SizedBox(
                height: 40,
                child: FittedBox(
                  child: Switch(
                    value: value,
                    onChanged: onChanged,
                  ),
                ),
              ),
            ],
          ),
          // SizedBox(height: 4),
          Text(description, style: context.textTheme.labelSmall),
          const Divider(height: 32)
        ],
      ),
    );
  }
}
