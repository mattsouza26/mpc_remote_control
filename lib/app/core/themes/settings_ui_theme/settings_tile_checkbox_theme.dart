// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SettingsTileCheckBoxTheme {
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? dividerColor;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final Color? disabledColor;

  const SettingsTileCheckBoxTheme({
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.leadingIconColor,
    this.dividerColor,
    this.activeColor,
    this.checkColor,
    this.borderColor,
    this.disabledColor,
  });

  SettingsTileCheckBoxTheme copyWith({
    bool? enabled,
    bool? divider,
    bool? tristate,
    Color? backgroundColor,
    Color? titleColor,
    Color? subTitleColor,
    Color? leadingIconColor,
    Color? dividerColor,
    Color? activeColor,
    Color? checkColor,
    Color? borderColor,
    Color? disabledColor,
  }) {
    return SettingsTileCheckBoxTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      subTitleColor: subTitleColor ?? this.subTitleColor,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      dividerColor: dividerColor ?? this.dividerColor,
      activeColor: activeColor ?? this.activeColor,
      checkColor: checkColor ?? this.checkColor,
      borderColor: borderColor ?? this.borderColor,
      disabledColor: disabledColor ?? this.disabledColor,
    );
  }

  SettingsTileCheckBoxTheme lerp(SettingsTileCheckBoxTheme? other, double t) {
    if (other is! SettingsTileCheckBoxTheme) {
      return this;
    }
    return SettingsTileCheckBoxTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
      subTitleColor: Color.lerp(subTitleColor, other.subTitleColor, t),
      leadingIconColor: Color.lerp(leadingIconColor, other.leadingIconColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      checkColor: Color.lerp(checkColor, other.checkColor, t),
      borderColor: Color.lerp(borderColor, other.borderColor, t),
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
    );
  }
}
