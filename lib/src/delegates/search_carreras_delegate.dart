import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter/material.dart';
import '../models/carreraResponse.dart';
import '../widgets/widgets.dart';

class SearchCarreras extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar Usuario';

  Future<CarreraResponse> _getCarreras() async {
    final carrerasServices = CarreraServices();

    final response = await carrerasServices.carreras();

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
    return FutureBuilder<CarreraResponse>(
      future:
          _getCarreras(), // función asincrónica para cargar todos los libros
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            final List<Carrera> allCarreras = snapshot.data!.carreras;
            final List<Carrera> filteredCarreras = allCarreras
                .where((carrera) =>
                    carrera.nombre.toLowerCase().contains(query.toLowerCase()))
                .toList();

            if (filteredCarreras.isEmpty) {
              return const Center(child: Text('No se encontraron resultados'));
            } else {
              return const ListCarreraWidget();
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
    return FutureBuilder<CarreraResponse>(
      future:
          _getCarreras(), // función asincrónica para cargar todos los libros
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            final List<Carrera> allCarreras = snapshot.data!.carreras;
            final List<Carrera> filteredCarreras = allCarreras
                .where((carrera) =>
                    carrera.nombre.toLowerCase().contains(query.toLowerCase()))
                .toList();

            if (filteredCarreras.isEmpty) {
              return const Center(child: Text('No se encontraron resultados'));
            } else {
              return const ListCarreraWidget();
            }
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
