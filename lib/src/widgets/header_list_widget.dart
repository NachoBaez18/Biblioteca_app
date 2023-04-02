import 'package:flutter/material.dart';

//?Mis importaciones
import 'package:biblioteca_app/src/delegates/searchBook_delegate.dart';

class HeaderList extends StatelessWidget {
  final String titulo;
  final String subtitulo;
  final bool search;
  const HeaderList({
    Key? key,
    required this.titulo,
    required this.subtitulo,
    required this.search,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          titulo,
          style: const TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        Text(
          subtitulo,
          style: const TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),
        ),
        if (search)
          IconButton(
            icon: const Icon(
              Icons.search,
              size: 30,
            ),
            onPressed: () {
              showSearch(context: context, delegate: SearchBook());
            },
          )
      ],
    );
  }
}
