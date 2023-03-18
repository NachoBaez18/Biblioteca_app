import 'package:biblioteca_app/src/widgets/list_books_widget.dart';
import 'package:flutter/material.dart';

//Todo: Importaciones de terceros
import 'package:provider/provider.dart';
import 'package:animate_do/animate_do.dart';

//?Mis importaciones
import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:biblioteca_app/src/widgets/widgets.dart';

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
            const HeaderList(
              titulo: 'Navegador',
              subtitulo: 'Recomendadas',
            ),
            const SizedBox(height: 15),
            FilterListWidget(),
            ListBooks()
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
