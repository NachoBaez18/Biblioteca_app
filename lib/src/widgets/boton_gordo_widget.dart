import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BotonGordo extends StatelessWidget {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final Function() onpress;

  const BotonGordo(
      {super.key,
      this.icon = FontAwesomeIcons.carBurst,
      required this.texto,
      this.color1 = Colors.grey,
      this.color2 = Colors.blueGrey,
      required this.onpress});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Stack(
        children: [
          _botonGordoBackground(color1, color2, icon),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
             const SizedBox(
                height: 140,
                width: 40,
              ),
              FaIcon(
                icon,
                color: Colors.white,
                size: 40,
              ),
             const SizedBox(
                width: 20,
              ),
              Expanded(
                child: Text(
                  this.texto,
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
             const FaIcon(
                FontAwesomeIcons.chevronRight,
                color: Colors.white,
              ),
             const SizedBox(
                width: 40,
              )
            ],
          )
        ],
      ),
    );
  }
}

class _botonGordoBackground extends StatelessWidget {
  final Color color1;
  final Color color2;
  final IconData icon;
  const _botonGordoBackground(this.color1, this.color2, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      // ignore: sort_child_properties_last
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Stack(
          children: [
            Positioned(
                right: -20,
                top: -20,
                child: FaIcon(
                  icon,
                  size: 150,
                  color: Colors.white.withOpacity(0.2),
                ))
          ],
        ),
      ),
      width: double.infinity,
      height: 100,
      margin:const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.red,
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                offset:const Offset(4, 6),
                blurRadius: 10),
          ],
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(colors: [color1, color2])),
    );
  }
}