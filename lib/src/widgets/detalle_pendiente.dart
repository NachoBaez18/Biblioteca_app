import 'dart:convert';

import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../provider/data_provider.dart';

class DetallePendiente extends ConsumerWidget {
  const DetallePendiente({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final libros = ref.watch(libroDataProvider);
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: Column(
          children: const [
            HeaderList(
              titulo: 'Pendientes',
              subtitulo: 'A entregar',
              search: false,
            ),
            ListBooks()
          ],
        ),
      ),
    );
  }
}
