import 'package:flutter/material.dart';

class ControllerSection extends StatelessWidget {
  final EdgeInsets? startMargin;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final Axis? direction;
  final List<Widget> children;

  const ControllerSection(
      {super.key, this.mainAxisAlignment, this.direction, required this.children, this.padding, this.crossAxisAlignment, this.startMargin, this.margin});

  @override
  Widget build(BuildContext context) {
    final mainAxisAlign = mainAxisAlignment ?? MainAxisAlignment.center;
    final crossAxisAlign = crossAxisAlignment ?? CrossAxisAlignment.start;

    final List<Widget> buttons = children
        .map(
          (button) => button == children.first
              ? Container(
                  margin: startMargin,
                  child: button,
                )
              : Container(
                  margin: margin,
                  child: button,
                ),
        )
        .toList();

    if (direction == Axis.horizontal) {
      return Container(
        padding: padding,
        child: Row(
          mainAxisAlignment: mainAxisAlign,
          crossAxisAlignment: crossAxisAlign,
          children: buttons,
        ),
      );
    }
    return Container(
      padding: padding,
      child: Column(
        mainAxisAlignment: mainAxisAlign,
        crossAxisAlignment: crossAxisAlign,
        children: buttons,
      ),
    );
  }
}
