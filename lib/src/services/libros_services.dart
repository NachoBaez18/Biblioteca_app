import 'dart:convert';
import 'dart:io';

import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/models/libroResponse.dart';
import 'package:biblioteca_app/src/models/registerUpdateDeleteResponse.dart';
import 'package:biblioteca_app/src/models/usuario.dart';
import 'package:biblioteca_app/src/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:biblioteca_app/src/models/libro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as riverpod;

import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../global/enviroment.dart';
import '../models/accionLibroResponse.dart';

class LibroServices with ChangeNotifier {
  late LibroResponse libro;
  late OperationResponse operacion;
  final _storage = const FlutterSecureStorage();
  late Libro selectedLibro;
  String reservado = '';
  bool isSaving = false;
  File? newPictureFile;

  Future<AccionLibroResponse> gets() async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/accionLibro/');
      final resp = await http.post(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      if (resp.statusCode == 200) {
        final AccionLibroResponse accion =
            accionLibroResponseFromMap(resp.body);
        return accion;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Ingrese sus credenciales');
  }

  Future<LibroResponse> getsLibros() async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/');
      final resp = await http.post(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      if (resp.statusCode == 200) {
        final LibroResponse libroResponse = libroResponseFromMap(resp.body);
        return libroResponse;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Ingrese sus credenciales');
  }

  Future<LibroResponse> get(Carrera carrera) async {
    final token = await _storage.read(key: 'token');
    final LibroResponse libros;
    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/listar');
      final resp =
          await http.post(uri, body: jsonEncode(carrera.toMap()), headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      if (resp.statusCode == 200) {
        libros = libroResponseFromMap((resp.body));
        return libros;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Por favor agregue sus credenciales');
  }

  Future<OperationResponse?> registrar(Libro libro) async {
    final token = await _storage.read(key: 'token');
    isSaving = true;
    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/registrar');
      final resp = await http.post(
        uri,
        body: jsonEncode(libro.toMap()),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );

      if (resp.statusCode == 200) {
        operacion = operationResponseFromMap(resp.body);
        isSaving = true;
        return operacion;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    return null;
  }

  Future<Map<dynamic, dynamic>> accionRealizada(
      String accion, String uid) async {
    final token = await _storage.read(key: 'token');
    isSaving = true;
    if (token != null) {
      final data = {'accion': accion, 'uid': uid};
      final uri = Uri.parse('${Enviroment.apiUrl}/accionLibro/editar');
      final resp = await http.post(
        uri,
        body: jsonEncode(data),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );

      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Autentiquese');
  }

  Future<OperationResponse?> editar(Libro libro) async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/editar');
      final resp = await http.post(
        uri,
        body: jsonEncode(libro.toMap()),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );

      if (resp.statusCode == 200) {
        operacion = operationResponseFromMap(resp.body);
        return operacion;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    return null;
  }

  Future<OperationResponse?> eliminar(Libro libro) async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/eliminar');
      final resp = await http.post(
        uri,
        body: jsonEncode(libro),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );

      if (resp.statusCode == 200) {
        operacion = operationResponseFromMap(resp.body);
        return operacion;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    return null;
  }

  void updateSelectedProductImage(String path) {
    selectedLibro.imagen = path;
    newPictureFile = File.fromUri(Uri(path: path));

    notifyListeners();
  }

  Future saveOrCreate(Libro libro) async {
    isSaving = true;
    notifyListeners();
    if (libro.uid.isEmpty) {
      isSaving = false;
      notifyListeners();
      return await registrar(libro);
    } else {
      isSaving = false;
      notifyListeners();
      return await editar(libro);
    }
  }

  Future<String?> uploadImage() async {
    if (newPictureFile == null) return null;

    //this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/dytahi5v6/image/upload?upload_preset=st0yazrf');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      return null;
    }

    newPictureFile = null;

    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }

  Future<AccionLibroResponse> accionLibrosXusuario(Carrera datosFiltros) async {
    final token = await _storage.read(key: 'token');
    final AccionLibroResponse accionesLibro;
    final data = {
      'tipoFiltro': 'accionXusuario',
      'usuario': datosFiltros.uid,
      'accion': datosFiltros.nombre
    };
    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/accionLibro/listar');
      final resp = await http.post(uri, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      if (resp.statusCode == 200) {
        accionesLibro = accionLibroResponseFromMap(resp.body);
        return accionesLibro;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Favor vuelva a ingresar sus credenciales');
  }

  Future<AccionLibroResponse> libroDinamico(Carrera datafiltro) async {
    final AccionesDeLibro dataArmado;

    try {
      if (datafiltro.nombre == 'reservado' ||
          datafiltro.nombre == 'entregado' ||
          datafiltro.nombre == 'devolucion') {
        final response = await accionLibrosXusuario(datafiltro);

        if (response.accionesDeLibros.isNotEmpty) {
          reservado = response.accionesDeLibros[0].uid ?? '';
          return response;
        } else {
          final data = AccionLibroResponse(
              error: false, accionesDeLibros: [AccionesDeLibro(libro: [])]);
          return data;
        }
      } else {
        //?Respuesta armada cuando seria para lista de libros normales
        final LibroResponse response = await get(datafiltro);
        if (!response.error) {
          dataArmado = AccionesDeLibro(
              accion: '',
              usuario: null,
              libro: response.libros,
              fecha: null,
              deletedAt: null,
              uid: null);

          final AccionLibroResponse responseFinal =
              AccionLibroResponse(error: false, accionesDeLibros: [dataArmado]);
          return responseFinal;
        } else {
          throw Exception('No exiten datos');
        }
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<dynamic> realizarAccion(String libro, context) async {
    final Usuario usuario =
        Provider.of<AuthServices>(context, listen: false).usuario;
    final token = await _storage.read(key: 'token');

    final data = {'usuario': usuario.uid, 'libro': libro};

    if (token != null) {
      final uri =
          Uri.parse('${Enviroment.apiUrl}/accionLibro/registrarOrEditar');
      final resp = await http.post(uri, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });

      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Favor vuelva a ingresar sus credenciales');
  }

  Future<dynamic> elimarAccion(String libro, context) async {
    final Usuario usuario =
        Provider.of<AuthServices>(context, listen: false).usuario;
    final token = await _storage.read(key: 'token');
    final data = {'usuario': usuario.uid, 'libro': libro};
    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/accionLibro/elimiarOrEditar');
      final resp = await http.post(uri, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Favor vuelva a ingresar sus credenciales');
  }

  Future likeLibro(String uid, String usuario) async {
    final token = await _storage.read(key: 'token');
    if (token != null) {
      final data = {'uid': uid, 'usuario': usuario};
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/editarLibroCorazon');
      final resp = await http.post(uri, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Favor vuelva a ingresar sus credenciales');
  }

  Future vistoLibro(String uid, String usuario) async {
    final token = await _storage.read(key: 'token');
    if (token != null) {
      final data = {'uid': uid, 'usuario': usuario};
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/vistoLibro');
      final resp = await http.post(uri, body: jsonEncode(data), headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      print(resp.body);
      if (resp.statusCode == 200) {
        return jsonDecode(resp.body);
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Favor vuelva a ingresar sus credenciales');
  }
}

final libroProvider =
    riverpod.Provider<LibroServices>((ref) => LibroServices());
