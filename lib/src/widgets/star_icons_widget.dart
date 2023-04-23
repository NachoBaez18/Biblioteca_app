import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class StarIcons extends StatelessWidget {
  final double cantidad;
  const StarIcons(
    this.cantidad, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < 5; i++)
          FadeInLeft(
            delay: Duration(milliseconds: i * 100),
            duration: const Duration(milliseconds: 300),
            child: Icon(
              Icons.star,
              color: cantidad <= i ? Colors.amber[100] : Colors.amber,
              size: 18,
            ),
          ),
        const SizedBox(width: 10),
        Bounce(
          delay: const Duration(seconds: 1),
          from: 8,
          child: Text(
            '$cantidad',
            style: const TextStyle(
                color: Colors.amber, fontWeight: FontWeight.w900),
          ),
        )
      ],
    );
  }
}
