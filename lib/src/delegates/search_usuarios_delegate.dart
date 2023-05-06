import 'package:biblioteca_app/src/models/usuarioResponse.dart';
import 'package:biblioteca_app/src/services/services.dart';
import 'package:flutter/material.dart';
import '../widgets/widgets.dart';

class SearchAlumnos extends SearchDelegate {
  @override
  String get searchFieldLabel => 'Buscar Usuario';

  Future<UsuarioResponse> _getUser() async {
    final usuarioServices = UsuarioServices();

    final response = await usuarioServices.usuarios();

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
    return FutureBuilder<UsuarioResponse>(
      future: _getUser(), // función asincrónica para cargar todos los libros
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            final List<Usuario> allUsers = snapshot.data!.usuarios!;
            final List<Usuario> filteredUser = allUsers
                .where((user) =>
                    user.nombre.toLowerCase().contains(query.toLowerCase()))
                .toList();

            if (filteredUser.isEmpty) {
              return const Center(child: Text('No se encontraron resultados'));
            } else {
              return LisAlumnoWidget(
                isFloating: false,
                usuarios: filteredUser,
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
    return FutureBuilder<UsuarioResponse>(
      future: _getUser(), // función asincrónica para cargar todos los libros
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return const Center(child: Text('Error al cargar los datos'));
          } else {
            final List<Usuario> allUsers = snapshot.data!.usuarios!;
            final List<Usuario> filteredUser = allUsers
                .where((user) =>
                    user.nombre.toLowerCase().contains(query.toLowerCase()))
                .toList();

            if (filteredUser.isEmpty) {
              return const Center(child: Text('No se encontraron resultados'));
            } else {
              return LisAlumnoWidget(
                isFloating: false,
                usuarios: filteredUser,
              );
            }
          }
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
