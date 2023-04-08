import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InputLoginWidget extends StatelessWidget {
  final IconData icon;
  final bool? iconSecundario;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardype;
  final bool isPassword;
  final Function()? onPressed;
  final bool? enable;
  const InputLoginWidget(
      {super.key,
      required this.icon,
      required this.placeholder,
      required this.textController,
      this.iconSecundario = false,
      this.keyboardype = TextInputType.text,
      this.isPassword = false,
      this.onPressed,
      this.enable = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 40, left: 40, top: 10),
          height: 50,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ]),
          child: Container(
            margin: const EdgeInsets.only(left: 85, right: 15),
            child: TextField(
              enabled: enable,
              controller: textController,
              autocorrect: false,
              obscureText: isPassword,
              keyboardType: keyboardype,
              decoration: InputDecoration(
                  focusedBorder: InputBorder.none,
                  border: InputBorder.none,
                  hintText: placeholder),
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 40),
          width: 70,
          height: 70,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withOpacity(0.1),
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: const Offset(0, 4), // changes position of shadow
                ),
              ]),
          child: Icon(
            icon,
            size: 30,
            color: Colors.blue[300],
          ),
        ),
        if (iconSecundario!)
          Positioned(
            top: 13,
            right: 60,
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.upRightAndDownLeftFromCenter,
                  color: Colors.black26),
              onPressed: onPressed,
            ),
          )
      ],
    );
  }
}
