import 'package:biblioteca_app/src/widgets/progress_indicator_widget.dart';
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

progresIndicatorModal(BuildContext context) {
  return showDialog(
      context: context, builder: (_) => const ProgresIndicatorMe());
}
