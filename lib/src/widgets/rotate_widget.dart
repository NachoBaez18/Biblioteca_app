import 'package:flutter/material.dart';

class RotateAnimation extends StatefulWidget {
  final Widget child;
  final Function(AnimationController)? controller;
  final Duration duration;
  const RotateAnimation(
      {super.key,
      required this.child,
      this.controller,
      this.duration = const Duration(milliseconds: 500)});

  @override
  State<RotateAnimation> createState() => _RotateAnimationState();
}

class _RotateAnimationState extends State<RotateAnimation>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;

  late Animation rotate;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.duration);

    rotate = Tween(begin: 0.0, end: 3.1)
        .animate(CurvedAnimation(parent: controller!, curve: Curves.easeOut));

    if (widget.controller is Function) {
      widget.controller!(controller!);
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: rotate,
        child: widget.child,
        builder: (BuildContext context, Widget? child) {
          return Transform(
            alignment: Alignment.center,
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.002)
              ..rotateY(rotate.value),
            child: child,
          );
        });
  }
}
