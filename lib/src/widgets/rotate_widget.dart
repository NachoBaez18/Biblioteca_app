import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RotateAnimation extends StatefulWidget {
  final Widget child;
  final Duration duration;
  const RotateAnimation(
      {super.key,
      required this.child,
      this.duration = const Duration(milliseconds: 500)});

  @override
  State<RotateAnimation> createState() => _RotateAnimationState();
}

class _RotateAnimationState extends State<RotateAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;

  late Animation rotate;

  @override
  void initState() {
    controller = AnimationController(vsync: this, duration: widget.duration);

    rotate = Tween(begin: 0.0, end: 3.1)
        .animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    controller.forward(from: 0.0);
    return AnimatedBuilder(
        animation: rotate,
        child: widget.child,
        builder: (BuildContext context, Widget? child) {
          Provider.of<FilterListProvider>(context);
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
