import 'package:flutter/material.dart';
import 'package:mpc_remote_control/app/features/server/domain/entities/media_status_entity.dart';

import '../../../../../../core/widgets/neumorphic_button/neumorphic_button.dart';

class ControllerPlayPauseButton extends StatefulWidget {
  final FileState? state;
  final double? size;
  final void Function()? onPressed;
  final void Function()? onLongPress;

  const ControllerPlayPauseButton({
    super.key,
    this.size,
    required this.state,
    this.onPressed,
    this.onLongPress,
  });

  @override
  State<ControllerPlayPauseButton> createState() => _ControllerPlayPauseButtonState();
}

class _ControllerPlayPauseButtonState extends State<ControllerPlayPauseButton> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  late final CurvedAnimation _curvedAnimation;
  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    _curvedAnimation = CurvedAnimation(parent: _animationController, curve: Curves.easeInOutCirc);
    super.initState();
  }

  @override
  void didUpdateWidget(covariant ControllerPlayPauseButton oldWidget) {
    if (widget.state == FileState.reproducing) {
      _animationController.animateTo(1);
    } else {
      _animationController.animateBack(0);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      onLongPress: widget.onLongPress,
      child: NeumorphicButton(
        height: widget.size,
        width: widget.size,
        borderRadius: BorderRadius.all(Radius.circular(widget.size ?? 10)),
        child: Center(
          child: AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return AnimatedIcon(
                  icon: AnimatedIcons.play_pause,
                  progress: _curvedAnimation,
                );
              }),
        ),
      ),
    );
  }
}
