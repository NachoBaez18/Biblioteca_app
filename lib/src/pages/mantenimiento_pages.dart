import 'package:biblioteca_app/src/delegates/search_carreras_delegate.dart';
import 'package:biblioteca_app/src/provider/provider.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../delegates/search_usuarios_delegate.dart';

class MatenimientoPage extends StatelessWidget {
  const MatenimientoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<FilterListProvider>(context);
    return Scaffold(
      appBar: appBarDesing(
          'Mantenimiento',
          [
            const Color(0xFFd6da9e), // Color del lado izquierdo del gradiente
            const Color(0xFFadb039),
          ],
          true, () {
        if (provider.isSelectedM) {
          showSearch(context: context, delegate: SearchAlumnos());
        } else {
          showSearch(context: context, delegate: SearchCarreras());
        }
      }),
      body: Column(
        children: [
          Row(
            children: [
              _Selector(
                  titulo: 'Usuario',
                  onTap: () {
                    provider.isSelectedM = true;
                  },
                  isSelect: provider.isSelectedM),
              _Selector(
                  titulo: 'Carrera',
                  onTap: () {
                    provider.isSelectedM = false;
                  },
                  isSelect: !provider.isSelectedM)
            ],
          ),
          Expanded(
              child: ListMantenimiento(
            isView: provider.isSelectedM,
          ))
        ],
      ),
    );
  }
}

class _Selector extends StatelessWidget {
  final String titulo;
  final Function() onTap;
  final bool isSelect;
  const _Selector(
      {required this.titulo, required this.onTap, required this.isSelect});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: 70,
        decoration: BoxDecoration(
          gradient: isSelect
              ? const LinearGradient(
                  colors: [
                    Color(0xFFd6da9e), // Color del lado izquierdo del gradiente
                    Color(0xFFadb039),
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.bottomRight,
                )
              : LinearGradient(
                  colors: [Colors.grey.shade300, Colors.grey.shade300]),
        ),
        child: Center(
          child: Text(
            titulo,
            style: TextStyle(
                color: isSelect ? Colors.white : Colors.black38,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
