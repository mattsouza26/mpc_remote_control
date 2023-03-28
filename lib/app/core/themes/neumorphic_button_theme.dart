// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ui';

import 'package:flutter/material.dart';

class NeumorphicButtonTheme extends ThemeExtension<NeumorphicButtonTheme> {
  final bool disabled;
  final Color? backgroundColor;

  final Color? bottomShadow;
  final Color? topShadow;
  final double? width;
  final double? height;
  final Duration? duration;
  final Color? iconColor;
  final BorderRadiusGeometry? borderRadius;

  const NeumorphicButtonTheme({
    this.iconColor,
    this.disabled = false,
    required this.backgroundColor,
    required this.bottomShadow,
    required this.topShadow,
    this.width = 60,
    this.height = 60,
    this.duration = const Duration(milliseconds: 50),
    this.borderRadius = const BorderRadius.all(Radius.circular(10)),
  });

  factory NeumorphicButtonTheme.light({
    bool disabled = false,
    Color? backgroundColor,
    Color? bottomShadow,
    Color? topShadow,
    double? width,
    double? height,
    Duration? duration,
    Color? iconColor,
    BorderRadiusGeometry? borderRadius,
  }) =>
      NeumorphicButtonTheme(
        disabled: disabled,
        backgroundColor: backgroundColor ?? const Color.fromRGBO(250, 250, 250, 1),
        // topShadow: topShadow ?? const Color.fromRGBO(255, 255, 255, 0.6),
        topShadow: topShadow ?? const Color.fromARGB(255, 246, 245, 245),
        // bottomShadow: bottomShadow ?? const Color.fromRGBO(174, 174, 192, 0.4),
        bottomShadow: bottomShadow ?? const Color.fromARGB(250, 227, 229, 240),
        width: width,
        height: height,
        duration: duration,
        iconColor: iconColor ?? const Color.fromARGB(255, 59, 59, 59),
        borderRadius: borderRadius,
      );
  factory NeumorphicButtonTheme.dark({
    bool disabled = false,
    Color? backgroundColor,
    Color? bottomShadow,
    Color? topShadow,
    double? width,
    double? height,
    Duration? duration,
    Color? iconColor,
    BorderRadiusGeometry? borderRadius,
  }) =>
      NeumorphicButtonTheme(
        disabled: disabled,
        backgroundColor: backgroundColor ?? const Color.fromARGB(255, 28, 28, 29),
        topShadow: topShadow ?? const Color.fromARGB(255, 88, 88, 88),
        bottomShadow: bottomShadow ?? const Color.fromARGB(255, 0, 0, 0),
        width: width,
        height: height,
        duration: duration,
        iconColor: iconColor ?? const Color.fromARGB(255, 233, 233, 233),
        borderRadius: borderRadius,
      );

  @override
  NeumorphicButtonTheme copyWith({
    bool? disabled,
    Color? backgroundColor,
    Color? bottomShadow,
    Color? topShadow,
    double? width,
    double? height,
    Duration? duration,
    Color? iconColor,
    BorderRadiusGeometry? borderRadius,
  }) {
    return NeumorphicButtonTheme(
      disabled: disabled ?? this.disabled,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      topShadow: topShadow ?? this.topShadow,
      bottomShadow: bottomShadow ?? this.bottomShadow,
      width: width ?? this.width,
      height: height ?? this.height,
      duration: duration ?? this.duration,
      iconColor: iconColor ?? this.iconColor,
      borderRadius: borderRadius ?? this.borderRadius,
    );
  }

  @override
  ThemeExtension<NeumorphicButtonTheme> lerp(covariant ThemeExtension<NeumorphicButtonTheme>? other, double t) {
    if (other is! NeumorphicButtonTheme) {
      return this;
    }
    return NeumorphicButtonTheme(
      disabled: t < 0.5 ? disabled : other.disabled,
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      topShadow: Color.lerp(topShadow, other.topShadow, t),
      bottomShadow: Color.lerp(bottomShadow, other.bottomShadow, t),
      width: lerpDouble(width, other.width, t),
      height: lerpDouble(height, other.height, t),
      iconColor: Color.lerp(iconColor, other.iconColor, t),
    );
  }
}
