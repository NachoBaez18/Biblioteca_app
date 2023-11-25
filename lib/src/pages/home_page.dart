import 'package:biblioteca_app/src/models/accionLibroResponse.dart';
import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/pages/login_pages.dart';
import 'package:biblioteca_app/src/services/auth_services.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

//Todo: Importaciones de terceros
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:animate_do/animate_do.dart';

//?Mis importaciones
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:provider/provider.dart' as provider;

import '../provider/ListView/filter_provider.dart';
import '../provider/data_provider.dart';

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final Function() onpress;

  ItemBoton(this.icon, this.texto, this.color1, this.color2,
      {required this.onpress});
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, ref) {
    bool isLarge;
    if (MediaQuery.of(context).size.height > 550) {
      isLarge = true;
    } else {
      isLarge = false;
    }
    final auhtService = provider.Provider.of<AuthServices>(context);
    final items = <ItemBoton>[
      ItemBoton(FontAwesomeIcons.magnifyingGlass, 'Buscar Libro',
          const Color(0xff6989F5), const Color(0xff906EF5), onpress: () {
        ref.read(carreraFilterProvider.notifier).update(
            (state) => Carrera(nombre: 'Informatica', uid: '11111111111'));
        ref.refresh(carreraDataProvider);
        ref.read(botonReserva.notifier).state = true;
        Navigator.pushNamed(context, 'books_list');
      }),
      if (!auhtService.admin)
        ItemBoton(
          FontAwesomeIcons.bell,
          'Notificaciones',
          const Color(0xffF2D572),
          const Color(0xffE06AA3),
          onpress: () {
            ref.refresh(notificacionDataProvider);
            Navigator.pushNamed(context, 'notificaciones');
          },
        ),
      ItemBoton(
        FontAwesomeIcons.user,
        'Perfil',
        const Color(0xffcbb4d4),
        const Color(0xff20002c),
        onpress: () {
          Navigator.pushReplacementNamed(context, 'perfil');
        },
      ),
      if (!auhtService.admin)
        ItemBoton(
          FontAwesomeIcons.qrcode,
          'Reservas',
          const Color(0xff317183),
          const Color(0xff46997D),
          onpress: () async {
            final usuario =
                provider.Provider.of<AuthServices>(context, listen: false);
            final titulo = provider.Provider.of<FilterListProvider>(context,
                listen: false);
            titulo.isDetalle = true;
            titulo.reservaDevolucionTitulo
                .addAll({'titulo': 'Reservas', 'subTitulo': 'a generar'});
            ref.read(botonReserva.notifier).state = false;
            ref.read(carreraFilterProvider.notifier).update((state) =>
                Carrera(nombre: 'reservado', uid: usuario.usuario.uid!));
            Navigator.pushReplacementNamed(context, 'reservas');
          },
        ),
      if (!auhtService.admin)
        ItemBoton(
          FontAwesomeIcons.qrcode,
          'Devolucion',
          const Color(0xff94be75),
          const Color(0xff7caabf),
          onpress: () async {
            final titulo = provider.Provider.of<FilterListProvider>(context,
                listen: false);
            titulo.isDetalle = false;
            titulo.reservaDevolucionTitulo
                .addAll({'titulo': 'Pendiente', 'subTitulo': 'a entregar'});
            final usuario =
                provider.Provider.of<AuthServices>(context, listen: false);
            ref.read(botonReserva.notifier).state = false;
            ref.read(carreraFilterProvider.notifier).update((state) =>
                Carrera(nombre: 'entregado', uid: usuario.usuario.uid!));
            Navigator.pushReplacementNamed(context, 'reservas');
          },
        ),
      if (auhtService.admin)
        ItemBoton(
          FontAwesomeIcons.qrcode,
          'Devolucion/Entrega',
          const Color(0xff317183),
          const Color(0xff46997D),
          onpress: () async {
            final valor = provider.Provider.of<FilterListProvider>(context,
                listen: false);
            valor.librosPendientes =
                AccionLibroResponse(error: false, accionesDeLibros: []);
            Navigator.pushNamed(context, 'qrScanner');
          },
        ),
      if (auhtService.admin)
        ItemBoton(
          FontAwesomeIcons.triangleExclamation,
          'Fecha Expirada',
          const Color(0xFFFFCCCB), // Color del lado izquierdo del gradiente
          const Color.fromARGB(255, 218, 56, 56),
          onpress: () async {
            final valor = provider.Provider.of<FilterListProvider>(context,
                listen: false);
            valor.librosPendientes = await LibroServices().gets();
            if (context.mounted) {
              Navigator.pushNamed(context, 'alumnos_expirados');
            }
          },
        ),
      if (auhtService.admin)
        ItemBoton(
          FontAwesomeIcons.gear,
          'Mantenimiento',
          const Color(0xFFd6da9e), // Color del lado izquierdo del gradiente
          const Color(0xFFadb039),
          onpress: () async {
            ref.refresh(usuarioDataProvider);
            ref.refresh(carreraDataProvider);
            final valor = provider.Provider.of<FilterListProvider>(context,
                listen: false);
            valor.isSelectedM = true;
            if (context.mounted) {
              Navigator.pushNamed(context, 'mantenimiento');
            }
          },
        ),
    ];

    List<Widget> itemMap = items
        .map(
          (item) => FadeInLeft(
            child: BotonGordo(
              texto: item.texto,
              onpress: item.onpress,
              icon: item.icon,
              color1: item.color1,
              color2: item.color2,
            ),
          ),
        )
        .toList();

    return Scaffold(
      body: Stack(
        children: [
          Container(
            margin: EdgeInsets.only(top: (isLarge) ? 220 : 10),
            child: SafeArea(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  if (isLarge) const SizedBox(height: 80),
                  ...itemMap,
                ],
              ),
            ),
          ),
          if (isLarge) const _Encabezado()
        ],
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  const _Encabezado({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authService = provider.Provider.of<AuthServices>(context);
    return Stack(
      children: [
        IconHeader(
          icon: FontAwesomeIcons.bookOpenReader,
          titulo: authService.usuario.nombre!,
          subTitulo: 'Bienvenido!',
          color2: const Color(0xff66A9F2),
          color1: const Color(0xff536CF6),
        ),
        Positioned(
            right: 0,
            top: 45,
            child: RawMaterialButton(
              onPressed: () async {
                // final socketService =
                //     provider.Provider.of<SocketService>(context, listen: false);
                // socketService.disconnect();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) =>
                      false, // Eliminar todas las rutas anteriores
                );
                const storage = FlutterSecureStorage();
                await storage.delete(key: 'token');
              },
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(15.0),
              child: const FaIcon(
                FontAwesomeIcons.arrowRightFromBracket,
                color: Colors.white,
                size: 30,
              ),
            ))
      ],
    );
  }
}
