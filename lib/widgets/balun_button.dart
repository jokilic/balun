import 'package:flutter/material.dart';

import '../constants.dart';

class BalunButton extends StatefulWidget {
  final Widget child;
  final Function()? onPressed;

  const BalunButton({
    required this.child,
    this.onPressed,
  });

  @override
  State<BalunButton> createState() => _BalunButtonState();
}

class _BalunButtonState extends State<BalunButton> with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: BalunConstants.buttonScaleDuration,
    );

    animation = Tween<double>(begin: 1, end: 0.95).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  Future<void> onTapDown(TapDownDetails details) async {
    await controller.forward();
  }

  Future<void> onTapUp(TapUpDetails details) async {
    await controller.forward();
    await controller.reverse();
    await Future.delayed(
      BalunConstants.buttonScaleDuration,
    );

    if (widget.onPressed != null) {
      widget.onPressed!();
    }
  }

  Future<void> onTapCancel() async {
    await controller.reverse();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: widget.onPressed != null ? onTapDown : null,
        onTapUp: widget.onPressed != null ? onTapUp : null,
        onTapCancel: widget.onPressed != null ? onTapCancel : null,
        child: AnimatedBuilder(
          animation: animation,
          builder: (_, child) => Transform.scale(
            scale: animation.value,
            child: child,
          ),
          child: widget.child,
        ),
      );
}
