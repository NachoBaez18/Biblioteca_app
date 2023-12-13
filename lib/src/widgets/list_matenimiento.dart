import 'package:animate_do/animate_do.dart';
import 'package:biblioteca_app/src/models/usuario.dart';
import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:biblioteca_app/src/ui/alertas_new.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../models/carreraResponse.dart';
import '../provider/data_provider.dart';
import '../ui/alertOperacional.dart';
import 'package:provider/provider.dart' as p;

class ListMantenimiento extends StatelessWidget {
  final bool isView;
  const ListMantenimiento({super.key, required this.isView});

  @override
  Widget build(BuildContext context) {
    return isView ? const ListAlumnos() : const ListCarreras();
  }
}

class ListAlumnos extends ConsumerWidget {
  const ListAlumnos({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usuarios = ref.watch(usuarioDataProvider);

    return usuarios.when(
        data: (usuarios) {
          return LisAlumnoWidget(
            usuarios: usuarios.usuarios,
            isFloating: true,
          );
        },
        error: (err, st) => Text(err.toString()),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class LisAlumnoWidget extends ConsumerWidget {
  final List<Usuario>? usuarios;
  final bool isFloating;
  const LisAlumnoWidget({super.key, this.usuarios, required this.isFloating});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: FadeInLeft(
        child: usuarios!.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    // SizedBox(height: 200),
                    Text(
                      'No existen datos',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ],
                ),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: usuarios!.length,
                itemBuilder: (context, i) {
                  final provider =
                      p.Provider.of<FilterListProvider>(context, listen: false);
                  return GestureDetector(
                    onTap: () {
                      final refcarreras = ref.watch(carreraDataProvider).value;
                      provider.carrera = usuarios![i].carrera!;
                      provider.tipo = usuarios![i].tipo! == 'administrador'
                          ? 'administrador'
                          : 'alumno';
                      final value = {
                        'usuario': usuarios![i],
                        'carrera': refcarreras,
                      };

                      Navigator.pushNamed(
                        context,
                        'registerEditUser',
                        arguments: value,
                      );
                    },
                    onDoubleTap: () {
                      eliminar(context, i);
                    },
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(usuarios![i].nombre!),
                          trailing: ElasticIn(
                              delay: const Duration(seconds: 1),
                              child: const Icon(Icons.arrow_forward_ios)),
                        ),
                        const CustomDivider()
                      ],
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: Visibility(
        visible: isFloating,
        child: FadeInLeft(
          child: Bounce(
            from: 8,
            delay: const Duration(seconds: 1),
            child: FloatingActionButton(
              backgroundColor: const Color(0xFFadb039),
              onPressed: () {
                final provider =
                    p.Provider.of<FilterListProvider>(context, listen: false);
                final refcarreras = ref.watch(carreraDataProvider).value;
                // refcarreras!.carreras.last.nombre = 'Seleccione una carrera';
                // if (refcarreras.carreras.last.nombre !=
                //     'Seleccione una carrera') {
                //   refcarreras.carreras.add(
                //       Carrera(nombre: 'Seleccione una carrera', uid: '-1'));
                // }
                provider.carrera = 'Seleccione una carrera';
                provider.tipo = '';
                // (refcarreras.carreras.map((element) {
                //   print(element);
                // }));

                final value = {
                  'usuario': Usuario(),
                  'carrera': refcarreras,
                };

                Navigator.pushNamed(context, 'registerEditUser',
                    arguments: value);
              },
              child: const Icon(FontAwesomeIcons.plus),
            ),
          ),
        ),
      ),
    );
  }

  void eliminar(BuildContext context, int i) {
    AlertasNew().alertaEliminacion(
        context, 'Eliminación', '¿Realmente deseas eliminar el usuario?',
        () async {
      progresIndicatorModal(context);
      final navigator = Navigator.of(context);
      final usuario = UsuarioServices();
      final Map<String, dynamic> response =
          await usuario.eliminar(usuarios![i].uid!);
      if (context.mounted) {
        navigator.pop();
        if (!response['error']) {
          AlertasNew()
              .alertaCorrectaNavegatoria(context, response['mensaje'], 'home');
        } else {
          AlertasNew().alertaInCorrectaNavegatoria(
              context, response['mensaje'], 'home');
        }
      }
    }, () {});
  }
}

class ListCarreras extends ConsumerWidget {
  const ListCarreras({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carreras = ref.watch(carreraDataProvider);

    return carreras.when(
        data: (carreras) {
          // ref.refresh(carreraDataProvider);
          return ListCarreraWidget(
            carreras: carreras,
          );
        },
        error: (err, st) => Text(err.toString()),
        loading: () => const Center(child: CircularProgressIndicator()));
  }
}

class ListCarreraWidget extends StatelessWidget {
  final dynamic carreras;
  const ListCarreraWidget({super.key, this.carreras});

  @override
  Widget build(BuildContext context) {
    return carreras.carreras.isEmpty
        ? Scaffold(
            body: FadeInRight(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 200),
                    Text(
                      'No existen datos',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.black38,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                    ),
                  ],
                ),
              ),
            ),
          )
        : Scaffold(
            body: FadeInRight(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: carreras.carreras.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {
                      final data = {'carrera': carreras.carreras[i]};
                      Navigator.pushNamed(context, 'registerEditCarrera',
                          arguments: data);
                    },
                    onDoubleTap: () {
                      eliminar(context, i);
                    },
                    child: Column(
                      children: [
                        if (carreras.carreras[i].nombre ==
                            'Seleccione una carrera')
                          Container()
                        else
                          ListTile(
                            title: Text(carreras.carreras[i].nombre),
                            trailing: ElasticIn(
                                delay: const Duration(seconds: 1),
                                child: const Icon(Icons.arrow_forward_ios)),
                          ),
                        const CustomDivider()
                      ],
                    ),
                  );
                },
              ),
            ),
            floatingActionButton: FadeInRight(
              child: Bounce(
                from: 8,
                delay: const Duration(seconds: 1),
                child: FloatingActionButton(
                  backgroundColor: const Color(0xFFadb039),
                  onPressed: () {
                    final data = {'carrera': Carrera(nombre: '', uid: '')};
                    Navigator.pushNamed(context, 'registerEditCarrera',
                        arguments: data);
                  },
                  child: const Icon(
                    FontAwesomeIcons.plus,
                  ),
                ),
              ),
            ),
          );
  }

  void eliminar(BuildContext context, int i) {
    AlertasNew().alertaEliminacion(
        context, 'Eliminación', '¿Realmente deseas eliminar la carrera?',
        () async {
      final carrera = CarreraServices();
      final Map<String, dynamic> response =
          await carrera.eliminar(carreras.carreras[i].uid);
      if (context.mounted) {
        if (!response['error']) {
          AlertasNew()
              .alertaCorrectaNavegatoria(context, response['mensaje'], 'home');
        } else {
          AlertasNew().alertaInCorrectaNavegatoria(
              context, response['mensaje'], 'home');
        }
      }
    }, () {});
  }
}

class CustomDivider extends StatelessWidget {
  final double thickness;
  final double indent;
  final double endIndent;

  const CustomDivider({
    Key? key,
    this.thickness = 0.5,
    this.indent = 16,
    this.endIndent = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: thickness,
      margin: EdgeInsetsDirectional.only(
        start: indent,
        end: endIndent,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: thickness,
            color: Colors.grey[300]!,
          ),
        ),
      ),
    );
  }
}
