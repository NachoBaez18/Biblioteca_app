import 'package:biblioteca_app/src/models/libroResponse.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/libro.dart';
import '../provider/ListView/filter_provider.dart';

class SearchBook extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar Libro';

  Future<LibroResponse> _getBooks() async {
    final libroServices = LibroServices();

    final LibroResponse response = await libroServices.getsLibros();

    return response;
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final provider = Provider.of<FilterListProvider>(context);
    final user = Provider.of<AuthServices>(context);
    final envio = Provider.of<LibroServices>(context);
    return FutureBuilder<LibroResponse>(
      future: _getBooks(), // función asincrónica para cargar todos los libros
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            final List<Libro> allBooks = snapshot.data!.libros;
            final List<Libro> filteredBooks = allBooks
                .where((book) =>
                    book.nombre.toLowerCase().contains(query.toLowerCase()))
                .toList();

            if (filteredBooks.isEmpty) {
              return const Center(child: Text('No se encontraron resultados'));
            } else {
              return ListView.builder(
                itemCount: filteredBooks.length,
                itemBuilder: (context, index) {
                  final Libro book = filteredBooks[index];
                  return ListTile(
                      title: Text(book.nombre),
                      leading: Image(image: NetworkImage(book.imagen)),
                      onTap: () {
                        if (provider.isDetalle) {
                          if (user.admin) {
                            provider.isEdit = true;
                            envio.selectedLibro = book;
                            Navigator.pushNamed(context, 'book_register_edit');
                          } else {
                            provider.hero = true;
                            Navigator.pushNamed(context, 'book_detail',
                                arguments: {book: book});
                          }
                        }
                      }
                      // () {
                      //   Navigator.pushNamed(context, 'book_detail',
                      //       arguments: {book: book});
                      // },
                      );
                },
              );
            }
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final provider = Provider.of<FilterListProvider>(context);
    final user = Provider.of<AuthServices>(context);
    final envio = Provider.of<LibroServices>(context);
    return FutureBuilder<LibroResponse>(
      future: _getBooks(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final books = snapshot.data!.libros;
          final matchQuery = query.isEmpty
              ? books
              : books
                  .where((book) =>
                      book.nombre.toLowerCase().contains(query.toLowerCase()))
                  .toList();

          if (matchQuery.isNotEmpty) {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: matchQuery.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  onTap: () {
                    if (provider.isDetalle) {
                      if (user.admin) {
                        provider.isEdit = true;
                        envio.selectedLibro = matchQuery[i];
                        Navigator.pushNamed(context, 'book_register_edit');
                      } else {
                        provider.hero = true;
                        Navigator.pushNamed(context, 'book_detail',
                            arguments: {matchQuery[i]: matchQuery[i]});
                      }
                    }
                  },
                  // () {
                  //   Navigator.pushReplacementNamed(context, 'book_detail',
                  //       arguments: {matchQuery[i]: matchQuery[i]});
                  // },
                  child: ListTile(
                    leading: Image(image: NetworkImage(matchQuery[i].imagen)),
                    title: Text(matchQuery[i].nombre),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text('Dato no encontrado'),
            );
          }
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error al cargar los datos'),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}
