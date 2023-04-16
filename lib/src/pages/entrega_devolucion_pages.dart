import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as p;
import '../models/accionLibroResponse.dart';

import '../provider/provider.dart';

class EntregaDevolucion extends ConsumerWidget {
  const EntregaDevolucion({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final provider = p.Provider.of<FilterListProvider>(context);
    final AccionLibroResponse libroPendientes = provider.librosPendientes;
    return AlumnoList(
        qr: false,
        ref: ref,
        titleAppbar: 'Libros Acciones',
        colorAppbar: const [
          Color(0xff317183),
          Color(0xff46997D),
        ],
        libroPendientes: libroPendientes);
  }
}
