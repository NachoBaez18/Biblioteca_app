import 'package:flutter/material.dart';

class StarIcons extends StatelessWidget {
  final int cantidad;
  const StarIcons(
    this.cantidad, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        for (int i = 0; i < 5; i++)
          Icon(
            Icons.star,
            color: cantidad <= i ? Colors.amber[100] : Colors.amber,
            size: 18,
          ),
        const SizedBox(width: 10),
        Text(
          '$cantidad.0',
          style:
              const TextStyle(color: Colors.amber, fontWeight: FontWeight.w900),
        )
      ],
    );
  }
}
