import 'package:animate_do/animate_do.dart';
import 'package:biblioteca_app/src/models/accionLibroResponse.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:biblioteca_app/src/ui/alertas_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/carreraResponse.dart';
import '../models/usuario.dart';
import '../provider/ListView/filter_provider.dart';
import '../provider/data_provider.dart';
import '../ui/alertOperacional.dart';
import 'data_alumno_widget.dart';
import 'package:provider/provider.dart' as p;

class AlumnoList extends StatelessWidget {
  final String titleAppbar;
  final List<Color> colorAppbar;
  final AccionLibroResponse? libroPendientes;
  final WidgetRef ref;
  final bool qr;
  final bool isSearch;
  final Function()? searchOnPress;
  const AlumnoList(
      {super.key,
      required this.titleAppbar,
      required this.colorAppbar,
      required this.libroPendientes,
      required this.ref,
      required this.qr,
      this.isSearch = false,
      this.searchOnPress});

  @override
  Widget build(BuildContext context) {
    final provider = p.Provider.of<FilterListProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: appBarDesing(titleAppbar, colorAppbar, isSearch, searchOnPress),
      body: FadeInLeft(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: libroPendientes!.accionesDeLibros.length,
          itemBuilder: (_, i) {
            final Usuario? usuario =
                libroPendientes!.accionesDeLibros[i].usuario;
            return GestureDetector(
              onDoubleTap: () async {
                if (qr) {
                  final String accionPost;
                  if (libroPendientes!.accionesDeLibros[i].accion ==
                      'reservado') {
                    accionPost = 'entregado';
                  } else {
                    accionPost = 'devuelto';
                  }
                  final navigator = Navigator.of(context);
                  progresIndicatorModal(context);
                  final libroServices = LibroServices();
                  final response = await libroServices.accionRealizada(
                      accionPost, libroPendientes!.accionesDeLibros[i].uid!);
                  if (!response['error']) {
                    if (context.mounted) {
                      navigator.pop();
                      AlertasNew().alertaCorrectaNavegatoria(
                          context, response['mensaje'], 'home');
                    }
                  } else {
                    navigator.pop();
                    if (context.mounted) {
                      AlertasNew().alertaInCorrectaNavegatoria(
                          context, response['mensaje'], 'home');
                    }
                  }
                }
              },
              onTap: () {
                if (qr) {
                  provider.isDetalle = false;
                  ref.read(carreraFilterProvider.notifier).update((state) =>
                      Carrera(
                          nombre: libroPendientes!.accionesDeLibros[i].accion!,
                          uid: usuario.uid!));
                  Navigator.pushNamed(context, 'detalle_alumno');
                } else {
                  provider.isDetalle = false;
                  ref.read(carreraFilterProvider.notifier).update((state) =>
                      Carrera(nombre: 'entregado', uid: usuario.uid!));
                  Navigator.pushNamed(context, 'detalle_alumno');
                }
              },
              child: DataAlumno(
                usuario: usuario!,
                accion:
                    libroPendientes!.accionesDeLibros[i].accion == 'reservado'
                        ? 'Entrega'
                        : 'Devolucion',
              ),
            );
          },
        ),
      ),
    );
  }
}

AppBar appBarDesing(titleAppbar, colorAppbar, isSearch, searchOnPress) {
  return AppBar(
      actions: [
        isSearch
            ? IconButton(
                onPressed: searchOnPress,
                icon: const Icon(
                  Icons.search,
                  size: 30,
                ))
            : Container()
      ],
      elevation: 0,
      title: Text(
        titleAppbar,
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: colorAppbar,
            begin: Alignment.bottomLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ));
}
