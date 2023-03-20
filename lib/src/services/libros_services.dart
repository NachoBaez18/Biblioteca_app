import 'dart:convert';
import 'dart:io';

import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:biblioteca_app/src/models/libroResponse.dart';
import 'package:biblioteca_app/src/models/registerUpdateDeleteResponse.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:biblioteca_app/src/models/libro.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' as Riverpod;

import 'package:http/http.dart' as http;

import '../global/enviroment.dart';

class LibroServices with ChangeNotifier {
  late LibroResponse libro;
  late OperationResponse operacion;
  final _storage = const FlutterSecureStorage();
  late Libro selectedLibro;
  bool isSaving = false;
  File? newPictureFile;

  Future<LibroResponse?> gets() async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });

      if (resp.statusCode == 200) {
        print(resp.body);
        libro = libroResponseFromMap(resp.body);
        return libro;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    return null;
  }

  Future<LibroResponse?> get(Carrera carrera) async {
    final token = await _storage.read(key: 'token');
    print('Con que va a filtrar${carrera.nombre}');
    final LibroResponse libros;
    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/listar');
      print(jsonEncode(carrera.toMap()));
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
    return null;
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
        print(resp.body);
        operacion = operationResponseFromMap(resp.body);
        isSaving = true;
        return operacion;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    return null;
  }

  Future<OperationResponse?> editar(Libro libro) async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/libros/editar');
      final resp = await http.post(
        uri,
        body: jsonEncode(libro),
        headers: {
          'Content-Type': 'application/json',
          'x-token': token,
        },
      );

      if (resp.statusCode == 200) {
        print(resp.body);
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
        print(resp.body);
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
    print('estamos uploadImage');
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
      print('algo salio mal');
      print(resp.body);
      return null;
    }

    newPictureFile = null;

    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
  }
}

final libroProvider =
    Riverpod.Provider<LibroServices>((ref) => LibroServices());
