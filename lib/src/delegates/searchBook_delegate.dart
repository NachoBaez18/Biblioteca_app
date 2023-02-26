import 'package:flutter/material.dart';

class SearchBook extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar Libro';

  List<String> books = [
    'Libro 1',
    'Libro 2',
    'Libro 3',
    'Libro 4',
    'Libro 5',
    'Libro 6',
  ];
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
    List<String> matchQuery = [];

    for (var book in books) {
      if (book.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(book);
      }
    }

    if (matchQuery.isNotEmpty) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: matchQuery.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: const Image(image: AssetImage('assets/image2.jpg')),
            title: Text(matchQuery[i]),
          );
        },
      );
    } else {
      return const Center(
        child: Text('Dato no encontrado'),
      );
    }
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];

    for (var book in books) {
      if (book.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(book);
      }
    }

    if (matchQuery.isNotEmpty) {
      return ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: matchQuery.length,
        itemBuilder: (context, i) {
          return ListTile(
            leading: const Image(image: AssetImage('assets/image2.jpg')),
            title: Text(matchQuery[i]),
          );
        },
      );
    } else {
      return const Center(
        child: Text('Dato no encontrado'),
      );
    }
  }
}
