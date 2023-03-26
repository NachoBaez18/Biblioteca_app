import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReservasPage extends StatelessWidget {
  const ReservasPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: const [
          HeaderList(titulo: 'Reservas', subtitulo: 'A generar'),
          ListBooks()
        ],
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return Container(
                height: 340,
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20),
                      const Text(
                        'Generador QR',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      QrImage(
                        data: 'hola',
                        version: QrVersions.auto,
                        size: 250,
                        backgroundColor: Colors.white,
                      ),
                      const SizedBox(height: 20)
                    ],
                  ),
                ),
              );
            },
          );
        },
        child: const Icon(FontAwesomeIcons.qrcode),
      ),
    );
  }
}
