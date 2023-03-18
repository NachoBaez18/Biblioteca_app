import 'package:flutter/material.dart';

//Todo: Importaciones de terceros

//?Mis importaciones
import 'package:biblioteca_app/src/widgets/widgets.dart';

class BooksListPage extends StatelessWidget {
  const BooksListPage({super.key});

  @override
  Widget build(BuildContext context) {
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
            const FilterListWidget(),
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
