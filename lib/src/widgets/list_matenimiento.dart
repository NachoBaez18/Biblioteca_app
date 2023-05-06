import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../provider/data_provider.dart';
//import 'package:provider/provider.dart' as p;

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

class LisAlumnoWidget extends StatelessWidget {
  final dynamic usuarios;
  final bool isFloating;
  const LisAlumnoWidget({super.key, this.usuarios, required this.isFloating});

  @override
  Widget build(BuildContext context) {
    return usuarios!.isEmpty
        ? Scaffold(
            body: FadeInLeft(
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
            body: FadeInLeft(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: usuarios!.length,
                itemBuilder: (context, i) {
                  return GestureDetector(
                    onTap: () {},
                    onDoubleTap: () {},
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(usuarios![i].nombre),
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
                    onPressed: () {},
                    child: const Icon(FontAwesomeIcons.plus),
                  ),
                ),
              ),
            ),
          );
  }
}

class ListCarreras extends ConsumerWidget {
  const ListCarreras({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final carreras = ref.watch(carreraDataProvider);

    return carreras.when(
        data: (carreras) {
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
                    onTap: () {},
                    onDoubleTap: () {},
                    child: Column(
                      children: [
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
                  onPressed: () {},
                  child: const Icon(
                    FontAwesomeIcons.plus,
                  ),
                ),
              ),
            ),
          );
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
