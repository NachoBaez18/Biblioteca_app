import 'package:animate_do/animate_do.dart';
import 'package:biblioteca_app/src/models/accionLibroResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/carreraResponse.dart';
import '../models/usuario.dart';
import '../provider/ListView/filter_provider.dart';
import '../provider/data_provider.dart';
import 'data_alumno_widget.dart';
import 'package:provider/provider.dart' as p;

class AlumnoList extends StatelessWidget {
  final String titleAppbar;
  final List<Color> colorAppbar;
  final AccionLibroResponse? libroPendientes;
  final WidgetRef ref;
  final bool qr;
  const AlumnoList(
      {super.key,
      required this.titleAppbar,
      required this.colorAppbar,
      required this.libroPendientes,
      required this.ref,
      required this.qr});

  @override
  Widget build(BuildContext context) {
    final provider = p.Provider.of<FilterListProvider>(context);
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: _appBarDesing(),
        body: FadeInLeft(
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: libroPendientes!.accionesDeLibros.length,
            itemBuilder: (_, i) {
              final Usuario? usuario =
                  libroPendientes!.accionesDeLibros[i].usuario;
              return GestureDetector(
                onTap: () {
                  if (qr) {
                  } else {
                    provider.isDetalle = false;
                    ref.read(carreraFilterProvider.notifier).update((state) =>
                        Carrera(nombre: 'entregado', uid: usuario.uid!));
                    Navigator.pushNamed(context, 'detalle_alumno');
                  }
                },
                child: DataAlumno(
                  usuario: usuario!,
                ),
              );
            },
          ),
        ));
  }
}

AppBar _appBarDesing() {
  return AppBar(
      elevation: 0,
      title: const Text(
        'Pendientes',
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFCCCB), // Color del lado izquierdo del gradiente
              Color.fromARGB(255, 218, 56, 56)
            ],
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ));
}
