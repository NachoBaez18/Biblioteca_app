import 'package:biblioteca_app/src/services/auth_services.dart';
import 'package:biblioteca_app/src/ui/alertas.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: const [
              _LogoInicio(),
              SizedBox(height: 50),
              _FormLogin(),
              SizedBox(height: 50),
              SizedBox(height: 150),
            ],
          ),
        ),
      ),
    );
  }
}

class _FormLogin extends StatefulWidget {
  const _FormLogin({
    Key? key,
  }) : super(key: key);

  @override
  State<_FormLogin> createState() => _FormLoginState();
}

class _FormLoginState extends State<_FormLogin> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final authServices = Provider.of<AuthServices>(context);
    return Column(
      children: [
        InputLoginWidget(
          icon: FontAwesomeIcons.user,
          placeholder: 'Email',
          textController: emailCtrl,
          keyboardype: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        InputLoginWidget(
          icon: FontAwesomeIcons.unlock,
          placeholder: 'Contraseña',
          textController: passwordCtrl,
          isPassword: true,
        ),
        const SizedBox(height: 20),
        ButtonRedondeado(
          color: Colors.blue.shade300,
          onpreess: authServices.autenticando
              ? null
              : () async {
                  print(emailCtrl.text.trim());
                  FocusScope.of(context).unfocus();
                  final loginOk = await authServices.login(
                    emailCtrl.text.trim(),
                    passwordCtrl.text.trim(),
                  );
                  if (loginOk) {
                    // ignore: use_build_context_synchronously
                    Navigator.pushReplacementNamed(context, 'books_list');
                  } else {
                    // ignore: use_build_context_synchronously
                    mostrarAlerta(context, 'Login incorrecto',
                        'Revise sus credenciales nuevamente');
                  }
                },
          texto: 'Acceder',
          alto: 40,
        ),
      ],
    );
  }
}

class _LogoInicio extends StatelessWidget {
  const _LogoInicio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 180,
        margin: const EdgeInsets.only(top: 150),
        child: Column(
          children: const [
            Image(
              image: AssetImage('assets/logoUninorte_azul.png'),
            ),
            Text(
              'Biblioteca',
              style: TextStyle(
                  fontSize: 20,
                  color: Color(0xfff7c112),
                  fontStyle: FontStyle.normal),
            ),
            SizedBox(height: 30),
            Text(
              'Bienvenido',
              style: TextStyle(
                fontSize: 25,
                color: Colors.black54,
              ),
            )
          ],
        ),
      ),
    );
  }
}
