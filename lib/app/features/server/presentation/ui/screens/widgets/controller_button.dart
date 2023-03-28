import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../../core/widgets/neumorphic_button/neumorphic_button.dart';

class ControllerButton extends StatefulWidget {
  final double? size;
  final IconData icon;
  final void Function()? onPressed;
  final void Function()? onLongPress;
  final bool isMultiAction;
  const ControllerButton({
    super.key,
    required this.icon,
    this.size,
    this.onPressed,
    this.onLongPress,
    this.isMultiAction = true,
  });

  @override
  State<ControllerButton> createState() => _ControllerButtonState();
}

class _ControllerButtonState extends State<ControllerButton> {
  Timer? _timer;

  _cancelLongPress() {
    _timer?.cancel();
    _timer = null;
  }

  _onLongPress() {
    if (widget.isMultiAction) {
      _timer ??= Timer.periodic(const Duration(milliseconds: 200), (_) => widget.onLongPress?.call());
    } else {
      widget.onLongPress?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onLongPress: !widget.isMultiAction ? () => _onLongPress() : null,
      onTapDown: widget.isMultiAction ? (_) => _onLongPress() : null,
      onTapUp: widget.isMultiAction ? (_) => _cancelLongPress() : null,
      onTapCancel: widget.isMultiAction ? _cancelLongPress : null,
      child: NeumorphicButton(
        height: widget.size,
        width: widget.size,
        borderRadius: BorderRadius.all(Radius.circular(widget.size ?? 10)),
        child: Icon(widget.icon),
      ),
    );
  }
}
