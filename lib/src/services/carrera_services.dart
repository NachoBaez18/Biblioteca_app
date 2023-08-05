import 'dart:convert';

import 'package:biblioteca_app/src/models/carreraResponse.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:http/http.dart' as http;

import '../global/enviroment.dart';

class CarreraServices {
  late CarreraResponse carrera;

  final _storage = const FlutterSecureStorage();

  Future<CarreraResponse> carreras() async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final uri = Uri.parse('${Enviroment.apiUrl}/carreras/listar');
      final resp = await http.get(uri, headers: {
        'Content-Type': 'application/json',
        'x-token': token,
      });
      if (resp.statusCode == 200) {
        carrera = carreraResponseFromMap(resp.body);
        return carrera;
      } else {
        throw Exception(resp.reasonPhrase);
      }
    }
    throw Exception('Error autentiquese');
  }

  Future<Map<String, dynamic>> eliminar(String uid) async {
    final token = await _storage.read(key: 'token');

    try {
      if (token != null) {
        final uri = Uri.parse('${Enviroment.apiUrl}/carreras/eliminar');
        final resp = await http.post(uri,
            body: jsonEncode({
              'uid': uid,
            }),
            headers: {
              'Content-Type': 'application/json',
              'x-token': token,
            });
        if (resp.statusCode == 200) {
          return jsonDecode(resp.body);
        } else {
          return {'error': true, 'mensaje': 'Ocurrio un error inesperado'};
        }
      }
      return {'error': true, 'mensaje': 'Ocurrio un error inesperado'};
    } catch (e) {
      return {'error': true, 'mensaje': 'Ocurrio un error inesperado'};
    }
  }

  Future<Map<String, dynamic>> registrar(String nombre) async {
    final token = await _storage.read(key: 'token');

    try {
      if (token != null) {
        final uri = Uri.parse('${Enviroment.apiUrl}/carreras/registrar');
        final resp = await http.post(uri,
            body: jsonEncode({
              'nombre': nombre,
            }),
            headers: {
              'Content-Type': 'application/json',
              'x-token': token,
            });
        if (resp.statusCode == 200) {
          return jsonDecode(resp.body);
        } else {
          return {'error': true, 'mensaje': 'Ocurrio un error inesperado'};
        }
      }
      return {'error': true, 'mensaje': 'Ocurrio un error inesperado'};
    } catch (e) {
      return {'error': true, 'mensaje': 'Ocurrio un error inesperado'};
    }
  }

  Future<Map<String, dynamic>> editar(String uid, String nombre) async {
    final token = await _storage.read(key: 'token');

    try {
      if (token != null) {
        final uri = Uri.parse('${Enviroment.apiUrl}/carreras/editar');
        final resp = await http.post(uri,
            body: jsonEncode({
              'uid': uid,
              'nombre': nombre,
            }),
            headers: {
              'Content-Type': 'application/json',
              'x-token': token,
            });
        if (resp.statusCode == 200) {
          return jsonDecode(resp.body);
        } else {
          return {'error': true, 'mensaje': 'Ocurrio un error inesperado'};
        }
      }
      return {'error': true, 'mensaje': 'Ocurrio un error inesperado'};
    } catch (e) {
      return {'error': true, 'mensaje': 'Ocurrio un error inesperado'};
    }
  }
}

final carreraProvider = Provider<CarreraServices>((ref) => CarreraServices());
