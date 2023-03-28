// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:mpc_remote_control/app/core/themes/settings_ui_theme/settings_tile_checkbox_theme.dart';
import 'package:mpc_remote_control/app/core/themes/settings_ui_theme/settings_tile_theme.dart';

import '../../themes/settings_ui_theme/settings_ui_theme.dart';
import 'abstract_settings_tile.dart';

class SettingsTileCheckBox extends AbstractSettingsTile {
  final Widget? leading;
  final Widget title;
  final Widget? subTitle;
  final Widget? trailing;

  final bool enabled;
  final bool divider;
  final bool? value;
  final bool tristate;
  final void Function(bool?)? onChanged;

  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? dividerColor;
  final Color? activeColor;
  final Color? checkColor;
  final Color? borderColor;
  final Color? disabledColor;

  const SettingsTileCheckBox({
    super.key,
    this.leading,
    required this.title,
    this.subTitle,
    this.trailing,
    this.enabled = true,
    this.divider = false,
    this.tristate = false,
    required this.value,
    required this.onChanged,
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

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SettingsTileTheme? defaultSettingsTileTheme = theme.extension<SettingsUiTheme>()?.settingsTileTheme;
    final SettingsTileCheckBoxTheme? settingsTileCheckBoxTheme = theme.extension<SettingsUiTheme>()?.settingsTileCheckBoxTheme;

    const EdgeInsets padding = EdgeInsets.only(top: 12.5, bottom: 12.5, left: 15.0, right: 10);

    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? () => onChanged?.call(value != null ? !value! : value) : null,
          child: Container(
            constraints: const BoxConstraints(minHeight: 60),
            decoration: BoxDecoration(
              color: backgroundColor ?? settingsTileCheckBoxTheme?.backgroundColor ?? defaultSettingsTileTheme?.backgroundColor,
              border: Border(
                bottom: divider
                    ? BorderSide(
                        color: dividerColor ?? settingsTileCheckBoxTheme?.dividerColor ?? defaultSettingsTileTheme?.dividerColor ?? theme.dividerColor,
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
                            ? leadingIconColor ?? settingsTileCheckBoxTheme?.leadingIconColor ?? defaultSettingsTileTheme?.leadingIconColor
                            : disabledColor ?? settingsTileCheckBoxTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
                      ),
                      child: leading!,
                    ),
                  ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: padding.left),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DefaultTextStyle(
                          style: theme.textTheme.bodyMedium!.copyWith(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: enabled
                                ? titleColor ?? settingsTileCheckBoxTheme?.titleColor ?? defaultSettingsTileTheme?.titleColor
                                : disabledColor ?? settingsTileCheckBoxTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
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
                                    ? subTitleColor ?? settingsTileCheckBoxTheme?.subTitleColor ?? defaultSettingsTileTheme?.subTitleColor
                                    : disabledColor ??
                                        settingsTileCheckBoxTheme?.disabledColor ??
                                        defaultSettingsTileTheme?.disabledColor ??
                                        theme.disabledColor,
                              ),
                              child: subTitle!,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.only(end: padding.right),
                  child: Checkbox(
                    value: value,
                    tristate: tristate,
                    onChanged: enabled ? onChanged : null,
                    activeColor: activeColor ?? settingsTileCheckBoxTheme?.activeColor ?? Colors.green,
                    checkColor: checkColor ?? settingsTileCheckBoxTheme?.checkColor,
                    side: BorderSide(
                      width: 2,
                      color: enabled
                          ? settingsTileCheckBoxTheme?.borderColor ?? Colors.grey
                          : settingsTileCheckBoxTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
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
