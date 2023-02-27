import 'package:animate_do/animate_do.dart';
import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:biblioteca_app/src/widgets/rotate_widget.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../delegates/searchBook_delegate.dart';

class BooksListPage extends StatelessWidget {
  const BooksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      'Administracion',
      'History',
      'Fisica',
      'Psicologia',
      'Nutricion',
      'Medicina',
      'Enfermeria',
      'Odontologia',
      'Contaduria',
    ];
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 15),
            const _HeaderList(),
            const SizedBox(height: 15),
            _ListFilterMaterial(items: items),
            _ListBooks(items: items)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, 'book_register_edit');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ListBooks extends StatelessWidget {
  final List<String> items;
  const _ListBooks({required this.items});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: items.length,
          itemBuilder: (_, int i) {
            return FadeInLeft(
              child: _ListBooksinAnimation(i),
            );
          }),
    ));
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

class _ListFilterMaterial extends StatelessWidget {
  const _ListFilterMaterial({
    Key? key,
    required this.items,
  }) : super(key: key);

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final filter = Provider.of<FilterListProvider>(context, listen: false);
    return Container(
      height: 30,
      margin: const EdgeInsets.only(left: 10),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (_, int i) {
            return GestureDetector(
              onTap: () {
                filter.filter = i;
                filter.rotate = true;
                Future.delayed(const Duration(milliseconds: 500),
                    () => filter.rotate = false);
              },
              child: _ItemFilter(items[i], i),
            );
          }),
    );
  }
}

class _ItemFilter extends StatelessWidget {
  final String item;
  final int i;

  const _ItemFilter(
    this.item,
    this.i,
  );

  @override
  Widget build(BuildContext context) {
    final filteSelected = Provider.of<FilterListProvider>(context);
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 30,
        width: item.length * 10.0,
        decoration: BoxDecoration(
          color: filteSelected.filter == i ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
            child: Text(
          item,
          style: TextStyle(
              color: filteSelected.filter == i ? Colors.white : Colors.grey,
              fontWeight: FontWeight.bold),
        )),
      ),
    );
  }
}

class _HeaderList extends StatelessWidget {
  const _HeaderList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text(
          'Navegador',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        const Text(
          'Recomendadas',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),
        ),
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
