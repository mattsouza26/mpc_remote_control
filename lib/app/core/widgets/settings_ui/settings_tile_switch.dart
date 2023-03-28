// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../themes/settings_ui_theme/settings_tile_switch_theme.dart';
import '../../themes/settings_ui_theme/settings_tile_theme.dart';
import '../../themes/settings_ui_theme/settings_ui_theme.dart';
import 'abstract_settings_tile.dart';

class SettingsTileSwitch extends AbstractSettingsTile {
  final Widget? leading;
  final Widget title;
  final Widget? subTitle;
  final Widget? trailing;

  final bool enabled;
  final bool divider;
  final bool value;
  final void Function(bool value)? onChanged;

  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? dividerColor;
  final Color? disabledColor;

  final Color? activeColor;
  final Color? trackColor;
  final Color? thumbColor;

  const SettingsTileSwitch({
    super.key,
    this.leading,
    required this.title,
    this.subTitle,
    this.trailing,
    this.enabled = true,
    this.divider = false,
    required this.value,
    required this.onChanged,
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SettingsTileTheme? defaultSettingsTileTheme = theme.extension<SettingsUiTheme>()?.settingsTileTheme;
    final SettingsTileSwitchTheme? settingsTileSwitchTheme = theme.extension<SettingsUiTheme>()?.settingsTileSwitchTheme;

    const EdgeInsets padding = EdgeInsets.only(top: 12.5, bottom: 12.5, left: 15.0, right: 10);
    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? () => onChanged?.call(!value) : null,
          child: Container(
            constraints: const BoxConstraints(minHeight: 60),
            decoration: BoxDecoration(
              color: backgroundColor ?? settingsTileSwitchTheme?.backgroundColor ?? defaultSettingsTileTheme?.backgroundColor,
              border: Border(
                bottom: divider
                    ? BorderSide(
                        color: dividerColor ?? settingsTileSwitchTheme?.dividerColor ?? defaultSettingsTileTheme?.dividerColor ?? theme.dividerColor,
                        width: 1,
                        strokeAlign: -1.0,
                      )
                    : BorderSide.none,
              ),
            ),
            child: Row(
              children: [
                if (leading != null)
                  Padding(
                    padding: EdgeInsets.only(left: padding.left, right: 2.5),
                    child: IconTheme(
                      data: theme.iconTheme.copyWith(
                        size: 24,
                        color: enabled
                            ? leadingIconColor ?? settingsTileSwitchTheme?.leadingIconColor ?? defaultSettingsTileTheme?.leadingIconColor
                            : disabledColor ?? settingsTileSwitchTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
                      ),
                      child: leading!,
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: padding.left),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: enabled
                                ? titleColor ?? settingsTileSwitchTheme?.titleColor ?? defaultSettingsTileTheme?.titleColor
                                : disabledColor ?? settingsTileSwitchTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
                          ),
                          child: title,
                        ),
                        if (subTitle != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: DefaultTextStyle(
                              style: theme.textTheme.bodySmall!.copyWith(
                                inherit: false,
                                fontSize: 10,
                                color: enabled
                                    ? subTitleColor ?? settingsTileSwitchTheme?.subTitleColor ?? defaultSettingsTileTheme?.subTitleColor
                                    : disabledColor ?? settingsTileSwitchTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
                              ),
                              child: subTitle!,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsetsDirectional.only(end: padding.right),
                  height: 30,
                  child: FittedBox(
                    child: CupertinoSwitch(
                      value: value,
                      onChanged: enabled ? onChanged : null,
                      activeColor: enabled ? activeColor ?? settingsTileSwitchTheme?.activeColor ?? Colors.green : disabledColor ?? theme.disabledColor,
                      trackColor: trackColor ?? settingsTileSwitchTheme?.trackColor,
                      thumbColor: thumbColor ?? settingsTileSwitchTheme?.thumbColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
