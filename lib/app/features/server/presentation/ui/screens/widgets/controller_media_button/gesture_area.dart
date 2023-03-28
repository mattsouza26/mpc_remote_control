// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

abstract class Direction {}

class Drag {
  final Direction startDirection;
  final double value;
  const Drag({
    required this.startDirection,
    required this.value,
  });

  @override
  String toString() => 'Drag(startDirection: $startDirection, value: $value)';
}

enum DragVerticalDirection implements Direction { up, down }

enum DragHorizontalDirection implements Direction { left, right }

class GestureArea extends StatelessWidget {
  final void Function(Drag drag)? onHorizontalDrag;
  final void Function(Drag drag)? onVerticalDrag;

  final void Function()? onTap;
  final void Function()? onHorizontalDragEnd;
  final void Function()? onVerticalDragEnd;
  const GestureArea({
    super.key,
    this.onHorizontalDrag,
    this.onVerticalDrag,
    this.onHorizontalDragEnd,
    this.onVerticalDragEnd,
    this.onTap,
  });
  bool validRange(double value) {
    if (value > 0 && value < 1) {
      return true;
    }
    return false;
  }

  DragVerticalDirection getVerticalDirection(double? value) {
    if (value! > 0) {
      return DragVerticalDirection.down;
    }
    return DragVerticalDirection.up;
  }

  DragHorizontalDirection getHorizontalDirection(double? value) {
    if (value! > 0) {
      return DragHorizontalDirection.right;
    }
    return DragHorizontalDirection.left;
  }

  @override
  Widget build(BuildContext context) {
    Direction? direction;
    return LayoutBuilder(builder: (context, constraints) {
      final size = constraints.maxHeight;
      return GestureDetector(
        onTap: () => onTap?.call(),
        onVerticalDragCancel: () {
          direction = null;
          onVerticalDragEnd?.call();
        },
        onVerticalDragEnd: (_) {
          direction = null;
          onVerticalDragEnd?.call();
        },
        onHorizontalDragEnd: (_) {
          direction = null;
          onHorizontalDragEnd?.call();
        },
        onHorizontalDragCancel: () {
          direction = null;
          onHorizontalDragEnd?.call();
        },
        onVerticalDragUpdate: (details) {
          final verticalDirection = getVerticalDirection(details.primaryDelta);
          direction ??= verticalDirection;
          if (direction is! DragVerticalDirection) return;
          late final double position;
          if (direction == DragVerticalDirection.down) {
            position = double.parse((details.localPosition.dy / size).toStringAsFixed(2));
          } else {
            position = double.parse(((size - details.localPosition.dy) / size).toStringAsFixed(2));
          }

          if (!validRange(position)) return;
          final drag = Drag(startDirection: direction as DragVerticalDirection, value: position);
          onVerticalDrag?.call(drag);
        },
        onHorizontalDragUpdate: (details) {
          final horizontalDirection = getHorizontalDirection(details.primaryDelta);
          direction ??= horizontalDirection;
          if (direction is! DragHorizontalDirection) return;
          late final double position;
          if (direction == DragHorizontalDirection.right) {
            position = double.parse((details.localPosition.dx / size).toStringAsFixed(2));
          } else {
            position = double.parse(((size - details.localPosition.dx) / size).toStringAsFixed(2));
          }

          if (!validRange(position)) return;
          final drag = Drag(startDirection: direction as DragHorizontalDirection, value: position);
          onHorizontalDrag?.call(drag);
        },
        child: CustomPaint(
          size: Size(size, size),
          painter: GestureAreaPainter(),
        ),
      );
    });
  }
}

class GestureAreaPainter extends CustomPainter {
  final Color? color;
  var path = Path();

  GestureAreaPainter({this.color});
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.fill
      ..color = color ?? Colors.transparent;

    final double lineSize = size.width * 0.5;
    final double lineSpacing = lineSize * 0.325;
    final double linePadding = lineSize * 0.025;

    path.moveTo(lineSize - lineSpacing, linePadding);
    path.lineTo(lineSize - lineSpacing, lineSize - lineSpacing);

    path.lineTo(linePadding, lineSize - lineSpacing);
    path.quadraticBezierTo(-pi * 2.25, lineSize, linePadding, lineSize + lineSpacing); //Left corner
    path.lineTo(lineSize - lineSpacing, lineSize + lineSpacing);

    path.lineTo(lineSize - lineSpacing, lineSize * 2 - linePadding);
    path.quadraticBezierTo(lineSize, (lineSize * 2) + pi * 2.25, lineSize + lineSpacing, lineSize * 2 - linePadding); // Bottom corner
    path.lineTo(lineSize + lineSpacing, lineSize + lineSpacing);

    path.lineTo(lineSize * 2 - linePadding, lineSize + lineSpacing);
    path.quadraticBezierTo((lineSize * 2) + pi * 2.25, lineSize, lineSize * 2 - linePadding, lineSize - lineSpacing); // Right corner
    path.lineTo(lineSize + lineSpacing, lineSize - lineSpacing);

    path.lineTo(lineSize + lineSpacing, linePadding);
    path.quadraticBezierTo(lineSize, -pi * 2.25, lineSize - lineSpacing, linePadding); //Top corner
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool hitTest(Offset position) {
    return path.contains(position);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
