// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mpc_remote_control/app/core/themes/settings_ui_theme/settings_tile_dropdown_theme.dart';

import '../../themes/settings_ui_theme/settings_tile_theme.dart';
import '../../themes/settings_ui_theme/settings_ui_theme.dart';
import 'abstract_settings_tile.dart';

class SettingsTileDropDown<T> extends AbstractSettingsTile {
  final Widget? leading;
  final Widget title;
  final Widget? subTitle;
  final Widget? trailing;

  final bool enabled;
  final bool divider;

  final Color? backgroundColor;
  final Color? titleColor;
  final Color? subTitleColor;
  final Color? leadingIconColor;
  final Color? dividerColor;
  final Color? disabledColor;

  final T? value;
  final List<DropdownMenuItem<T>>? items;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;
  final void Function(T?)? onChanged;
  final void Function()? onTap;

  final Widget? hint;
  final Widget? disabledHint;
  final int elevation;

  final TextStyle? dropDownStyle;
  final Widget? underline;
  final Widget? icon;
  final Color? iconDisabledColor;
  final Color? iconEnabledColor;
  final double iconSize;
  final bool isDense;
  final bool isExpanded;
  final double? itemHeight = kMinInteractiveDimension;
  final Color? dropdownColor;
  final double? menuMaxHeight;
  final bool? enableFeedback;
  final AlignmentGeometry dropDownAlignment;
  final BorderRadius? dropDownBorderRadius;

  const SettingsTileDropDown({
    super.key,
    this.leading,
    required this.title,
    this.subTitle,
    this.trailing,
    this.enabled = true,
    this.divider = false,
    required this.value,
    required this.items,
    required this.onChanged,
    this.selectedItemBuilder,
    this.onTap,
    this.backgroundColor,
    this.titleColor,
    this.subTitleColor,
    this.leadingIconColor,
    this.dividerColor,
    this.disabledColor,
    this.elevation = 5,
    this.hint,
    this.disabledHint,
    this.dropDownStyle,
    this.underline,
    this.icon,
    this.iconDisabledColor,
    this.iconEnabledColor,
    this.iconSize = 24,
    this.isDense = false,
    this.isExpanded = false,
    this.dropdownColor,
    this.menuMaxHeight,
    this.enableFeedback,
    this.dropDownAlignment = Alignment.center,
    this.dropDownBorderRadius,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final SettingsTileTheme? defaultSettingsTileTheme = theme.extension<SettingsUiTheme>()?.settingsTileTheme;
    final SettingsTileDropDownTheme? settingsTileDropDownTheme = Theme.of(context).extension<SettingsUiTheme>()?.settingsTileDropDownTheme;
    const EdgeInsets padding = EdgeInsets.only(top: 12.5, bottom: 12.5, left: 15.0, right: 10);
    return IgnorePointer(
      ignoring: !enabled,
      child: Material(
        color: Colors.transparent,
        child: Container(
          constraints: const BoxConstraints(minHeight: 60),
          decoration: BoxDecoration(
            color: backgroundColor ?? settingsTileDropDownTheme?.backgroundColor ?? defaultSettingsTileTheme?.backgroundColor,
            border: Border(
              bottom: divider
                  ? BorderSide(
                      color: dividerColor ?? settingsTileDropDownTheme?.dividerColor ?? defaultSettingsTileTheme?.dividerColor ?? theme.dividerColor,
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
                          ? leadingIconColor ?? settingsTileDropDownTheme?.leadingIconColor ?? defaultSettingsTileTheme?.leadingIconColor
                          : disabledColor ?? settingsTileDropDownTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
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
                              ? titleColor ?? settingsTileDropDownTheme?.titleColor ?? defaultSettingsTileTheme?.titleColor
                              : disabledColor ?? settingsTileDropDownTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
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
                                  ? subTitleColor ?? settingsTileDropDownTheme?.subTitleColor ?? defaultSettingsTileTheme?.subTitleColor
                                  : disabledColor ?? settingsTileDropDownTheme?.disabledColor ?? defaultSettingsTileTheme?.disabledColor ?? theme.disabledColor,
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
                child: DropdownButton<T>(
                  value: value,
                  items: items,
                  onTap: onTap,
                  onChanged: enabled ? onChanged : null,
                  selectedItemBuilder: selectedItemBuilder,
                  dropdownColor: dropdownColor,
                  underline: underline ?? Container(),
                  elevation: elevation,
                  icon: icon,
                  style: dropDownStyle ?? settingsTileDropDownTheme?.dropDownTextStyle,
                  iconSize: iconSize,
                  iconEnabledColor: iconEnabledColor,
                  iconDisabledColor: iconDisabledColor,
                  hint: hint,
                  disabledHint: disabledHint,
                  isDense: isDense,
                  isExpanded: isExpanded,
                  enableFeedback: enableFeedback,
                  itemHeight: itemHeight,
                  menuMaxHeight: menuMaxHeight,
                  alignment: dropDownAlignment,
                  borderRadius: dropDownBorderRadius,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
