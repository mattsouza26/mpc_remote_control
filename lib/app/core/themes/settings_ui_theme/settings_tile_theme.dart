// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class SettingsTileTheme {
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? disabledColor;

  final Color? dividerColor;
  const SettingsTileTheme({
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.leadingIconColor,
    this.dividerColor,
    this.disabledColor,
  });

  SettingsTileTheme copyWith({
    Color? backgroundColor,
    Color? titleColor,
    Color? subTitleColor,
    Color? leadingIconColor,
    Color? dividerColor,
    Color? disabledColor,
  }) {
    return SettingsTileTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      subTitleColor: subTitleColor ?? this.subTitleColor,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      dividerColor: dividerColor ?? this.dividerColor,
      disabledColor: disabledColor ?? this.disabledColor,
    );
  }

  SettingsTileTheme lerp(SettingsTileTheme other, double t) {
    return SettingsTileTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
      subTitleColor: Color.lerp(subTitleColor, other.subTitleColor, t),
      leadingIconColor: Color.lerp(leadingIconColor, other.leadingIconColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
    );
  }
}
