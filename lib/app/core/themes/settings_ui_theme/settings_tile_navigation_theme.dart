// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SettingsTileNavigationTheme {
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? navigationColor;
  final Color? dividerColor;
  final Color? disabledColor;

  const SettingsTileNavigationTheme({
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.leadingIconColor,
    this.navigationColor,
    this.dividerColor,
    this.disabledColor,
  });

  SettingsTileNavigationTheme copyWith({
    bool? enabled,
    bool? divider,
    Color? backgroundColor,
    Color? titleColor,
    Color? subTitleColor,
    Color? leadingIconColor,
    Color? navigationColor,
    Color? dividerColor,
    Color? disabledColor,
  }) {
    return SettingsTileNavigationTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      subTitleColor: subTitleColor ?? this.subTitleColor,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      navigationColor: navigationColor ?? this.navigationColor,
      dividerColor: dividerColor ?? this.dividerColor,
      disabledColor: disabledColor ?? this.disabledColor,
    );
  }

  SettingsTileNavigationTheme lerp(SettingsTileNavigationTheme? other, double t) {
    if (other is! SettingsTileNavigationTheme) {
      return this;
    }
    return SettingsTileNavigationTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
      subTitleColor: Color.lerp(subTitleColor, other.subTitleColor, t),
      leadingIconColor: Color.lerp(leadingIconColor, other.leadingIconColor, t),
      navigationColor: Color.lerp(navigationColor, other.navigationColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
    );
  }
}
