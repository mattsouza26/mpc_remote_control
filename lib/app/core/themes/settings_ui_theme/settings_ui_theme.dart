// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'settings_tile_checkbox_theme.dart';
import 'settings_tile_dropdown_theme.dart';
import 'settings_tile_navigation_theme.dart';
import 'settings_tile_switch_theme.dart';
import 'settings_tile_theme.dart';

class SettingsUiTheme extends ThemeExtension<SettingsUiTheme> {
  final SettingsTileTheme? settingsTileTheme;
  final SettingsTileCheckBoxTheme? settingsTileCheckBoxTheme;
  final SettingsTileSwitchTheme? settingsTileSwitchTheme;
  final SettingsTileNavigationTheme? settingsTileNavigationTheme;
  final SettingsTileDropDownTheme? settingsTileDropDownTheme;

  const SettingsUiTheme({
    this.settingsTileTheme,
    this.settingsTileCheckBoxTheme,
    this.settingsTileSwitchTheme,
    this.settingsTileNavigationTheme,
    this.settingsTileDropDownTheme,
  });
  @override
  SettingsUiTheme copyWith({
    SettingsTileTheme? settingsTileTheme,
    SettingsTileCheckBoxTheme? settingsTileCheckBoxTheme,
    SettingsTileSwitchTheme? settingsTileSwitchTheme,
    SettingsTileNavigationTheme? settingsTileNavigationTheme,
    SettingsTileDropDownTheme? settingsTileDropDownTheme,
  }) {
    return SettingsUiTheme(
      settingsTileTheme: settingsTileTheme ?? this.settingsTileTheme,
      settingsTileCheckBoxTheme: settingsTileCheckBoxTheme ?? this.settingsTileCheckBoxTheme,
      settingsTileSwitchTheme: settingsTileSwitchTheme ?? this.settingsTileSwitchTheme,
      settingsTileNavigationTheme: settingsTileNavigationTheme ?? this.settingsTileNavigationTheme,
      settingsTileDropDownTheme: settingsTileDropDownTheme ?? this.settingsTileDropDownTheme,
    );
  }

  @override
  ThemeExtension<SettingsUiTheme> lerp(covariant ThemeExtension<SettingsUiTheme>? other, double t) {
    if (other is! SettingsUiTheme) {
      return this;
    }
    return SettingsUiTheme(
      settingsTileTheme: const SettingsTileTheme().lerp(other.settingsTileTheme!, t),
      settingsTileNavigationTheme: const SettingsTileNavigationTheme().lerp(other.settingsTileNavigationTheme, t),
      settingsTileCheckBoxTheme: const SettingsTileCheckBoxTheme().lerp(other.settingsTileCheckBoxTheme, t),
      settingsTileSwitchTheme: const SettingsTileSwitchTheme().lerp(other.settingsTileSwitchTheme, t),
      settingsTileDropDownTheme: const SettingsTileDropDownTheme().lerp(other.settingsTileDropDownTheme, t),
    );
  }
}
