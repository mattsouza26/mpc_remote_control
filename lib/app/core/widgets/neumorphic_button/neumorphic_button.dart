import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../themes/neumorphic_button_theme.dart';

class NeumorphicButton extends StatefulWidget {
  final bool? disabled;
  final Color? backgroundColor;
  final Color? bottomShadow;
  final Color? topShadow;
  final double? topBlurRadius;
  final double? topSpreadRadius;
  final double? bottomBlurRadius;
  final double? bottomSpreadRadius;
  final Color? iconColor;
  final double? width;
  final double? height;
  final Widget child;
  final Duration? duration;
  final Offset? topShadowOffset;
  final BorderRadiusGeometry? borderRadius;
  final Offset? bottomShadowOffset;
  final Offset? pressedTopShadowOffset;
  final Offset? pressedBottomShadowOffset;
  const NeumorphicButton({
    super.key,
    this.disabled,
    this.backgroundColor,
    this.width,
    this.height,
    required this.child,
    this.duration,
    this.borderRadius,
    this.bottomShadow,
    this.topShadow,
    this.iconColor,
    this.topShadowOffset,
    this.bottomShadowOffset,
    this.pressedTopShadowOffset,
    this.pressedBottomShadowOffset,
    this.topBlurRadius,
    this.topSpreadRadius,
    this.bottomBlurRadius,
    this.bottomSpreadRadius,
  });

  @override
  State<NeumorphicButton> createState() => _NeumorphicButtonState();
}

class _NeumorphicButtonState extends State<NeumorphicButton> {
  bool isPressed = false;

  void _handlePointer(_) {
    setState(() {
      isPressed = !isPressed;
    });
  }

  @override
  Widget build(BuildContext context) {
    final NeumorphicButtonTheme? neumorphicButtonTheme = Theme.of(context).extension<NeumorphicButtonTheme>();
    final bool disabled = widget.disabled ?? neumorphicButtonTheme?.disabled ?? false;
    final double width = widget.width ?? neumorphicButtonTheme?.width ?? 60;
    final double height = widget.height ?? neumorphicButtonTheme?.height ?? 60;
    final BorderRadiusGeometry borderRadius = widget.borderRadius ?? neumorphicButtonTheme?.borderRadius ?? BorderRadius.all(Radius.circular(height * 0.25));
    final Color backgroundColor = widget.backgroundColor ?? neumorphicButtonTheme?.backgroundColor ?? const Color.fromRGBO(250, 250, 250, 1);
    final Color topShadow = widget.topShadow ?? neumorphicButtonTheme?.topShadow ?? const Color.fromRGBO(255, 255, 255, 0.6);
    final Color bottomShadow = widget.bottomShadow ?? neumorphicButtonTheme?.bottomShadow ?? const Color.fromRGBO(174, 174, 192, 0.4);
    final Color? iconColor = widget.iconColor ?? neumorphicButtonTheme?.iconColor;
    final Duration duration = widget.duration ?? neumorphicButtonTheme?.duration ?? const Duration(milliseconds: 50);

    return Listener(
      onPointerDown: !disabled ? _handlePointer : null,
      onPointerUp: !disabled ? _handlePointer : null,
      child: AnimatedContainer(
        padding: const EdgeInsets.all(10),
        width: width,
        height: height,
        duration: duration,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
          boxShadow: [
            BoxShadow(
              color: topShadow,
              offset: isPressed
                  ? widget.pressedTopShadowOffset ?? -Offset(height * 0.03, height * 0.03)
                  : widget.topShadowOffset ?? -Offset(height * 0.08, height * 0.06),
              blurRadius: isPressed ? height * 0.1 : widget.topBlurRadius ?? height * 0.03,
              spreadRadius: isPressed ? -height * 0.05 : widget.topSpreadRadius ?? -height * 0.045,
              inset: isPressed,
            ),
            BoxShadow(
              color: bottomShadow,
              offset: isPressed
                  ? widget.pressedBottomShadowOffset ?? Offset(width * 0.04, height * 0.05)
                  : widget.bottomShadowOffset ?? Offset(width * 0.05, height * 0.05),
              blurRadius: isPressed ? height * 0.05 : widget.bottomBlurRadius ?? height * 0.01,
              spreadRadius: isPressed ? height * 0.015 : widget.bottomSpreadRadius ?? height * 0.03,
              inset: isPressed,
            ),
            BoxShadow(
              color: topShadow,
              offset: Offset(-width * 0.005, -width * 0.005),
              blurRadius: 2,
              spreadRadius: 0,
            ),
          ],
        ),
        child: IconTheme(
          data: Theme.of(context).iconTheme.copyWith(
                color: iconColor,
                size: height * 0.4,
              ),
          child: widget.child,
        ),
      ),
    );
  }
}
