import 'package:biblioteca_app/src/models/usuarioResponse.dart';
import 'package:flutter/material.dart';

import 'cargaGenericaUser.dart';

class PerfilUser extends StatelessWidget {
  final dynamic usuario;
  final nombreCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  PerfilUser({super.key, required this.usuario});

  @override
  Widget build(BuildContext context) {
    if (usuario != null) {
      nombreCtrl.text = usuario.nombre;
      telefonoCtrl.text = usuario.telefono;
      correoCtrl.text = usuario.email;
    }

    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, 'home');
          return false;
        },
        child: CargaGenericaUser(
          headerTitle: usuario == null ? 'Registre Usuario' : usuario.nombre,
          navigator: 'home',
          correoCtrl: correoCtrl,
          nombreCtrl: nombreCtrl,
          telefonoCtrl: telefonoCtrl,
          titleButton: usuario == null ? 'Editar' : 'Registrar',
          onPreess: () {
            if (usuario != null) {
              _updateUser(context);
            } else {
              _createUser(context);
            }
          },
        ));
  }

  _updateUser(BuildContext context) async {
    // final authService = AuthServices();
    // final response = await authService.usuarioUpdate(nombreCtrl.text.trim(),
    //     telefonoCtrl.text.trim(), correoCtrl.text.trim(), uid);

    // if (context.mounted) {
    //   if (!response.error) {
    //     AlertasNew()
    //         .alertaCorrectaNavegatoria(context, response.mensaje, 'loading');
    //   } else {
    //     AlertasNew()
    //         .alertaInCorrectaNavegatoria(context, response.mensaje, 'loading');
    //   }
    // }
  }

  void _createUser(BuildContext context) {
    // final authService = AuthServices();
    // final response = await authService.usuarioUpdate(nombreCtrl.text.trim(),
    //     telefonoCtrl.text.trim(), correoCtrl.text.trim(), uid);

    // if (context.mounted) {
    //   if (!response.error) {
    //     AlertasNew()
    //         .alertaCorrectaNavegatoria(context, response.mensaje, 'loading');
    //   } else {
    //     AlertasNew()
    //         .alertaInCorrectaNavegatoria(context, response.mensaje, 'loading');
    //   }
    // }
  }
}
