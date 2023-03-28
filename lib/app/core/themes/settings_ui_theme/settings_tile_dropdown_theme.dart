// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class SettingsTileDropDownTheme {
  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? dividerColor;
  final Color? disabledColor;
  final TextStyle? dropDownTextStyle;
  final InputDecorationTheme? inputDecorationTheme;
  final MenuStyle? menuStyle;

  const SettingsTileDropDownTheme({
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.leadingIconColor,
    this.dividerColor,
    this.disabledColor,
    this.dropDownTextStyle,
    this.inputDecorationTheme,
    this.menuStyle,
  });

  SettingsTileDropDownTheme copyWith({
    Color? backgroundColor,
    Color? titleColor,
    Color? subTitleColor,
    Color? leadingIconColor,
    Color? dividerColor,
    Color? disabledColor,
    TextStyle? dropDownTextStyle,
    InputDecorationTheme? inputDecorationTheme,
    MenuStyle? menuStyle,
  }) {
    return SettingsTileDropDownTheme(
      backgroundColor: backgroundColor ?? this.backgroundColor,
      titleColor: titleColor ?? this.titleColor,
      subTitleColor: subTitleColor ?? this.subTitleColor,
      leadingIconColor: leadingIconColor ?? this.leadingIconColor,
      dividerColor: dividerColor ?? this.dividerColor,
      disabledColor: disabledColor ?? this.disabledColor,
      dropDownTextStyle: dropDownTextStyle ?? this.dropDownTextStyle,
      inputDecorationTheme: inputDecorationTheme ?? this.inputDecorationTheme,
      menuStyle: menuStyle ?? this.menuStyle,
    );
  }

  SettingsTileDropDownTheme lerp(SettingsTileDropDownTheme? other, double t) {
    if (other is! SettingsTileDropDownTheme) {
      return this;
    }
    return SettingsTileDropDownTheme(
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      titleColor: Color.lerp(titleColor, other.titleColor, t),
      subTitleColor: Color.lerp(subTitleColor, other.subTitleColor, t),
      leadingIconColor: Color.lerp(leadingIconColor, other.leadingIconColor, t),
      dividerColor: Color.lerp(dividerColor, other.dividerColor, t),
      disabledColor: Color.lerp(disabledColor, other.disabledColor, t),
      dropDownTextStyle: TextStyle.lerp(dropDownTextStyle, other.dropDownTextStyle, t),
      inputDecorationTheme: other.inputDecorationTheme,
      menuStyle: MenuStyle.lerp(menuStyle, other.menuStyle, t),
    );
  }
}
