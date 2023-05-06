import 'package:flutter/material.dart';

//Todo:Importaciones de terceros

//?Mis importaciones

import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';
import 'package:biblioteca_app/src/services/services.dart';

import '../ui/alertas_new.dart';

class PerfilUser extends StatelessWidget {
  final nombreCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  PerfilUser({super.key});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<AuthServices>(context);
    nombreCtrl.text = user.usuario.nombre ?? '';
    telefonoCtrl.text = user.usuario.telefono ?? '';
    correoCtrl.text = user.usuario.email ?? '';
    return WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, 'home');
          return false;
        },
        child: CargaGenericaUser(
          headerTitle: user.usuario.nombre!,
          navigator: 'home',
          correoCtrl: correoCtrl,
          nombreCtrl: nombreCtrl,
          telefonoCtrl: telefonoCtrl,
          titleButton: 'Editar Perfil',
          onPreess: () {
            _updateUser(context, user.usuario.uid);
          },
        ));
  }

  _updateUser(BuildContext context, uid) async {
    final authService = AuthServices();
    final response = await authService.usuarioUpdate(nombreCtrl.text.trim(),
        telefonoCtrl.text.trim(), correoCtrl.text.trim(), uid);

    if (context.mounted) {
      if (!response.error) {
        AlertasNew()
            .alertaCorrectaNavegatoria(context, response.mensaje, 'loading');
      } else {
        AlertasNew()
            .alertaInCorrectaNavegatoria(context, response.mensaje, 'loading');
      }
    }
  }
}
