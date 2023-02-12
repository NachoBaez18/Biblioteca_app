import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: const [
              _LogoInicio(),
              SizedBox(
                height: 50,
              ),
              _FormLogin(),
              _ButtonAccess()
            ],
          ),
        ),
      ),
    );
  }
}

class _ButtonAccess extends StatelessWidget {
  const _ButtonAccess({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
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
    return Column(
      children: [
        InputLoginWidget(
          icon: FontAwesomeIcons.user,
          placeholder: 'Email',
          textController: emailCtrl,
          keyboardype: TextInputType.emailAddress,
        ),
        const SizedBox(
          height: 20,
        ),
        InputLoginWidget(
          icon: FontAwesomeIcons.unlock,
          placeholder: 'Contraseña',
          textController: passwordCtrl,
          isPassword: true,
        )
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
        margin: const EdgeInsets.all(20),
        child: Column(
          children: const [
            Image(
              image: AssetImage('assets/logoUninorte_azul.png'),
            ),
            Text(
              'Bienvenido',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.black38,
                  fontStyle: FontStyle.italic),
            )
          ],
        ),
      ),
    );
  }
}
