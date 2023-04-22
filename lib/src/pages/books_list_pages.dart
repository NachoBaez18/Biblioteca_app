import 'package:biblioteca_app/src/provider/ListView/filter_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Todo: Importaciones de terceros

//?Mis importaciones
import 'package:biblioteca_app/src/widgets/widgets.dart';
import '../services/services.dart';
import 'package:biblioteca_app/src/models/libro.dart';

class BooksListPage extends StatelessWidget {
  const BooksListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AuthServices>(context);
    final circular = Provider.of<FilterListProvider>(context);
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          Navigator.pushReplacementNamed(context, 'home');
          return false;
        },
        child: SafeArea(
          child: circular.isCircularProgress
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: const [
                    SizedBox(height: 15),
                    HeaderList(
                      titulo: 'Navegador',
                      subtitulo: 'Recomendadas',
                      search: true,
                    ),
                    SizedBox(height: 15),
                    FilterListWidget(),
                    ListBooks()
                  ],
                ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: provider.admin,
        child: FloatingActionButton(
          onPressed: () {
            final libroServices =
                Provider.of<LibroServices>(context, listen: false);

            libroServices.selectedLibro = Libro(
                nombre: '',
                creador: '',
                carrera: '',
                descripcion: '',
                imagen: '',
                vistos: 0,
                like: 0,
                cantidad: 0,
                uid: '');

            Navigator.pushNamed(context, 'book_register_edit');
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
