import 'package:flutter/material.dart';

class ButtonRedondeado extends StatelessWidget {
  final String texto;
  final Color textColor;
  final Color color;
  final Function() onpreess;
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
    return Container(
        width: ancho,
        height: alto,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ]),
        child: MaterialButton(
          onPressed: () {},
          shape: const StadiumBorder(),
          elevation: 5,
          highlightElevation: 10,
          child: Center(
            child: Text(
              texto,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
        ));
  }
}
