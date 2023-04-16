import 'package:animate_do/animate_do.dart';

import 'package:biblioteca_app/src/models/libro.dart';
import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:biblioteca_app/src/provider/data_provider.dart';
import 'package:biblioteca_app/src/services/services.dart';

import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

//todo: Importaciones de terceros
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

class ListBooks extends riverpod.ConsumerWidget {
  const ListBooks({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final libros = ref.watch(libroDataProvider);

    return libros.when(
      data: (libros) {
        return libros.accionesDeLibros[0].libro.isEmpty
            ? FadeInLeft(
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
              )
            : Expanded(
                child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: libros.accionesDeLibros[0].libro.length,
                    itemBuilder: (_, int i) {
                      return _ListBooksinAnimation(
                        libros.accionesDeLibros[0].libro[i],
                      );
                    }),
              ));
      },
      error: (err, st) => Text(err.toString()),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

class _ListBooksinAnimation extends StatelessWidget {
  final Libro libro;
  const _ListBooksinAnimation(this.libro);

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<FilterListProvider>(context);
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: _CardPrimario(libro),
        ),
        Positioned(
          left: 30,
          top: 25,
          child: animation.rotate
              ? RotateAnimation(
                  child: _CardSecuandario(libro),
                )
              : _CardSecuandario(libro),
        )
      ],
    );
  }
}

class _CardPrimario extends StatelessWidget {
  final Libro libro;
  const _CardPrimario(
    this.libro, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterListProvider>(context);
    final user = Provider.of<AuthServices>(context);
    final envio = Provider.of<LibroServices>(context);
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            if (provider.isDetalle) {
              if (user.admin) {
                provider.isEdit = true;
                envio.selectedLibro = libro;
                Navigator.pushNamed(context, 'book_register_edit');
              } else {
                provider.hero = true;
                Navigator.pushNamed(context, 'book_detail',
                    arguments: {libro: libro});
              }
            }
          },
          child: Hero(
            tag: 'dash${libro.uid}',
            child: provider.hero
                ? Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 30),
                    height: 250,
                    width: 200,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: FadeInImage(
                        placeholder: const AssetImage('assets/jar-loading.gif'),
                        image: NetworkImage(libro.imagen),
                        fit: BoxFit.fill,
                      ),
                    ),
                  )
                : FadeInUp(
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      height: 250,
                      width: 200,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: FadeInImage(
                          placeholder:
                              const AssetImage('assets/jar-loading.gif'),
                          image: NetworkImage(libro.imagen),
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
          ),
        ),
        if (libro.cantidad == 0)
          Positioned(
            right: 40,
            top: 20,
            child: FadeInUp(
              child: Container(
                height: 30,
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    'No disponible',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _CardSecuandario extends StatelessWidget {
  final Libro libro;
  const _CardSecuandario(this.libro);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterListProvider>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      height: 200,
      width: 170,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 10,
              blurRadius: 7,
              offset: const Offset(0, 4), // changes position of shadow
            ),
          ]),
      child: Opacity(
        opacity: provider.opacity,
        child: FadeInDown(
          from: 20,
          child: Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  libro.nombre,
                  maxLines: 2,
                  style: const TextStyle(
                      fontSize: 17, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  libro.creador,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black26),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(height: 25),
                const StarIcons(3),
                const SizedBox(height: 30),
                Row(
                  children: [
                    Text(
                      '${libro.vistos}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      'Visto',
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w900,
                          color: Colors.black26),
                    ),
                    const SizedBox(width: 30),
                    const Icon(
                      Icons.chevron_right,
                      color: Colors.black26,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
