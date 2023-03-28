import 'package:flutter/material.dart';

import '../../themes/settings_ui_theme/settings_tile_theme.dart';
import '../../themes/settings_ui_theme/settings_ui_theme.dart';
import 'abstract_settings_tile.dart';

class SettingsTile extends AbstractSettingsTile {
  final Widget? leading;
  final Widget title;
  final Widget? subTitle;
  final Widget? trailing;

  final bool enabled;
  final bool divider;
  final VoidCallback? onPressed;

  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? dividerColor;
  final Color? disabledColor;

  const SettingsTile({
    super.key,
    this.leading,
    required this.title,
    this.subTitle,
    this.trailing,
    this.enabled = true,
    this.divider = false,
    this.onPressed,
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.leadingIconColor,
    this.dividerColor,
    this.disabledColor,
  });

  @override
  Widget build(BuildContext context) {
    final SettingsTileTheme? settingsTileTheme = Theme.of(context).extension<SettingsUiTheme>()?.settingsTileTheme;
    final ThemeData theme = Theme.of(context);
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
              color: backgroundColor ?? settingsTileTheme?.backgroundColor,
              border: Border(
                bottom: divider
                    ? BorderSide(
                        color: dividerColor ?? settingsTileTheme?.dividerColor ?? theme.dividerColor,
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
                            ? leadingIconColor ?? settingsTileTheme?.leadingIconColor
                            : disabledColor ?? settingsTileTheme?.disabledColor ?? theme.disabledColor,
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
                                ? titleColor ?? settingsTileTheme?.titleColor
                                : disabledColor ?? settingsTileTheme?.disabledColor ?? theme.disabledColor,
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
                                    ? subTitleColor ?? settingsTileTheme?.subTitleColor
                                    : disabledColor ?? settingsTileTheme?.disabledColor ?? theme.disabledColor,
                              ),
                              child: subTitle!,
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                DefaultTextStyle(
                  style: theme.textTheme.bodySmall!.copyWith(
                    inherit: false,
                    fontSize: 10,
                    color: enabled ? null : disabledColor ?? settingsTileTheme?.disabledColor ?? theme.disabledColor,
                  ),
                  child: IconTheme(
                    data: theme.iconTheme.copyWith(
                      size: 24,
                      color: enabled ? null : disabledColor ?? settingsTileTheme?.disabledColor ?? theme.disabledColor,
                    ),
                    child: Padding(
                      padding: EdgeInsetsDirectional.only(end: padding.right),
                      child: trailing,
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
