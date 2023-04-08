import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class AlertasNew {
  alertaCorrectaNavegatoria(context, mensaje, String navegar) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.success,
      animType: AnimType.rightSlide,
      title: 'Acción correcta',
      desc: mensaje,
      btnOkOnPress: () {
        Navigator.pushReplacementNamed(context, navegar);
      },
    ).show();
  }

  alertaInCorrectaNavegatoria(context, mensaje, navegar) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Error en la acción',
      desc: mensaje,
      btnOkOnPress: () {
        Navigator.pushReplacementNamed(context, navegar);
      },
    ).show();
  }
}
