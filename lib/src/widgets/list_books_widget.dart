import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:biblioteca_app/src/provider/data_provider.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';

//todo: Importaciones de terceros
import 'package:animate_do/animate_do.dart';
import 'package:provider/provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as Riverpod;

class ListBooks extends Riverpod.ConsumerWidget {
  const ListBooks({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final libros = ref.watch(libroDataProvider);
    return libros.when(
      data: (libros) {
        return libros!.libros.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(height: 200),
                    Text(
                      'No existen datos',
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            : Expanded(
                child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: libros.libros.length,
                    itemBuilder: (_, int i) {
                      return _ListBooksinAnimation(i);
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
  final int i;
  const _ListBooksinAnimation(
    this.i, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final animation = Provider.of<FilterListProvider>(context);
    return Stack(
      children: [
        Align(
          alignment: Alignment.centerRight,
          child: _CardPrimario(i),
        ),
        Positioned(
          left: 30,
          top: 25,
          child: animation.rotate
              ? const RotateAnimation(
                  child: _CardSecuandario(),
                )
              : const _CardSecuandario(),
        )
      ],
    );
  }
}

class _CardPrimario extends StatelessWidget {
  final int i;
  const _CardPrimario(
    this.i, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, 'book_detail');
      },
      child: Hero(
        tag: 'dash$i',
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 30),
          height: 250,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: const DecorationImage(
                fit: BoxFit.fill,
                image: AssetImage('assets/image1.jpg'),
              )),
        ),
      ),
    );
  }
}

class _CardSecuandario extends StatelessWidget {
  const _CardSecuandario({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Storia dei Fantasmi',
              maxLines: 2,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 5),
            const Text(
              'By Nombre Autor',
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black26),
              textAlign: TextAlign.start,
            ),
            const SizedBox(height: 25),
            const StarIcons(3),
            const SizedBox(height: 30),
            Row(
              children: const [
                Text(
                  '1125',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w900,
                    color: Colors.blue,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'Visto',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w900,
                      color: Colors.black26),
                ),
                SizedBox(width: 30),
                Icon(
                  Icons.chevron_right,
                  color: Colors.black26,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
