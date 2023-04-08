import 'package:biblioteca_app/src/services/services.dart';
import 'package:biblioteca_app/src/ui/alertas_new.dart';
import 'package:flutter/material.dart';

//Todo:Importaciones de terceros
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//?Mis importaciones
import 'package:biblioteca_app/src/ui/alertas.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart';

import '../provider/provider.dart';

class PerfilUser extends StatelessWidget {
  const PerfilUser({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacementNamed(context, 'home');
        return false;
      },
      child: Scaffold(
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 300,
                child: Stack(
                  children: const [
                    _Header(),
                    _IconUserRedondeado(),
                    _ButtonRegresar(),
                  ],
                ),
              ),
              const _FromPerfil()
            ],
          ),
        ),
      ),
    );
  }
}

class _FromPerfil extends StatefulWidget {
  const _FromPerfil();

  @override
  State<_FromPerfil> createState() => _FromPerfilState();
}

class _FromPerfilState extends State<_FromPerfil> {
  final nombreCtrl = TextEditingController();
  final telefonoCtrl = TextEditingController();
  final correoCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    nombreCtrl.text = authService.usuario.nombre!;
    telefonoCtrl.text = authService.usuario.telefono!;
    correoCtrl.text = authService.usuario.email!;
    return Column(
      children: [
        InputLoginWidget(
            icon: FontAwesomeIcons.user,
            placeholder: 'Nombre',
            textController: nombreCtrl),
        const SizedBox(height: 15),
        InputLoginWidget(
            icon: FontAwesomeIcons.phone,
            placeholder: 'Numero de Telefono',
            textController: telefonoCtrl),
        const SizedBox(height: 15),
        InputLoginWidget(
            icon: FontAwesomeIcons.at,
            placeholder: 'Correo',
            textController: correoCtrl),
        const SizedBox(height: 15),
        InputLoginWidget(
          icon: FontAwesomeIcons.unlock,
          enable: false,
          placeholder: 'Contraseña',
          textController: TextEditingController(),
          iconSecundario: true,
          onPressed: () async {
            mostrarAlerta(context, 'Cambio de contraseña',
                const _CambioDeContrasena(), 'Cancelar', 'OK', () async {
              _updatePassword(authService.usuario.uid);
            });
          },
        ),
        const SizedBox(height: 20),
        ButtonRedondeado(
            texto: 'Editar Perfil',
            onpreess: () async {
              await _updateUser(context, authService.usuario.uid);
            }),
      ],
    );
  }

  _updateUser(BuildContext context, uid) async {
    final authService = AuthServices();
    final response = await authService.usuarioUpdate(nombreCtrl.text.trim(),
        telefonoCtrl.text.trim(), correoCtrl.text.trim(), uid);

    if (!context.mounted) {
      return false;
    }
    if (!response.error) {
      AlertasNew()
          .alertaCorrectaNavegatoria(context, response.mensaje, 'loading');
    } else {
      AlertasNew()
          .alertaInCorrectaNavegatoria(context, response.mensaje, 'loading');
    }
  }

  _updatePassword(uid) async {
    final stateProvider =
        Provider.of<FilterListProvider>(context, listen: false);
    final String password = stateProvider.password;
    final String passwordNew = stateProvider.passwordNew;
    final String passwordNewRepit = stateProvider.passwordNewRepit;

    if (password == '' || passwordNew == '' || passwordNewRepit == '') {
      AlertasNew().alertaInCorrectaNavegatoria(
          context, 'Todos los datos son necesarios', 'perfil');
    } else {
      if (passwordNew != passwordNewRepit) {
        AlertasNew().alertaInCorrectaNavegatoria(
            context, 'La nueva constraseña no coinciden', 'perfil');
      } else {
        final authService = AuthServices();
        final response =
            await authService.updatePassword(password, passwordNew, uid);

        if (!context.mounted) {
          return false;
        }
        if (!response.error) {
          AlertasNew()
              .alertaCorrectaNavegatoria(context, response.mensaje, 'loading');
        } else {
          AlertasNew().alertaInCorrectaNavegatoria(
              context, response.mensaje, 'loading');
        }
      }
    }
  }
}

class _CambioDeContrasena extends StatelessWidget {
  const _CambioDeContrasena();

  @override
  Widget build(BuildContext context) {
    final stateProvider = Provider.of<FilterListProvider>(context);
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Contraseña Actual",
              enabledBorder: _outlineInputBorder(),
              focusedBorder: _outlineInputBorder(),
            ),
            onChanged: (value) {
              stateProvider.password = value;
            },
          ),
          const SizedBox(height: 15),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Contraseña Nueva",
              enabledBorder: _outlineInputBorder(),
              focusedBorder: _outlineInputBorder(),
            ),
            onChanged: (value) {
              stateProvider.passwordNew = value;
            },
          ),
          const SizedBox(height: 15),
          TextField(
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Repita su nueva Contraseña",
              enabledBorder: _outlineInputBorder(),
              focusedBorder: _outlineInputBorder(),
            ),
            onChanged: (value) {
              stateProvider.passwordNewRepit = value;
            },
          )
        ],
      ),
    );
  }

  OutlineInputBorder _outlineInputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(width: 1, color: Colors.blue),
        borderRadius: BorderRadius.all(Radius.circular(20)));
  }
}

class _ButtonRegresar extends StatelessWidget {
  const _ButtonRegresar();

  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 25,
        left: 15,
        child: IconButton(
          color: Colors.white,
          onPressed: () => Navigator.pushReplacementNamed(context, 'home'),
          icon: const Icon(Icons.arrow_back_sharp, size: 40),
        ));
  }
}

class _UserName extends StatelessWidget {
  const _UserName();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthServices>(context);
    return Center(
      child: Text(
        authService.usuario.nombre!,
        style: const TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _IconUserRedondeado extends StatelessWidget {
  const _IconUserRedondeado();

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 150,
      left: 140,
      child: Container(
        height: 120,
        width: 120,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(100)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 4), // changes position of shadow
              ),
            ]),
        child: const Icon(
          Icons.switch_account_sharp,
          color: Colors.blue,
          size: 100,
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: <Color>[
              Color(0xff66A9F2),
              Color(0xff536CF6),
            ],
          ),
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(100),
              bottomRight: Radius.circular(100))),
      child: const _UserName(),
    );
  }
}
