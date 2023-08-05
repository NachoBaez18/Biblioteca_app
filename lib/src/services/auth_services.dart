import 'dart:convert';
import 'package:biblioteca_app/src/services/push_notification_services.dart';
import 'package:flutter/material.dart';

//Todo: Importaciones de terceros
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// ignore: depend_on_referenced_packages
import 'package:http/http.dart' as http;

//?Mis importaciones
import '../global/enviroment.dart';
import 'package:biblioteca_app/src/models/loginResponse.dart';
import 'package:biblioteca_app/src/models/usuario.dart';

import '../models/usuarioEdicionResponse.dart';

class AuthServices with ChangeNotifier {
  late Usuario usuario;
  bool _autenticando = false;

  bool admin = false;

  // Create storage
  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;
    final data = {
      'email': email,
      'password': password,
      'divice': PushNotificationService.tokenDivice
    };
    final uri = Uri.parse('${Enviroment.apiUrl}/login');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromMap(resp.body);
      usuario = loginResponse.usuario;
      admin = loginResponse.usuario.tipo == "administrador" ? true : false;
      await _guardarToken(loginResponse.token);
      await _guardarUid(loginResponse.usuario.uid!);

      return true;
    } else {
      return false;
    }
  }

  Future register(String nombre, String email, String password) async {
    autenticando = true;
    final data = {
      'nombre': nombre,
      'email': email,
      'password': password,
    };

    final uri = Uri.parse('${Enviroment.apiUrl}/login/new');
    final resp = await http.post(
      uri,
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );
    autenticando = false;
    if (resp.statusCode == 200) {
      final loginResponse = loginResponseFromMap(resp.body);
      usuario = loginResponse.usuario;

      await _guardarToken(loginResponse.token);

      return true;
    } else {
      final respBody = jsonDecode(resp.body);
      return respBody['msg'];
    }
  }

  Future<bool> isLoggedIn() async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      try {
        final uri = Uri.parse('${Enviroment.apiUrl}/login/renew');
        final resp = await http.get(
          uri,
          headers: {
            'Content-Type': 'application/json',
            'x-token': token,
          },
        );
        if (resp.statusCode == 200) {
          final loginResponse = loginResponseFromMap(resp.body);
          usuario = loginResponse.usuario;
          admin = loginResponse.usuario.tipo == "administrador" ? true : false;
          await _guardarToken(loginResponse.token);
          await _guardarUid(loginResponse.usuario.uid!);

          autenticando = false;

          return true;
        } else {
          autenticando = false;
          logout();
          return false;
        }
      } catch (e) {
        return false;
      }
    }
    return false;
  }

  Future<UsuarioEdicionResponse> usuarioUpdate(
      String nombre, String telefono, String email, String uid) async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final data = {
        'uid': uid,
        'nombre': nombre,
        'email': email,
        'telefono': telefono,
      };
      try {
        final uri = Uri.parse('${Enviroment.apiUrl}/login/editar');
        final resp = await http.post(
          uri,
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
            'x-token': token,
          },
        );
        if (resp.statusCode == 200) {
          final UsuarioEdicionResponse updateResponse =
              usuarioEdicionResponseFromMap(resp.body);

          return updateResponse;
        } else {
          throw Exception('Error al actualizar usuario');
        }
      } catch (e) {
        throw Exception(e);
      }
    }
    throw Exception('Favor ingrese sus credenciales');
  }

  Future<UsuarioEdicionResponse> updatePassword(
      String password, String passwordNew, uid) async {
    final token = await _storage.read(key: 'token');

    if (token != null) {
      final data = {
        'uid': uid,
        'password': password,
        'passwordNew': passwordNew,
      };
      try {
        final uri = Uri.parse('${Enviroment.apiUrl}/login/passwordNew');
        final resp = await http.post(
          uri,
          body: jsonEncode(data),
          headers: {
            'Content-Type': 'application/json',
            'x-token': token,
          },
        );
        if (resp.statusCode == 200) {
          final UsuarioEdicionResponse updateResponse =
              usuarioEdicionResponseFromMap(resp.body);
          return updateResponse;
        } else {
          throw Exception('Error al actualizar usuario');
        }
      } catch (e) {
        throw Exception(e);
      }
    }
    throw Exception('Favor ingrese sus credenciales');
  }

  Future _guardarToken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

  Future _guardarUid(String uid) async {
    return await _storage.write(key: 'uid', value: uid);
  }

  Future logout() async {
    return await _storage.delete(key: 'token');
  }
}
