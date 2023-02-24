import 'package:animate_do/animate_do.dart';
import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:biblioteca_app/src/widgets/rotate_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
    );
  }
}

class _ListBooks extends StatelessWidget {
  final List<String> items;
  const _ListBooks({super.key, required this.items});

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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 30),
                      height: 250,
                      width: 200,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 25,
                    child: RotateAnimation(
                      controller: (controller) {
                        Provider.of<FilterListProvider>(context, listen: false)
                            .controllerRotar = controller;
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        height: 200,
                        width: 170,
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    ));
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
    return Container(
      height: 30,
      margin: const EdgeInsets.only(left: 10),
      child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          itemBuilder: (_, int i) {
            return _ItemFilter(items[i], i);
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
      child: GestureDetector(
        onTap: () {
          filteSelected.controllerRotar.forward(from: 0.0);
          filteSelected.filter = i;
        },
        child: Container(
          margin: const EdgeInsets.only(left: 10),
          height: 30,
          width: item.length * 10.0,
          decoration: BoxDecoration(
            color:
                filteSelected.filter == i ? Colors.blue[300] : Colors.grey[300],
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
      children: const [
        Text(
          'Browse',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
        ),
        Text(
          'Recommended',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black38),
        ),
        Icon(
          Icons.search,
          size: 30,
        )
      ],
    );
  }
}
