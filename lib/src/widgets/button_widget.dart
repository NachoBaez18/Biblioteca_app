import 'package:flutter/material.dart';

class ButtonRedondeado extends StatelessWidget {
  final String texto;
  final Color textColor;
  final Color color;
  final Function()? onpreess;
  final double ancho;
  final double alto;
  const ButtonRedondeado(
      {super.key,
      required this.texto,
      this.textColor = Colors.white,
      this.color = Colors.blue,
      required this.onpreess,
      this.ancho = 150,
      this.alto = 50});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onpreess,
      shape: const StadiumBorder(),
      elevation: 5,
      hoverElevation: 5,
      highlightElevation: 10,
      color: color,
      child: SizedBox(
        width: ancho,
        height: alto,
        child: Center(
          child: Text(
            texto,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
          ),
        ),
      ),
    );
  }
}
