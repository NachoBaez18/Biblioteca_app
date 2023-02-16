import 'package:flutter/material.dart';

class BooksListPage extends StatelessWidget {
  const BooksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      'History',
      'History',
      'History',
      'History',
      'History',
      'History',
      'History',
      'History',
      'History'
    ];
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          const SizedBox(height: 15),
          const _HeaderList(),
          const SizedBox(height: 15),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              itemBuilder: (_, int i) => _ItemFilter(items[1]),
            ),
          )
        ],
      ),
    ));
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
        width: 80,
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
