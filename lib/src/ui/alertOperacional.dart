import 'package:flutter/material.dart';

mostrarAlertaOperacional(BuildContext context, String titulo, Widget child) {
  return showDialog(
    context: context,
    builder: (_) => AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0))),
      title: Text(titulo),
      content: child,
    ),
  );
}
