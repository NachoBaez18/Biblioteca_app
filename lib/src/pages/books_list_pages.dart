import 'package:flutter/material.dart';

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
          Expanded(
              child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: items.length,
                itemBuilder: (_, int i) => Stack(
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
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            height: 200,
                            width: 170,
                            decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        )
                      ],
                    )),
          ))
        ],
      ),
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
        itemBuilder: (_, int i) => _ItemFilter(items[i]),
      ),
    );
  }
}

class _ItemFilter extends StatelessWidget {
  final String item;
  const _ItemFilter(
    this.item, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 10),
        height: 30,
        width: item.length * 10.0,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
            child: Text(
          item,
          style:
              const TextStyle(color: Colors.grey, fontWeight: FontWeight.bold),
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
