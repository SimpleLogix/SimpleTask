import 'package:flutter/material.dart';
import 'dart:math' as math;

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    Key? key,
    this.duration = const Duration(milliseconds: 300),
    this.curve = Curves.linear,
    this.enabled = false,
    required this.child,
  }) : super(key: key);

  final Duration duration;
  final Widget child;
  final Curve curve;
  final bool enabled;

  @override
  _ShakeWidgetState createState() => _ShakeWidgetState();
}

class _ShakeWidgetState extends State<ShakeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )
      ..forward()
      ..addListener(() {
        if (controller.isCompleted) {
          controller.reverse();
        } else if (controller.isDismissed) {
          controller.forward();
        }
      });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// convert 0-1 to 0-1-0
  double shake(double value) =>
      1 * (0.5 - (0.5 - widget.curve.transform(value)).abs());

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) {
      return widget.child;
    }

    final animation = Tween<double>(begin: -2.0, end: 2.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: widget.curve,
      ),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.rotate(
        angle: animation.value * (math.pi / 180),
        child: child,
      ),
      child: widget.child,
    );
  }
}
