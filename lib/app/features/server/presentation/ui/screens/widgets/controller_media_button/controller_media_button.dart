import 'dart:async';

import 'package:flutter/material.dart' hide BoxShadow, BoxDecoration;
import 'package:flutter_inset_box_shadow/flutter_inset_box_shadow.dart';

import '../../../../../../../core/widgets/neumorphic_button/neumorphic_button.dart';
import 'gesture_area.dart';

class ControllerMediaButton extends StatefulWidget {
  final void Function()? onTap;
  final void Function(Drag drag)? onHorizontalDrag;
  final void Function(Drag drag)? onVerticalDrag;
  final double size;
  const ControllerMediaButton({
    super.key,
    required this.size,
    this.onTap,
    this.onHorizontalDrag,
    this.onVerticalDrag,
  });

  @override
  State<ControllerMediaButton> createState() => _ControllerMediaButtonState();
}

class _ControllerMediaButtonState extends State<ControllerMediaButton> {
  double get size => widget.size;

  final List<Map<String, dynamic>> _controllerIcons = [
    {
      'direction': Alignment.topCenter,
      'icon': Icons.keyboard_arrow_up_rounded,
    },
    {
      'direction': Alignment.centerLeft,
      'icon': Icons.keyboard_arrow_left_rounded,
    },
    {
      'direction': Alignment.bottomCenter,
      'icon': Icons.keyboard_arrow_down_rounded,
    },
    {
      'direction': Alignment.centerRight,
      'icon': Icons.keyboard_arrow_right_rounded,
    },
  ];
  Timer? _timer;

  void onDrag(Drag drag) {
    _timer?.cancel();
    if (drag.startDirection is DragVerticalDirection) {
      widget.onVerticalDrag?.call(drag);
      _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
        widget.onVerticalDrag?.call(drag);
      });
    } else {
      widget.onHorizontalDrag?.call(drag);
      _timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
        widget.onHorizontalDrag?.call(drag);
      });
    }
  }

  void onDragEnd() {
    _timer?.cancel();
    _timer = null;
  }

  void onTap() {
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return NeumorphicButton(
      width: size,
      height: size,
      topShadowOffset: -Offset(size * 0.05, size * 0.05),
      bottomShadowOffset: Offset(size * 0.03, size * 0.035),
      bottomBlurRadius: size * 0.03,
      bottomSpreadRadius: size * 0.03,
      disabled: true,
      borderRadius: BorderRadius.circular(size * 0.5),
      child: Stack(
        children: [
          ..._controllerIcons
              .map((e) => Align(
                    alignment: e['direction'],
                    child: Icon(
                      e['icon'],
                      size: size * 0.1,
                    ),
                  ))
              .toList(),
          Align(
            alignment: Alignment.center,
            child: Container(
              width: widget.size * 0.55,
              height: size * 0.55,
              decoration: BoxDecoration(
                color: Colors.red,
                boxShadow: [
                  if (isDark) ...[
                    const BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 2,
                      color: Color.fromARGB(255, 89, 89, 89),
                      inset: true,
                    ),
                    const BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: Color.fromARGB(255, 111, 103, 103),
                    )
                  ] else ...[
                    const BoxShadow(
                      offset: Offset(0, 3),
                      blurRadius: 2,
                      color: Color.fromARGB(255, 239, 239, 239),
                      inset: true,
                    ),
                    //border_inside
                    const BoxShadow(
                      offset: Offset(0, 1),
                      blurRadius: 2,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )
                  ]
                ],
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [0, 0.57, 1],
                  colors: [
                    if (isDark) ...[
                      // const Color.fromARGB(255, 6, 5, 5),
                      const Color.fromARGB(255, 20, 20, 20),
                      const Color.fromARGB(255, 46, 46, 46),
                      const Color.fromARGB(255, 49, 49, 49),
                    ] else ...[
                      const Color.fromARGB(255, 252, 252, 252),
                      const Color.fromARGB(255, 255, 255, 255),
                      const Color.fromARGB(255, 235, 235, 235),
                    ]
                  ],
                ),
                border: Border.all(width: 2, color: isDark ? const Color(0xFF000000) : const Color.fromARGB(255, 220, 220, 220)),
                borderRadius: BorderRadius.circular(size * 0.3),
              ),
            ),
          ),
          GestureArea(
            onTap: onTap,
            onVerticalDrag: onDrag,
            onVerticalDragEnd: onDragEnd,
            onHorizontalDrag: onDrag,
            onHorizontalDragEnd: onDragEnd,
          ),
        ],
      ),
    );
  }
}
