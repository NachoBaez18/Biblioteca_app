import 'package:flutter/material.dart';

//Todo: Importaciones de terceros
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';

//?Mis importaciones
import 'package:biblioteca_app/src/models/libro.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:biblioteca_app/src/ui/alertas.dart';

class BookDetailPage extends StatelessWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<Libro, Libro> mapa =
        ModalRoute.of(context)!.settings.arguments as Map<Libro, Libro>;
    final Libro libro = mapa.values.first;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, 'books_list');
                    },
                    icon: const Icon(
                      Icons.chevron_left,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      mostrarAlerta(
                          context,
                          'Opciones a realizar',
                          SizedBox(
                            height: 130,
                            child: Column(
                              children: [
                                ButtonRedondeado(
                                  onpreess: () {},
                                  texto: 'Realizar reserva',
                                  color: Colors.red,
                                ),
                                const SizedBox(height: 30),
                                ButtonRedondeado(
                                  onpreess: () {},
                                  texto: 'Guardar',
                                ),
                              ],
                            ),
                          ),
                          'Cancelar',
                          '');
                    },
                    icon: const Icon(
                      FontAwesomeIcons.barsStaggered,
                      size: 25,
                    ),
                  ),
                ],
              ),
              Stack(
                children: [
                  _NombreYalgoMasBook(libro),
                  _ImageBook(libro),
                  Positioned(
                    left: 60,
                    top: 300,
                    right: 15,
                    child: SizedBox(
                      height: 450,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              IconButton(
                                onPressed: () async {
                                  await Share.share(libro.nombre,
                                      subject: 'No se que seria');
                                },
                                icon: const Icon(Icons.share),
                                color: Colors.black26,
                              ),
                              const Text(
                                'Compartir',
                                style: TextStyle(color: Colors.black26),
                              ),
                              const SizedBox(width: 20),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  FontAwesomeIcons.solidHeart,
                                  color: Colors.black26,
                                ),
                              ),
                              const Text(
                                'Me gusta',
                                style: TextStyle(color: Colors.black26),
                              ),
                            ],
                          ),
                          Container(
                            height: 2,
                            width: 340,
                            color: Colors.grey[300],
                          ),
                          const SizedBox(height: 30),
                          const Text(
                            'Descripcion Libro',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 15),
                          Text(
                            libro.descripcion,
                            style: const TextStyle(
                              color: Colors.black26,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _ImageBook extends StatelessWidget {
  final Libro libro;
  const _ImageBook(
    this.libro, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 20,
      child: Hero(
        tag: 'dash${libro.uid}',
        child: SizedBox(
          height: 250,
          width: 170,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: FadeInImage(
              placeholder: const AssetImage('assets/jar-loading.gif'),
              image: NetworkImage(libro.imagen),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ),
    );
  }
}

class _NombreYalgoMasBook extends StatelessWidget {
  final Libro libro;
  const _NombreYalgoMasBook(
    this.libro, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 42, top: 70),
      height: MediaQuery.of(context).size.height * 0.82,
      width: MediaQuery.of(context).size.width * 0.9,
      color: Colors.grey[100],
      child: Container(
        margin: const EdgeInsets.only(left: 160, top: 70, right: 70),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              libro.nombre,
              maxLines: 2,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text(
              libro.creador,
              style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 20),
            const StarIcons(3),
          ],
        ),
      ),
    );
  }
}
