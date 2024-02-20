import 'package:flutter/material.dart';

class TabModel {
  final Widget page;
  final String? profileImage;
  final String? icon;
  final String? selectedIcon;
  final String? title;
  final Function()? action;
  final Function()? longPressAction;

  TabModel(
    this.page, {
    this.title,
    this.profileImage,
    this.icon,
    this.selectedIcon,
    this.action,
    this.longPressAction,
  });
}
