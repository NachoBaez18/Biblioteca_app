import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//todo: Importaciones de terceros
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';
//? Mis importaciones
import 'package:biblioteca_app/src/pages/pages.dart';
import 'package:biblioteca_app/src/services/services.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Container(
            decoration: const BoxDecoration(
                color: Colors.blue,
                gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.topCenter,
                  colors: [
                    Color(0xff0a4e93),
                    Color(0xff1a3359),
                  ],
                )),
            child: ElasticIn(
              duration: const Duration(seconds: 2),
              child: Container(
                margin: const EdgeInsets.only(right: 40, left: 40),
                child: const Image(
                  image: AssetImage('assets/logoUni.png'),
                  alignment: Alignment.center,
                ),
              ),
            ),
          );
        });
  }

  Future checkLoginState(BuildContext context) async {
    final authService = Provider.of<AuthServices>(context, listen: false);
    //  final socketService = Provider.of<SocketService>(context, listen: false);

    const storage = FlutterSecureStorage();
    final token = await storage.read(key: 'token');
    if (!context.mounted) return;
    Provider.of<FilterListProvider>(context, listen: false).opacity = 1;

    //final sokectServices = Provider.of<SocketService>(context, listen: false);
    final autenticado = await authService.isLoggedIn();
    if (autenticado) {
      //todo: comectar al sokect
      // socketService.connect();
      //Navigator.pushReplacementNamed(context, 'usuarios');
      //* Por la transicion cambiamos la forma de como mandamos a llamar la ruta
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => const HomePage(),
            transitionDuration: const Duration(milliseconds: 0)),
      );
    } else {
      //Navigator.pushReplacementNamed(context, 'login');
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
            pageBuilder: (_, __, ___) => const LoginPage(),
            transitionDuration: const Duration(milliseconds: 0)),
      );
    }
  }
}
