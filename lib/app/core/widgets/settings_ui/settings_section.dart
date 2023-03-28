import 'package:flutter/material.dart';

import 'abstract_settings_tile.dart';

class SettingsSection extends StatelessWidget {
  final Widget? sectionName;
  final String? sectionNameString;
  final bool divider;
  final bool dividerOnLastItem;
  final List<AbstractSettingsTile>? settings;
  const SettingsSection({
    super.key,
    this.settings,
    this.sectionName,
    this.sectionNameString,
    this.divider = true,
    this.dividerOnLastItem = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(width: double.infinity),
        Padding(
          padding: const EdgeInsets.only(left: 30.0, bottom: 5, top: 25),
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
            child: sectionName ?? (sectionNameString != null ? Text(sectionNameString!.toUpperCase()) : Container()),
          ),
        ),
        if (settings != null && settings!.isNotEmpty)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: settings!
                  .map(
                    (e) => e != settings!.last
                        ? Container(
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: divider
                                    ? BorderSide(
                                        color: Theme.of(context).dividerColor,
                                        width: 1,
                                        strokeAlign: -1.0,
                                      )
                                    : BorderSide.none,
                              ),
                            ),
                            child: e,
                          )
                        : !dividerOnLastItem
                            ? e
                            : Container(
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: divider
                                        ? BorderSide(
                                            color: Theme.of(context).dividerColor,
                                            width: 1,
                                            strokeAlign: -1.0,
                                          )
                                        : BorderSide.none,
                                  ),
                                ),
                                child: e,
                              ),
                  )
                  .toList(),
            ),
          )
      ],
    );
  }
}
