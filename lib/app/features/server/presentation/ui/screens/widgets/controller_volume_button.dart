import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../../core/widgets/neumorphic_button/neumorphic_button.dart';

class ControllerVolumeButton extends StatefulWidget {
  final void Function()? onUpLongPress;
  final void Function()? onDownLongPress;
  final void Function()? onUpPress;
  final void Function()? onDownPress;
  final double size;
  const ControllerVolumeButton({
    super.key,
    required this.size,
    this.onUpLongPress,
    this.onDownLongPress,
    this.onUpPress,
    this.onDownPress,
  });

  @override
  State<ControllerVolumeButton> createState() => _ControllerVolumeButtonState();
}

class _ControllerVolumeButtonState extends State<ControllerVolumeButton> {
  double get size => widget.size;
  double get buttonHeight => size / 2;
  double get buttonWidth => (widget.size * 0.445).roundToDouble();

  Timer? _timer;
  void _cancelLongPress() {
    _timer?.cancel();
  }

  void _handlerLongPress(void Function()? onPress) {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(milliseconds: 250), (timer) {
      onPress?.call();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 0.45,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: GestureDetector(
              onTap: widget.onUpPress,
              onTapDown: (_) => _handlerLongPress(widget.onUpLongPress),
              onTapUp: (_) => _cancelLongPress(),
              onTapCancel: _cancelLongPress,
              child: NeumorphicButton(
                disabled: widget.onUpPress == null,
                width: buttonWidth,
                height: buttonHeight,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(buttonHeight / 2),
                  topRight: Radius.circular(buttonHeight / 2),
                ),
                child: Icon(
                  Icons.add,
                  size: buttonHeight * 0.42,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onTap: widget.onDownPress,
              onTapDown: (_) => _handlerLongPress(widget.onDownLongPress),
              onTapUp: (_) => _cancelLongPress(),
              onTapCancel: _cancelLongPress,
              child: NeumorphicButton(
                disabled: widget.onDownPress == null,
                width: buttonWidth,
                height: buttonHeight,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(buttonHeight / 2),
                  bottomRight: Radius.circular(buttonHeight / 2),
                ),
                child: Icon(
                  Icons.remove,
                  size: buttonHeight * 0.42,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
