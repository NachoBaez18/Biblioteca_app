import 'package:animated_icon_button/animated_icon_button.dart';
import 'package:flutter/material.dart';
//Todo: Importaciones de terceros
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;
//?Mis importaciones
import '../models/libro.dart';
import '../widgets/widgets.dart';
import '../ui/alertas.dart';
import '../models/carreraResponse.dart';
import '../provider/data_provider.dart';
import '../provider/provider.dart';
import '../services/services.dart';
import '../ui/alertas_new.dart';

class BookDetailPage extends ConsumerWidget {
  const BookDetailPage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final reserva = ref.watch(botonReserva);

    final Map<Libro, Libro> mapa =
        ModalRoute.of(context)!.settings.arguments as Map<Libro, Libro>;
    final Libro libro = mapa.values.first;
    final user = provider.Provider.of<AuthServices>(context);
    return WillPopScope(
      onWillPop: () async {
        final libroServices = LibroServices();

        await libroServices.vistoLibro(libro.uid, user.usuario.uid!);
        ref.refresh(libroDataProvider);
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () async {
                        final libroServices = LibroServices();
                        await libroServices.vistoLibro(
                            libro.uid, user.usuario.uid!);
                        if (context.mounted) {
                          ref.refresh(libroDataProvider);
                          Navigator.pop(context);
                        }
                      },
                      icon: const Icon(
                        Icons.chevron_left,
                        size: 40,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        final Color colorReserva =
                            libro.cantidad > 0 ? Colors.green : Colors.grey;
                        mostrarAlerta(
                            context,
                            'Opciones a realizar',
                            SizedBox(
                              height: 60,
                              child: Column(
                                children: [
                                  ButtonRedondeado(
                                    onpreess: () async {
                                      if (libro.cantidad > 0) {
                                        await _reservarOrEliminar(
                                            context, ref, libro.uid);
                                      }
                                    },
                                    texto: reserva
                                        ? 'Realizar reserva'
                                        : 'Eliminar reserva',
                                    color: reserva ? colorReserva : Colors.red,
                                  ),
                                ],
                              ),
                            ),
                            'Cancelar',
                            '',
                            () {});
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
                                GestureDetector(
                                  onTap: () async {
                                    await Share.share(libro.nombre,
                                        subject: 'No se que seria');
                                  },
                                  child: const Text(
                                    'Compartir',
                                    style: TextStyle(color: Colors.black26),
                                  ),
                                ),
                                const SizedBox(width: 20),
                                AnimatedIconButton(
                                  size: 25,
                                  onPressed: () async {
                                    _accionLike(context, libro);
                                  },
                                  duration: const Duration(milliseconds: 500),
                                  splashColor: Colors.transparent,
                                  icons: libro.like!.contains(user.usuario.uid)
                                      ? const <AnimatedIconItem>[
                                          AnimatedIconItem(
                                            icon: Icon(
                                                FontAwesomeIcons.solidHeart,
                                                color: Colors.red),
                                          ),
                                          AnimatedIconItem(
                                            icon: Icon(
                                                FontAwesomeIcons.solidHeart,
                                                color: Colors.grey),
                                          ),
                                        ]
                                      : const <AnimatedIconItem>[
                                          AnimatedIconItem(
                                            icon: Icon(
                                                FontAwesomeIcons.solidHeart,
                                                color: Colors.grey),
                                          ),
                                          AnimatedIconItem(
                                            icon: Icon(
                                                FontAwesomeIcons.solidHeart,
                                                color: Colors.red),
                                          ),
                                        ],
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
      ),
    );
  }

  _reservarOrEliminar(context, ref, libro) async {
    final reserva = ref.watch(botonReserva);
    final providerD =
        provider.Provider.of<LibroServices>(context, listen: false);
    final String navegar;

    if (reserva) {
      print('presionamos reservar');
      //editar or registrar reserva
      navegar = 'books_list';
      final response = await providerD.realizarAccion(libro, context);
      if (!response['error']) {
        AlertasNew()
            .alertaCorrectaNavegatoria(context, response['mensaje'], navegar);
        _regresarHome(ref, context);
      } else {
        AlertasNew()
            .alertaInCorrectaNavegatoria(context, response['mensaje'], navegar);
        _regresarHome(ref, context);
      }
    } else {
      //eliminacion de libro en reserva
      navegar = 'reservas';
      final response = await providerD.elimarAccion(libro, context);
      if (!response['error']) {
        AlertasNew()
            .alertaCorrectaNavegatoria(context, response['mensaje'], navegar);
        _regresarReserva(ref, context);
      } else {
        AlertasNew()
            .alertaInCorrectaNavegatoria(context, response['mensaje'], navegar);
        _regresarReserva(ref, context);
      }
    }
  }

  _regresarHome(ref, context) {
    //!aqui cambiamos el estado de los proveedores para saber que va a mostrar
    final filter =
        provider.Provider.of<FilterListProvider>(context, listen: false);
    ref
        .read(carreraFilterProvider.notifier)
        .update((state) => Carrera(nombre: 'Informatica', uid: '11111111111'));
    filter.filter = 0;
  }

  _regresarReserva(ref, context) {
    //!aqui cambiamos el estado de los proveedores para saber que va a mostrar
    final usuario = provider.Provider.of<AuthServices>(context, listen: false);
    ref.read(carreraFilterProvider.notifier).update(
        (state) => Carrera(nombre: 'reservado', uid: usuario.usuario.uid!));
  }

  _accionLike(BuildContext context, Libro libro) async {
    final user = provider.Provider.of<AuthServices>(context, listen: false);
    final libroServices = LibroServices();

    await libroServices.likeLibro(libro.uid, user.usuario.uid!);
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
    final porcentaje = libro.vistos!.isNotEmpty && libro.like!.isNotEmpty
        ? (libro.vistos!.length / libro.like!.length) * 100
        : 0;
    final double stars = (porcentaje * 5) / 100;
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
            StarIcons(stars),
          ],
        ),
      ),
    );
  }
}
