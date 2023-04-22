import 'package:biblioteca_app/src/provider/provider.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as p;

class DetallePendiente extends ConsumerWidget {
  const DetallePendiente({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final provider = p.Provider.of<FilterListProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        provider.isDetalle = true;
        Navigator.pop(context);
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: const [
              HeaderList(
                titulo: 'Pendientes',
                subtitulo: 'A realizar accion',
                search: false,
              ),
              ListBooks()
            ],
          ),
        ),
      ),
    );
  }
}
