import 'package:flutter/material.dart';

import '../../themes/settings_ui_theme/settings_tile_navigation_theme.dart';
import '../../themes/settings_ui_theme/settings_tile_theme.dart';
import '../../themes/settings_ui_theme/settings_ui_theme.dart';
import 'abstract_settings_tile.dart';

class SettingsTileNavigation extends AbstractSettingsTile {
  final Widget? leading;
  final Widget title;
  final Widget? subTitle;
  final Widget? value;

  final bool enabled;
  final bool divider;
  final VoidCallback? onPressed;

  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? navigationColor;

  final Color? dividerColor;
  final Color? disabledColor;

  const SettingsTileNavigation({
    super.key,
    this.leading,
    required this.title,
    this.subTitle,
    this.value,
    this.enabled = true,
    this.divider = false,
    this.onPressed,
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.leadingIconColor,
    this.navigationColor,
    this.dividerColor,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SettingsTileTheme? defaultSettingsTileTheme = theme.extension<SettingsUiTheme>()?.settingsTileTheme;
    final SettingsTileNavigationTheme? settingsTileNavigationTheme = theme.extension<SettingsUiTheme>()?.settingsTileNavigationTheme;
    const EdgeInsets padding = EdgeInsets.only(top: 12.5, bottom: 12.5, left: 15.0, right: 10);

    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          child: Container(
            constraints: const BoxConstraints(minHeight: 60),
            decoration: BoxDecoration(
              color: backgroundColor ?? settingsTileNavigationTheme?.backgroundColor ?? defaultSettingsTileTheme?.backgroundColor,
              border: Border(
                bottom: divider
                    ? BorderSide(
                        color: dividerColor ?? settingsTileNavigationTheme?.dividerColor ?? defaultSettingsTileTheme?.dividerColor ?? theme.dividerColor,
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
                            ? leadingIconColor ?? settingsTileNavigationTheme?.leadingIconColor ?? defaultSettingsTileTheme?.leadingIconColor
                            : disabledColor ?? settingsTileNavigationTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
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
                                ? titleColor ?? settingsTileNavigationTheme?.titleColor ?? defaultSettingsTileTheme?.titleColor
                                : disabledColor ?? settingsTileNavigationTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
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
                                    ? subTitleColor ?? settingsTileNavigationTheme?.subTitleColor ?? defaultSettingsTileTheme?.subTitleColor
                                    : disabledColor ??
                                        settingsTileNavigationTheme?.disabledColor ??
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
                  child: Row(
                    children: [
                      if (value != null)
                        DefaultTextStyle(
                          style: theme.textTheme.bodySmall!.copyWith(
                            inherit: false,
                            fontSize: 13,
                            color: enabled ? subTitleColor : disabledColor ?? settingsTileNavigationTheme?.disabledColor ?? theme.disabledColor,
                          ),
                          child: value!,
                        ),
                      const SizedBox(width: 5),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 14,
                        color: enabled
                            ? navigationColor ?? settingsTileNavigationTheme?.navigationColor
                            : disabledColor ?? settingsTileNavigationTheme?.disabledColor ?? theme.disabledColor,
                      )
                    ],
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
