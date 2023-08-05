import 'dart:convert';

import 'package:biblioteca_app/src/provider/provider.dart';
import 'package:biblioteca_app/src/services/auth_services.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:provider/provider.dart' as p;

import '../provider/data_provider.dart';

class ReservasPage extends ConsumerWidget {
  const ReservasPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final libros = ref.watch(libroDataProvider);
    final valores = p.Provider.of<FilterListProvider>(context);
    final usuario = p.Provider.of<AuthServices>(context);
    return WillPopScope(
      onWillPop: () async {
        valores.isDetalle = true;
        Navigator.pushReplacementNamed(context, 'home');
        return false;
      },
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            HeaderList(
              titulo: valores.reservaDevolucionTitulo['titulo']!,
              subtitulo: valores.reservaDevolucionTitulo['subTitulo']!,
              search: false,
            ),
            const ListBooks()
          ],
        )),
        floatingActionButton: Visibility(
          visible: !usuario.admin || valores.isDetalle,
          child: FloatingActionButton(
            backgroundColor: Colors.blueAccent,
            onPressed: () {
              final String jsonString = jsonEncode(libros.value!.toMap());
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
                            data: jsonString,
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
        ),
      ),
    );
  }
}
