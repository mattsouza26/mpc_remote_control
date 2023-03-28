// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SettingsTileSwitchTheme {
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? dividerColor;
  final Color? disabledColor;

  final Color? activeColor;
  final Color? trackColor;
  final Color? thumbColor;

  const SettingsTileSwitchTheme({
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.leadingIconColor,
    this.dividerColor,
    this.disabledColor,
    this.activeColor,
    this.trackColor,
    this.thumbColor,
  });

  SettingsTileSwitchTheme copyWith({
    Color? backgroundColor,
    Color? titleColor,
    Color? subTitleColor,
    Color? leadingIconColor,
    Color? dividerColor,
    Color? disabledColor,
    Color? activeColor,
    Color? trackColor,
    Color? thumbColor,
  }) {
    return SettingsTileSwitchTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      subTitleColor: subTitleColor ?? this.subTitleColor,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      dividerColor: dividerColor ?? this.dividerColor,
      disabledColor: disabledColor ?? this.disabledColor,
      activeColor: activeColor ?? this.activeColor,
      trackColor: trackColor ?? this.trackColor,
      thumbColor: thumbColor ?? this.thumbColor,
    );
  }

  SettingsTileSwitchTheme lerp(SettingsTileSwitchTheme? other, double t) {
    if (other is! SettingsTileSwitchTheme) {
      return this;
    }
    return SettingsTileSwitchTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
      subTitleColor: Color.lerp(subTitleColor, other.subTitleColor, t),
      leadingIconColor: Color.lerp(leadingIconColor, other.leadingIconColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
      activeColor: Color.lerp(activeColor, other.activeColor, t),
      trackColor: Color.lerp(trackColor, other.trackColor, t),
      thumbColor: Color.lerp(thumbColor, other.thumbColor, t),
    );
  }
}
