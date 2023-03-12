import 'package:flutter/material.dart';

class ShakeWidget extends StatefulWidget {
  const ShakeWidget({
    Key? key,
    this.duration = const Duration(milliseconds: 800),
    this.deltaX = 4,
    this.deltaY = 4,
    this.curve = Curves.bounceOut,
    required this.child,
  }) : super(key: key);

  final Duration duration;
  final double deltaX;
  final double deltaY;
  final Widget child;
  final Curve curve;

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
          controller.repeat();
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
      2 * (0.5 - (0.5 - widget.curve.transform(value)).abs());

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) => Transform.translate(
        offset: Offset(
          widget.deltaX * shake(controller.value),
          -widget.deltaY * shake(controller.value),
        ),
        child: child,
      ),
      child: widget.child,
    );
  }
}
