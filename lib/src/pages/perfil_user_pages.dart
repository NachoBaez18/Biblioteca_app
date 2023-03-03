import 'package:flutter/material.dart';

//Todo:Importaciones de terceros
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

//?Mis importaciones
import 'package:biblioteca_app/src/ui/alertas.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';

class PerfilUser extends StatelessWidget {
  const PerfilUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  _UserName(),
                  _ButtonRegresar(),
                ],
              ),
            ),
            const _FromPerfil()
          ],
        ),
      ),
    );
  }
}

class _FromPerfil extends StatefulWidget {
  const _FromPerfil({
    super.key,
  });

  @override
  State<_FromPerfil> createState() => _FromPerfilState();
}

class _FromPerfilState extends State<_FromPerfil> {
  final nombreCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            textController: nombreCtrl),
        const SizedBox(height: 15),
        InputLoginWidget(
            icon: FontAwesomeIcons.at,
            placeholder: 'Correo',
            textController: nombreCtrl),
        const SizedBox(height: 15),
        InputLoginWidget(
          icon: FontAwesomeIcons.unlock,
          placeholder: 'Contraseña',
          textController: nombreCtrl,
          iconSecundario: true,
          onPressed: () {
            mostrarAlerta(
              context,
              'Cambio de contraseña',
             const _CambioDeContrasena(),
             'Cancelar',
             'OK'
            );
          },
        ),
        const SizedBox(height: 20),
        ButtonRedondeado(texto: 'Editar Perfil', onpreess: () {}),
      ],
    );
  }
}

class _CambioDeContrasena extends StatelessWidget {
  const _CambioDeContrasena({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics:const BouncingScrollPhysics(),
      child: Column(
        children:const [
           TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Contraseña Actual",
              enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1,color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(20))
             ),
             focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1,color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(20))
             )
            ),
          ),
          SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Contraseña Nueva",
             enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1,color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(20))
             ),
             focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1,color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(20))
             ),
            ),
          ),
           SizedBox(height: 15),
          TextField(
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: "Repita su nueva Contraseña",
              enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1,color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(20))
             ),
             focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(width: 1,color: Colors.blue),
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
          ),
          )
        ],
      ),
    );
  }
}

class _ButtonRegresar extends StatelessWidget {
  const _ButtonRegresar({
    super.key,
  });

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
  final String user = 'Cristino Baez';
  const _UserName({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 80,
      left: 120,
      child: Text(
        user,
        style: const TextStyle(
            fontSize: 30, color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

class _IconUserRedondeado extends StatelessWidget {
  const _IconUserRedondeado({
    super.key,
  });

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
  const _Header({
    super.key,
  });

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
    );
  }
}
