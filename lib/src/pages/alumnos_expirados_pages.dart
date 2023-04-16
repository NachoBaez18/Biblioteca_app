import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as p;
import '../models/accionLibroResponse.dart';

import '../provider/provider.dart';

class AlumnosExpirado extends ConsumerWidget {
  const AlumnosExpirado({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final provider = p.Provider.of<FilterListProvider>(context);
    final AccionLibroResponse libroPendientes = provider.librosPendientes;
    return AlumnoList(
        qr: false,
        ref: ref,
        titleAppbar: 'Pendientes',
        colorAppbar: const [
          Color(0xFFFFCCCB), // Color del lado izquierdo del gradiente
          Color.fromARGB(255, 218, 56, 56)
        ],
        libroPendientes: libroPendientes);
  }
}
